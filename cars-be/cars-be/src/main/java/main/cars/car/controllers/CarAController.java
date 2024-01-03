package main.cars.car.controllers;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import main.cars.car.models.Offer;
import main.cars.car.models.request.ActivateOfferRequest;
import main.cars.car.models.request.ScrapeRequest;
import main.cars.car.models.request.SearchPaginationRequest;
import main.cars.car.models.request.StatusOfferRequest;
import main.cars.car.models.response.PagedResponse;
import main.cars.car.services.CarService;
import main.cars.car.services.ScrapService;
import main.cars.config.UserDetailsImpl;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;


@RequiredArgsConstructor
@RestController
@RequestMapping("/offer")
public class CarAController {

    private final CarService service;;
    private final ScrapService scrapService;

    @PostMapping("/fetch")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public Offer tryTo(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody @Valid ScrapeRequest request) {
        return this.scrapService.saveCarDateFromOpenlane(userDetails, request.getUrl());
    }

    //TODO add guard
    @PostMapping("/update")
    @ResponseStatus(HttpStatus.CREATED)
    public Offer update(@RequestBody @Valid Offer offer) {
        return this.service.update(offer);
    }

    //TODO add guard
    @PostMapping("/offers/n/all")
    @ResponseStatus(HttpStatus.OK)
    public PagedResponse<Offer> getAllOffersNonFiltered(@RequestBody @Valid SearchPaginationRequest request) {
        return this.service.getAllNonFiltered(request);
    }

    //TODO add guard
    @PostMapping("/offers/active")
    @ResponseStatus(HttpStatus.OK)
    public void activateDeactivateOffer(@RequestBody @Valid ActivateOfferRequest request) {
        this.service.activateDeactivateOffer(request.getId(), request.getActive());
    }

    //TODO add guard
    @PostMapping("/offers/status")
    @ResponseStatus(HttpStatus.OK)
    public void updateOfferStatus(@RequestBody @Valid StatusOfferRequest request) {
        this.service.updateOfferStatus(request.getId(), request.getStatus());
    }
}
