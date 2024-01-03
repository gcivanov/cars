package main.cars.car.models;

import java.util.Arrays;
import java.util.List;

public enum DriveType {// implements BaseType<String> {
    A("All"),
    F("Front"),
    R("Rear"),
    U("Unknown"),;

    private String value;

    private DriveType(String value) {
        this.value = value;
    }

    public static DriveType getTypeByString(String type) {
        if (type.toLowerCase().contains("all") ||
                type.toLowerCase().contains("4")||
                type.toLowerCase().contains("awd")) {
            return A;
        } else if (type.toLowerCase().contains("f") ||
                type.toLowerCase().contains("fwd")) {
            return F;
        } else if (type.toLowerCase().contains("re") ||
                    type.toLowerCase().contains("rwd")) {
            return R;
        }
        return U;
    }

//    @Override
//    public String getValue() {
//        return value;
//    }
//
//    @Override
//    public List<String> allOptions() {
//        return Arrays.stream(values()).map(BaseType::getJsonValue).toList();
//    }
}
