package main.cars.car.controllers;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import main.cars.car.models.Maker;
import main.cars.car.models.Model;
import main.cars.car.models.Offer;
import main.cars.car.models.request.*;
import main.cars.car.models.response.MakerResponse;
import main.cars.car.models.response.PagedResponse;
import main.cars.car.services.CarService;
import main.cars.car.services.ScrapService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;
import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/car")
public class CarController {

    private final CarService service;

    @GetMapping("/all")
    @ResponseStatus(HttpStatus.OK)
    public List<Maker> getAllMakers() {
        return this.service.getAllMakers();
    }

    @GetMapping("/models")
    @ResponseStatus(HttpStatus.OK)
    public Collection<MakerResponse> getAllActiveModels() {
        return this.service.getAllActiveMakersModels();
    }

    @GetMapping("/additional")
    @ResponseStatus(HttpStatus.OK)
    public AdditionalSearchOptionsResponse getAdditionalSearchOptions() {
        return this.service.getAdditionalSearchOptions();
    }

    @PostMapping("/offers/all")
    @ResponseStatus(HttpStatus.OK)
    public PagedResponse<Offer> getAllOffers(@RequestBody @Valid SearchPaginationRequest request) {
        return this.service.getAll(request);
    }

    @GetMapping("/offer/{id}")
    @ResponseStatus(HttpStatus.OK)
    public Offer getOfferById(@PathVariable Long id) {
        return this.service.getOfferById(id);
    }


    @PatchMapping("/update/v/{id}")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public void updateViews(@PathVariable @Min(1) Long id) {
        this.service.updateViews(id);
    }

}
