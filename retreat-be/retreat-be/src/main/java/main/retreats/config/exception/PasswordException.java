package main.retreats.config.exception;

import jakarta.validation.ValidationException;

public class PasswordException extends ValidationException {

    public PasswordException(String message) {
        super(message);
    }
}
