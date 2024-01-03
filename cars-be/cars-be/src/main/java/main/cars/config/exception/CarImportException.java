package main.cars.config.exception;

import jakarta.validation.ValidationException;

public class CarImportException extends ValidationException {

    public CarImportException(String message) {
        super(message);
    }
}
