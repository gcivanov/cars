package main.cars.config.exception;

import jakarta.validation.ValidationException;

public class CarException extends ValidationException {

    public CarException(String message) {
        super(message);
    }
}
