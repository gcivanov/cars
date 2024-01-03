package main.cars.car.services;

import lombok.RequiredArgsConstructor;
import main.cars.car.models.*;
import main.cars.car.models.request.AdditionalSearchOptionsResponse;
import main.cars.car.models.request.SearchPaginationRequest;
import main.cars.car.models.response.MakerResponse;
import main.cars.car.models.response.ModelResponse;
import main.cars.car.models.response.PagedResponse;
import main.cars.car.repositories.MakerRepository;
import main.cars.car.repositories.ModelRepository;
import main.cars.car.repositories.OfferRepository;
import main.cars.config.exception.CarException;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
public class CarService {
    private final MakerRepository makerRepository;
    private final ModelRepository modelRepository;
    private final OfferRepository offerRepository;

    public List<Maker> getAllMakers() {
        return this.makerRepository.findAll();
    }

    public List<Model> getAllModels(Maker maker) {
        Maker dbMaker = this.makerRepository.findById(maker.getId()).orElseThrow(() ->
                new CarException(String.format("Maker not found id %d", maker.getId())));
        if (!dbMaker.getName().strip().equalsIgnoreCase(maker.getName().strip().toLowerCase())) {
            throw new CarException(String.format("Maker dosnt mach id: %d name: %s", maker.getId(), maker.getName()));
        }
        //TODO NOT TESTED
        return this.modelRepository.findAllByFkMaker(maker.getId());
    }
    public Collection<MakerResponse> getAllActiveMakersModels() {

        Map<Long, MakerResponse> mapData = new HashMap<>();
        List<Model> dbModels = this.offerRepository.findModelsWhereActive();
        for (Model dbModel : dbModels) {
            ModelResponse modelResponse = ModelResponse.builder()
                    .id(dbModel.getId())
                    .model(dbModel.getModel())
                    .count(1).build();
            MakerResponse makerResponse = mapData.getOrDefault(dbModel.getMaker().getId(),
                    MakerResponse.builder()
                            .id(dbModel.getMaker().getId())
                            .name(dbModel.getMaker().getName())
                            .models(new ArrayList<>())
                            .count(0).build());
//            int index = makerResponse.getModels().indexOf(modelResponse);
//            if (index > 0) {
//                makerResponse.getModels().get(index).setCount(makerResponse.getModels().get(index).getCount() + 1);
//            } else {
                makerResponse.getModels().add(modelResponse);
//            }
//            makerResponse.setCount(makerResponse.getCount() + 1);
            mapData.put(dbModel.getMaker().getId(), makerResponse);
        }
        Collection<MakerResponse> result = mapData.values();
//        Set<MakerResponse> newEls = new HashSet<>();
//        newEls.addAll(result);
//        long counter = 100;
//        while (counter < 120) {
//            for (MakerResponse value : mapData.values()) {
//                MakerResponse newMR =
//                        MakerResponse.builder().id(counter++)
//                                        .models(new ArrayList<>(value.getModels()))
//                                                .name(value.getName())
//                                                        .count(value.getCount()).build();
//                newEls.add(newMR);
//            }
//        }
        return result;
    }

    public AdditionalSearchOptionsResponse getAdditionalSearchOptions() {
        AdditionalSearchOptionsResponse result = new AdditionalSearchOptionsResponse();
        result.setDriveTypeList(List.of(DriveType.values()));
        result.setFuelTypeList(List.of(FuelType.values()));
        result.setTransmissionTypeList(List.of(TransmissionType.values()));
        result.setStartCodeTypeList(List.of(StartCodeType.values()));
        result.setSearchOrderTypeList(List.of(SearchOrderType.values()));
        result.setOfferStatusTypeList(List.of(OfferStatusType.values()));
        return result;
    }

    public PagedResponse<Offer> getAll(SearchPaginationRequest request) {

        List<Offer> offers = this.getActiveOrderAndFilterOffers(request);

        return PagedResponse.getPaginatedData(offers, request.getPage(), request.getSize() > offers.size() ? offers.size() : request.getSize());
    }

    public PagedResponse<Offer> getAllNonFiltered(SearchPaginationRequest request) {
        List<Offer> offers = this.getAllOrderAndFilterOffers(request);
        return PagedResponse.getPaginatedData(offers, request.getPage(), request.getSize() > offers.size() ? offers.size() : request.getSize());
    }

