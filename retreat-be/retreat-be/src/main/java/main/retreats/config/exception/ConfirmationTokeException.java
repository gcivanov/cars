package main.retreats.config.exception;

import jakarta.validation.ValidationException;

public class ConfirmationTokeException extends ValidationException {

    public ConfirmationTokeException(String message) {
        super(message);
    }

}