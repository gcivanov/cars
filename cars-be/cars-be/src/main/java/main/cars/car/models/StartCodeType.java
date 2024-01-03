package main.cars.car.models;

public enum StartCodeType {
    RD("Run & Drive"),
    SS("Starts"),
    SY("Stationary");

    private String value;

    private StartCodeType(String value) {
        this.value = value;
    }
}
