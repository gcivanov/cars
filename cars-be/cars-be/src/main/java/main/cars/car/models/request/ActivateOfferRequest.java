package main.cars.car.models.request;


import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ActivateOfferRequest {
    @NotNull
    private Long id;

    @NotNull
    private Boolean active;
}
