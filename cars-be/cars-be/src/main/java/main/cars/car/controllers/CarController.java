package main.cars.car.controllers;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import lombok.RequiredArgsConstructor;
import main.cars.car.models.Maker;
import main.cars.car.models.Offer;
import main.cars.car.models.request.*;
import main.cars.car.models.response.MakerResponse;
import main.cars.car.models.response.PagedResponse;
import main.cars.car.services.CarService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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

    @GetMapping("img/{id}/{name}")
    public ResponseEntity<byte[]> getImg(@PathVariable(name = "id") Long offerId,
                                         @PathVariable(name = "name") String name) {

        byte[] arr = this.service.getImage(offerId, name).toBytes();

        final HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_JPEG);
        return new ResponseEntity<byte[]>(arr, headers, HttpStatus.CREATED);
    }

}