    private List<Offer> getActiveOrderAndFilterOffers(SearchPaginationRequest request) {

        List<Offer> offers;
        PageRequest pageRequest = this.extractPageRequestFromSearchTypeForOffers(request.getSearch());

        List<Long> modelIds = null;
        if (request.getModels() != null && !request.getModels().isEmpty()) {
            modelIds = request.getModels().stream().map(ModelResponse::getId).toList();
        }

        List<String> drives = request.getDriveTypeList() != null ? request.getDriveTypeList().stream().map(DriveType::name).toList() : null;
        List<String> fuels = request.getFuelTypeList() != null ? request.getFuelTypeList().stream().map(FuelType::name).toList() : null;
        List<String> transmissions = request.getTransmissionTypeList() != null ? request.getTransmissionTypeList().stream().map(TransmissionType::name).toList() : null;

        offers = this.offerRepository.findActiveByOrderAndSearch(pageRequest, request.getPrice(), request.getPriceTo(), modelIds,
                request.getKilometersFrom(), request.getKilometersTo(),
                request.getYearFrom(), request.getYearTo(),
                drives, fuels, transmissions);

        return offers;
    }

    private List<Offer> getAllOrderAndFilterOffers(SearchPaginationRequest request) {

        List<Offer> offers;
        PageRequest pageRequest = this.extractPageRequestFromSearchTypeForOffers(request.getSearch());


        List<Long> modelIds = null;
        if (request.getModels() != null && !request.getModels().isEmpty()) {
            modelIds = request.getModels().stream().map(ModelResponse::getId).toList();
        }

        List<String> drives = request.getDriveTypeList() != null ? request.getDriveTypeList().stream().map(DriveType::name).toList() : null;
        List<String> fuels = request.getFuelTypeList() != null ? request.getFuelTypeList().stream().map(FuelType::name).toList() : null;
        List<String> transmissions = request.getTransmissionTypeList() != null ? request.getTransmissionTypeList().stream().map(TransmissionType::name).toList() : null;

        offers = this.offerRepository.findAllByOrderAndSearch(pageRequest, request.getPrice(), request.getPriceTo(), modelIds,
                request.getKilometersFrom(), request.getKilometersTo(),
                request.getYearFrom(), request.getYearTo(),
                drives, fuels, transmissions);

        return offers;
    }

    private PageRequest extractPageRequestFromSearchTypeForOffers(SearchOrderType searchOrderType) {
        SearchOrderType searchType = searchOrderType;
        PageRequest pageRequest = null;
        if (searchType != null && !searchType.equals(SearchOrderType.D)) {
            switch (searchType) {
                case T -> pageRequest = PageRequest.of(0, 1000, Sort.by(Sort.Direction.ASC, "end_date"));
                case N -> pageRequest = PageRequest.of(0, 1000, Sort.by(Sort.Direction.DESC, "publish_date"));
                case H -> pageRequest = PageRequest.of(0, 1000, Sort.by(Sort.Direction.DESC, "price"));
                case L -> pageRequest = PageRequest.of(0, 1000, Sort.by(Sort.Direction.ASC, "price"));
                case V -> pageRequest = PageRequest.of(0, 1000, Sort.by(Sort.Direction.DESC, "views"));
            }
        }
        return pageRequest;
    }

    public void updateViews(Long id) {
        Offer offer = this.getOfferById(id);
        offer.setViews(offer.getViews() != null ? offer.getViews() + 1 : 0);
        this.offerRepository.save(offer);
    }

    public Offer getOfferById(Long id) {
        return this.offerRepository.findById(id).orElseThrow(() ->
                new CarException(String.format("Offer not found id %d", id)));
    }

    public Offer update(Offer offer) {
        this.getOfferById(offer.getId());

        Offer response = this.offerRepository.save(offer);
        return response;
    }

    public void activateDeactivateOffer(Long id, boolean active) {
        Offer offer = this.getOfferById(id);
        if (offer.getActive() != active) {
            offer.setActive(active);
            this.offerRepository.save(offer);
        }
    }

    public void updateOfferStatus(Long id, OfferStatusType status) {
        Offer offer = this.getOfferById(id);
        if (!offer.getOfferStatus().equals(status)) {
            offer.setOfferStatus(status);
            this.offerRepository.save(offer);
        }
    }
}
