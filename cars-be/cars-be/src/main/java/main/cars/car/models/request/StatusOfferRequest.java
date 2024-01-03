package main.cars.car.models.request;


import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import main.cars.car.models.OfferStatusType;

@Getter
@Setter
public class StatusOfferRequest {
    @NotNull
    private Long id;

    @NotNull
    private OfferStatusType status;
}
