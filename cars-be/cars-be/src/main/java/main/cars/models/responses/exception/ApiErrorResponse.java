package main.cars.models.responses.exception;

import org.springframework.http.HttpStatus;

import java.time.LocalDate;

public class ApiErrorResponse {

    private final HttpStatus status;
    private final String message;
    private final LocalDate timestamp;

    public ApiErrorResponse(HttpStatus status, String message, LocalDate timestamp) {
        this.status= status;
        this.message = message;
        this.timestamp = timestamp;
    }

    public HttpStatus getStatus() {
        return this.status;
    }

    public String getMessage() {
        return this.message;
    }

    public LocalDate getTimestamp() {
        return this.timestamp;
    }
}