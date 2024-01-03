package main.cars.car.models;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public enum FuelType {
    G("Gasoline"), //include "Flexible Fuel" engine and are capable of operating on gasoline and any blend of gasoline and ethanol up to 83%.
    D("Diesel"),
    H("Hybrid"),
    E("Electric"),
    PI_H("Plug-in Hybrid"), //When search for Hybrid include it
    FF("Flexible Fuel"),
    O("Other");

    private static final Map<String, FuelType> map = new HashMap<>(values().length, 1);

    static {
        for (FuelType c : values()) map.put(c.value.toLowerCase(), c);
    }

    private final String value;

    private FuelType(String value) {
        this.value = value;
    }

    public static FuelType of(String name) {
        FuelType result = map.get(name.toLowerCase());
        if (result == null) {
            return O;
        }
        return result;
    }

    public static FuelType getTypeByString(String type) {
        FuelType result = of(type);
        if (result.equals(O)) {
            if (type.toLowerCase().contains("gas")) {
                result = G;
            }
        }
        return result;
    }
}


