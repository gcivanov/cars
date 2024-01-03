package main.cars.car.models.request;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import main.cars.car.models.*;

import java.util.List;

@Getter
@Setter
public class AdditionalSearchOptionsResponse {

    @NotNull
    @NotEmpty
    List<TransmissionType> transmissionTypeList;

    @NotNull
    @NotEmpty
    List<FuelType> fuelTypeList;

    @NotNull
    @NotEmpty
    List<DriveType> driveTypeList;

    @NotNull
    @NotEmpty
    List<StartCodeType> startCodeTypeList;

    //not direct connected in the fe
    @NotNull
    @NotEmpty
    List<SearchOrderType> searchOrderTypeList;

    //not direct connected in the fe
    @NotNull
    @NotEmpty
    List<OfferStatusType> offerStatusTypeList;
}
