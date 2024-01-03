package main.cars.car.models.request;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import main.cars.car.models.DriveType;
import main.cars.car.models.FuelType;
import main.cars.car.models.SearchOrderType;
import main.cars.car.models.TransmissionType;
import main.cars.car.models.response.ModelResponse;

import javax.annotation.Nullable;
import java.util.List;

@Getter
@Setter
public class SearchPaginationRequest {

    @NotNull
    @Min(0)
    Integer page;

    @NotNull
    @Min(1)
    Integer size;

    @Nullable
    @Enumerated(EnumType.STRING)
    SearchOrderType search;

    @Nullable
    @Min(0)
    Double price;

    @Nullable
    @Min(0)
    Double priceTo;

    @Nullable
    List<ModelResponse> models;

    @Nullable
    Integer kilometersFrom;

    @Nullable
    Integer kilometersTo;

    @Nullable
    Integer yearFrom;

    @Nullable
    Integer yearTo;

    @Nullable
    List<DriveType> driveTypeList;

    @Nullable
    List<FuelType> fuelTypeList;

    @Nullable
    List<TransmissionType> transmissionTypeList;
}
