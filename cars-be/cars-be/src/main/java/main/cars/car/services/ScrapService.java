package main.cars.car.services;

import lombok.RequiredArgsConstructor;
import main.cars.car.models.*;
import main.cars.car.repositories.*;
import main.cars.config.UserDetailsImpl;
import main.cars.config.exception.CarException;
import main.cars.config.exception.CarImportException;
import main.cars.models.Admin;
import main.cars.repositories.AdminRepository;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.springframework.stereotype.Service;

import java.io.File;
import java.net.URI;
import java.net.URISyntaxException;
import java.time.*;
import java.util.*;

@RequiredArgsConstructor
@Service
public class ScrapService {

    private static final String CARFAX_KEY = "carfax";

    private final MakerRepository makerRepository;
    private final ModelRepository modelRepository;
    private final FeatureCategoryRepository featureCategoryRepository;
    private final FeatureRepository featureRepository;
    private final OfferRepository offerRepository;
    private final AdminRepository adminRepository;
    private final ImageRepository imageRepository;
    private final OfferClusterRepository offerClusterRepository;


    public Offer saveCarDateFromOpenlane(UserDetailsImpl userDetails, String baseUrl) {
        baseUrl = baseUrl.trim();
        Offer resultOffer = null;
        String hostUrl = this.validateUrlAndReturnHost(baseUrl);

        if (hostUrl != null && !hostUrl.isBlank()) {
            String vpnExtPath = "C:\\Users\\Georgi Ivanov\\AppData\\Roaming\\Mozilla\\Firefox\\Profiles\\fvwhynbe.default-release\\extensions\\firefox-webext@zenmate.com.xpi";
            FirefoxProfile firefoxProfile = new FirefoxProfile();
            File addonpath = new File(vpnExtPath);
            firefoxProfile.addExtension(addonpath);
            FirefoxOptions firefoxOptions = new FirefoxOptions();
            firefoxOptions.setProfile(firefoxProfile);
            FirefoxDriver driver = null;
            try {
                driver = new FirefoxDriver(firefoxOptions);
                driver.manage().timeouts().pageLoadTimeout(Duration.ofMinutes(2));
                driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(40));
                driver.navigate().to(baseUrl);

                driver.manage().window().maximize();

    //            Offer newOffer = this.offerRepository.findByPublisherUrl(baseUrl).orElse(new Offer());
                Offer newOffer = new Offer();

                newOffer.setCluster(this.getOfferCluster(hostUrl));

                WebElement baseRootElement = driver.findElement(By.id("root"));

                String year = baseRootElement.findElement(By.xpath("//*[@id=\"root\"]/div[2]/div/div[2]/section[2]/header/div[1]")).getText().strip();
    //            String year = baseRootElement.findElement(By.xpath("/html/body/div[1]/div[2]/div/div[2]/section[2]/header/div[1]")).getText().strip();
                newOffer.setYear(Integer.valueOf(year));
                String maker = baseRootElement.findElement(By.xpath("//*[@id=\"root\"]/div[2]/div/div[2]/section[2]/header/p[1]")).getText().strip();
    //            String maker = baseRootElement.findElement(By.xpath("/html/body/div[1]/div[2]/div/div[2]/section[2]/header/p[1]")).getText().strip();
                Maker makerObj = this.getMaker(maker);

                String model = baseRootElement.findElement(By.xpath("//*[@id=\"root\"]/div[2]/div/div[2]/section[2]/header/p[2]")).getText().strip();
    //            String model = baseRootElement.findElement(By.xpath("/html/body/div[1]/div[2]/div/div[2]/section[2]/header/p[2]")).getText().strip();
                Model modelObj = this.getModel(model, makerObj);
                newOffer.setModel(modelObj);

                String modelInfo = baseRootElement.findElement(By.xpath("//*[@id=\"root\"]/div[2]/div/div[2]/section[2]/header/div[2]")).getText().strip();
                newOffer.setModelInfo(modelInfo);

                String location = baseRootElement.findElement(By.xpath("//*[@id=\"side-sales-info\"]/div/span[2]")).getText().strip();
                newOffer.setLocation(location);

                String kilometres = baseRootElement.findElement(By.xpath("//*[@id=\"vehicle-overview\"]/div/div[1]/div/p[2]")).getText().strip();
    //            String kilometres = baseRootElement.findElement(By.xpath("/html/body/div[1]/div[2]/div/div[2]/section[2]/div/section[1]/div/div[1]/div/p[2]")).getText().strip();
                newOffer.setKilometers(Integer.parseInt(kilometres.replaceAll("[^0-9]","")));
                String transmission = baseRootElement.findElement(By.xpath("//*[@id=\"vehicle-overview\"]/div/div[2]/div/p[2]")).getText().strip();
    //            String transmission = baseRootElement.findElement(By.xpath("/html/body/div[1]/div[2]/div/div[2]/section[2]/div/section[1]/div/div[2]/div/p[2]")).getText().strip();
                newOffer.setTransmissionType(TransmissionType.getTypeByString(transmission));
                String engineInfo = baseRootElement.findElement(By.xpath("//*[@id=\"vehicle-overview\"]/div/div[3]/div/p[2]")).getText().strip();
    //            String engineInfo = baseRootElement.findElement(By.xpath("/html/body/div[1]/div[2]/div/div[2]/section[2]/div/section[1]/div/div[3]/div/p[2]")).getText().strip();
                newOffer.setEngineInfo(engineInfo);
                String driveTrain = baseRootElement.findElement(By.xpath("//*[@id=\"vehicle-overview\"]/div/div[4]/div/p[2]")).getText().strip();
    //            String driveTrain = baseRootElement.findElement(By.xpath("/html/body/div[1]/div[2]/div/div[2]/section[2]/div/section[1]/div/div[4]/div/p[2]")).getText().strip();
                newOffer.setDriveType(DriveType.getTypeByString(driveTrain));
                String fuel = baseRootElement.findElement(By.xpath("//*[@id=\"vehicle-overview\"]/div/div[5]/div/p[2]")).getText().strip();
    //            String fuel = baseRootElement.findElement(By.xpath("/html/body/div[1]/div[2]/div/div[2]/section[2]/div/section[1]/div/div[5]/div/p[2]")).getText().strip();
                newOffer.setFuelType(FuelType.getTypeByString(fuel));
                String seatsNum = baseRootElement.findElement(By.xpath("//*[@id=\"vehicle-overview\"]/div/div[6]/div/p[2]")).getText().strip();
    //            String seatsNum = baseRootElement.findElement(By.xpath("/html/body/div[1]/div[2]/div/div[2]/section[2]/div/section[1]/div/div[6]/div/p[2]")).getText().strip();
                newOffer.setSeats(Short.valueOf(seatsNum));
                String extIntColor = baseRootElement.findElement(By.xpath("//*[@id=\"vehicle-overview\"]/div/div[7]/div/p[2]")).getText().strip();
    //            String extIntColor = baseRootElement.findElement(By.xpath("/html/body/div[1]/div[2]/div/div[2]/section[2]/div/section[1]/div/div[7]/div/p[2]")).getText().strip();
                newOffer.setColorInfo(extIntColor);

                //extract aff features
                WebElement sectionFeatures = baseRootElement.findElement(By.xpath("//*[@id=\"vehicle-features\"]/ul"));
    //            WebElement sectionFeatures = baseRootElement.findElement(By.xpath("/html/body/div[1]/div[2]/div/div[2]/section[2]/div/section[3]/ul"));
                List<WebElement> list = sectionFeatures.findElements(By.xpath("./*"));
                HashMap<String, Set<String>> mapFeatures = new HashMap<>();
                for (WebElement webElement : list) {
                    String text = webElement.getText();
                    if (!text.isBlank()) {
                        String[] lines = text.split("\n");
                        if (lines.length > 1) {
                            List<String> result = Arrays.stream(lines, 1, lines.length - 2).toList();
                            Set<String> features = mapFeatures.getOrDefault(lines[0], new HashSet<>());
                            features.addAll(result);
                            mapFeatures.put(lines[0], features);
                        }
                    }
                }

                Set<Feature> setFeatures = new HashSet<>();
                mapFeatures.forEach((key,value) -> {
                    FeatureCategory category = this.featureCategoryRepository.findByNameIgnoreCase(key).orElse(new FeatureCategory(key));
    //                if (category.getId() == null) {
    //                    this.featureCategoryRepository.save(category);
    //                }

                    for (String s : value) {
                        setFeatures.add(this.featureRepository.findByNameIgnoreCase(s).orElse(new Feature(s, category)));
                    }
                });
                newOffer.setFeatures(setFeatures);

                //Images
                Queue<WebElement> imagesWebElement = new ArrayDeque<>();

                imagesWebElement.add(baseRootElement.findElement(By.xpath("//*[@id=\"root\"]/div[2]/div/div[2]/section[1]/div/div[1]/img")));

                WebElement secondaryImages = baseRootElement.findElement(By.xpath("//*[@id=\"root\"]/div[2]/div/div[2]/section[1]/div/div[2]/ul"));
                List<WebElement> allSecondaryImages = secondaryImages.findElements(By.tagName("img"));
                imagesWebElement.addAll(allSecondaryImages);

                Set<Image> imagesObj = new HashSet<>();
                short order = 0;
                for (WebElement imageWebElement : imagesWebElement) {
                    String currentUrl = imageWebElement.getAttribute("src").strip();
                    imagesObj.add(new Image(currentUrl, order++));
                }

                newOffer.setImages(imagesObj);

                WebElement btnCarfax = baseRootElement.findElement(By.xpath("//*[@id=\"vehicle-vhr\"]/button"));
    //            WebElement btnCarfax = baseRootElement.findElement(By.xpath("/html/body/div[1]/div[2]/div/div[2]/section[2]/div/section[2]/button"));
                btnCarfax.click();
                String currentUrl = driver.getCurrentUrl();
                String currentHande = driver.getWindowHandle();
                Set<String> allHandles = driver.getWindowHandles();
                String carfaxUrl = null;
                Thread.sleep(2700);
                for (String handle : allHandles) {
                    if (!handle.equals(currentHande)) {
                        String newCurrentUrl = driver.switchTo().window(handle).getCurrentUrl();
                        if (!newCurrentUrl.equals(currentUrl) && newCurrentUrl.contains(CARFAX_KEY)) {
                            carfaxUrl = newCurrentUrl.strip();
                            break;
                        }
                    }
                }
                newOffer.setCarfaxLink(carfaxUrl);

                newOffer.setPublisherUrl(baseUrl);

                newOffer.setPublishDate(OffsetDateTime.now());
                newOffer.setEndDate(OffsetDateTime.now());
                newOffer.setPrice(0.0d);

                newOffer.setAdmin(this.getAdmin(userDetails.getId()));

                resultOffer = this.offerRepository.save(newOffer);
            } catch (Exception ex) { //InterruptedException
                throw new CarImportException(String.format("Import failed for url %s %s %s", baseUrl, ex.getMessage(), ex.getCause()));
            } finally {
                if (driver != null) {
                    driver.quit();
                }
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
}
