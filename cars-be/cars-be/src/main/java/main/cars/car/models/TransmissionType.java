package main.cars.car.models;

import java.util.Arrays;
import java.util.List;

public enum TransmissionType {
    A("Automatic"),
    M("Manual"),
    U("Unknown");

    private String value;

    private TransmissionType(String value) {
        this.value = value;
    }

    public static TransmissionType getTypeByString(String type) {
        if (type.toLowerCase().contains("auto")) {
            return A;
        } else if (type.toLowerCase().contains("man")) {
            return M;
        }
        return U;
    }
}
