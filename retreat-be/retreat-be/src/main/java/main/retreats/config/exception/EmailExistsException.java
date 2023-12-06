package main.retreats.config.exception;

import jakarta.validation.ValidationException;

public class EmailExistsException extends ValidationException {

    public EmailExistsException(String message) {
        super(message);
    }

}
