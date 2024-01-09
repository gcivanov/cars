package main.cars.car.models.response;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ScrapDataPy {
    private String maker;
    private String model;
    private String year;
    private String modelInfo;
    private String location;
    private String kilometres;
    private String transmission;
    private String engineInfo;
    private String driveTrain;
    private String fuel;
    private String seatsNum;
    private String extIntColor;
    private List<String> listFeatures;
    private List<String> listImages;
    private String carfax;
    private String vin;
}
