package main.cars.car.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import main.cars.car.models.*;
import main.cars.car.models.response.ScrapDataPy;
import main.cars.car.models.response.ScrapPy;
import main.cars.car.repositories.*;
import main.cars.config.UserDetailsImpl;
import main.cars.config.exception.CarException;
import main.cars.config.exception.CarImportException;
import main.cars.models.Admin;
import main.cars.repositories.AdminRepository;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.*;
import java.net.URI;
import java.net.URISyntaxException;
import java.time.*;
import java.util.*;
import java.util.concurrent.TimeUnit;

@RequiredArgsConstructor
@Service
public class ScrapService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ScrapService.class);


    private static final String CARFAX_KEY = "carfax";
    private static final String FETCH_PY_URL = "https://function-fetch-py.azurewebsites.net/api/OpenLane?from=%s";
//    private static final String FETCH_PY_URL = "http://localhost:7071/api/OpenLane?from=%s";

    private final MakerRepository makerRepository;
    private final ModelRepository modelRepository;
    private final FeatureCategoryRepository featureCategoryRepository;
    private final FeatureRepository featureRepository;
    private final OfferRepository offerRepository;
    private final AdminRepository adminRepository;
    private final ImageRepository imageRepository;
    private final OfferClusterRepository offerClusterRepository;

    private final BlobStorage blobStorage;


    public Offer saveCarDateFromOpenlane(UserDetailsImpl userDetails, String baseUrl) {
        baseUrl = baseUrl.trim();
        Offer resultOffer = null;
        String hostUrl = this.validateUrlAndReturnHost(baseUrl);

        if (hostUrl != null && !hostUrl.isBlank()) {

            OkHttpClient client = new OkHttpClient.Builder()
                    .connectTimeout(5, TimeUnit.MINUTES)
                    .writeTimeout(2, TimeUnit.MINUTES)
                    .readTimeout(2, TimeUnit.MINUTES)
                    .build();
            Request request = new Request.Builder()
                    .url(String.format(FETCH_PY_URL, baseUrl))
//                        .url("http://localhost:7071/api/OpenLane?from=https://app.openlane.ca/retail/public/d1221206-0092-42f3-a361-417317348fdf")
                    .build();
            Response response = null;

            try {
                response = client.newCall(request).execute();

                ObjectMapper objectMapper = new ObjectMapper();
                String responseBody = response.body().string();

                ScrapPy entity = objectMapper.readValue(responseBody, ScrapPy.class);
                if (entity.getSuccess()) {
                    Offer newOffer = this.mapScrapPyData(entity);

                    newOffer.setCluster(this.getOfferCluster(hostUrl));
                    newOffer.setPublisherUrl(baseUrl);
                    newOffer.setAdmin(this.getAdmin(userDetails.getId()));

                    resultOffer = this.offerRepository.save(newOffer);


                    List<String> imgUrs = this.blobStorage.saveImageToAzure(resultOffer.getId(), entity.getData().getListImages());
                    Set<Image> imagesObj = new HashSet<>();
                    short order = 0;
                    for (String currentImageUrl : imgUrs) {
                        imagesObj.add(new Image(currentImageUrl, order++));
                    }
                    resultOffer.setImages(imagesObj);
                    resultOffer = this.offerRepository.save(resultOffer);

                } else {
                    throw new CarImportException(String.format("Import fetch failed for url %s", baseUrl));
                }

            } catch (IOException ex) {
                LOGGER.error("Get fetch ", ex);
                throw new CarImportException(String.format("Import fetch failed for url %s %s %s", baseUrl, ex.getMessage(), ex.getCause()));
            }
        } else {
            throw new CarImportException(String.format("Import failed blank host %s", baseUrl));
        }
        return resultOffer;
    }

    private Maker getMaker(String maker) throws CarException {
        return this.makerRepository.findByNameIgnoreCase(maker.toLowerCase()).orElse(new Maker(maker));
    }
    private Model getModel(String model, Maker maker) throws CarException {
        if (maker != null && maker.getId() != null) {
            return this.modelRepository.findByModelIgnoreCaseAndMaker(model.toLowerCase(), maker).orElse(new Model(model, maker));
        }
        return new Model(model, maker);
    }

    private OfferCluster getOfferCluster(String cluster) {
        return this.offerClusterRepository.findByNameIgnoreCase(cluster).orElse(OfferCluster.builder().name(cluster).build());
    }

    private Admin getAdmin(Long fkAccountId) {
        return this.adminRepository.findByFkAccount(fkAccountId).orElseThrow(() ->
                new CarException(String.format("Admin with fk acc %d not found", fkAccountId)));
    }

    private String validateUrlAndReturnHost(String url) throws CarImportException {
        if (!url.contains("openlane")) {
            throw new CarImportException(String.format("Bad URL %s", url));
        }

        URI uri = null;
        try {
            uri = new URI(url);
        } catch (URISyntaxException e) {
            throw new RuntimeException(e);
        }
        return uri.getHost();
    }

    private Offer mapScrapPyData(ScrapPy scrapPy) {
        ScrapDataPy data = scrapPy.getData();
        Offer result = new Offer();
        result.setYear(Integer.valueOf(data.getYear().strip()));
        Maker makerObj = this.getMaker(data.getMaker().strip());
        Model modelObj = this.getModel(data.getModel().strip(), makerObj);
        result.setModel(modelObj);
        result.setModelInfo(data.getModelInfo().strip());
        result.setLocation(data.getLocation().strip());
        result.setKilometers(Integer.parseInt(data.getKilometres().strip().replaceAll("[^0-9]", "")));
        result.setTransmissionType(TransmissionType.getTypeByString(data.getTransmission().strip()));
        result.setEngineInfo(data.getEngineInfo().strip());
        result.setDriveType(DriveType.getTypeByString(data.getDriveTrain().strip()));
        result.setFuelType(FuelType.getTypeByString(data.getFuel().strip()));
        result.setSeats(Short.valueOf(data.getSeatsNum().strip()));
        result.setColorInfo(data.getExtIntColor().strip());

        //Add features
        HashMap<String, Set<String>> mapFeatures = new HashMap<>();
        for (String feature : data.getListFeatures()) {
            if (!feature.isBlank()) {
                String[] lines = feature.split("\n");
                if (lines.length > 1) {
                    List<String> resultFeature = Arrays.stream(lines, 1, lines.length - 2).toList();
                    Set<String> features = mapFeatures.getOrDefault(lines[0], new HashSet<>());
                    features.addAll(resultFeature);
                    mapFeatures.put(lines[0], features);
                }
            }
        }

        Set<Feature> setFeatures = new HashSet<>();
        mapFeatures.forEach((key, value) -> {
            FeatureCategory category = this.featureCategoryRepository.findByNameIgnoreCase(key).orElse(new FeatureCategory(key));

            for (String s : value) {
                setFeatures.add(this.featureRepository.findByNameIgnoreCase(s).orElse(new Feature(s, category)));
            }
        });
        result.setFeatures(setFeatures);

        //Images
//        Set<Image> imagesObj = new HashSet<>();
//        short order = 0;
//        for (String currentImageUrl : data.getListImages()) {
//            imagesObj.add(new Image(currentImageUrl, order++));
//        }
//        result.setImages(imagesObj);

        //carfax
        result.setCarfaxLink(data.getCarfax().strip());
        //vin
        result.setVin(data.getVin());

        result.setPublishDate(OffsetDateTime.now());
        result.setEndDate(OffsetDateTime.now());
        result.setPrice(0.0d);

        return result;
    }
}
