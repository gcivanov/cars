package main.cars.config.exception;

import jakarta.validation.ValidationException;

public class DataNotFoundException extends ValidationException {
    public DataNotFoundException(String message) {
        super(message);
    }

}
