package main.cars.car.models;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

import java.util.Arrays;
import java.util.List;

public interface BaseType<T> {

    T getValue();
    List<T> allOptions();

    @JsonValue
    default T getJsonValue() {
        return getValue();
    }

    //TODO Change Exceptions
    @JsonCreator
    default T forValue(T value) {
        return allOptions().stream()
                .filter(op -> op.equals(value))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("")); // depending on requirements: can be .orElse(null);
    }
}
