package main.cars.car.models.response;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ScrapPy {

    private Boolean success;
    private ScrapDataPy data;

}
