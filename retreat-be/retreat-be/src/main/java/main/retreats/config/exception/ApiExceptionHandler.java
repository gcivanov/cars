package main.retreats.config.exception;

import main.retreats.models.responses.exception.ApiErrorResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.ErrorResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import javax.management.relation.RoleNotFoundException;
import java.time.DateTimeException;
import java.time.LocalDate;

@ControllerAdvice
public class ApiExceptionHandler extends ResponseEntityExceptionHandler {

//    @ExceptionHandler(Exception.class)
//    @ResponseStatus(value = HttpStatus.BAD_REQUEST)
//    public ErrorResponse handleGenericException(final Exception ex , final WebRequest request) {
//        System.out.println("handleGenericException ....");
//        return ErrorResponse.create(ex, HttpStatus.BAD_REQUEST, "faild");
//    }

    @ExceptionHandler(PasswordException.class)
    public ResponseEntity<ApiErrorResponse> handlePasswordException(PasswordException ex) {
        return new ResponseEntity<>(new ApiErrorResponse(HttpStatus.BAD_REQUEST, ex.getMessage(), LocalDate.now()), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(BadCredentialsException.class)
    public ResponseEntity<ApiErrorResponse> handleBadCredentialsException(BadCredentialsException ex) {
        return new ResponseEntity<>(new ApiErrorResponse(HttpStatus.BAD_REQUEST, ex.getMessage(), LocalDate.now()), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(EmailExistsException.class)
    public ResponseEntity<ApiErrorResponse> handleEmailExistsException(EmailExistsException ex) {
        return new ResponseEntity<>(new ApiErrorResponse(HttpStatus.BAD_REQUEST, ex.getMessage(), LocalDate.now()), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(DateTimeException.class)
    public ResponseEntity<ApiErrorResponse> handleDateException(DateTimeException ex) {
        return new ResponseEntity<>(new ApiErrorResponse(HttpStatus.CONFLICT, ex.getMessage(), LocalDate.now()), HttpStatus.CONFLICT);
    }

    @ExceptionHandler(RoleNotFoundException.class)
    public ResponseEntity<ApiErrorResponse> handleRoleNotFoundException(RoleNotFoundException ex) {
        return new ResponseEntity<>(new ApiErrorResponse(HttpStatus.CONFLICT, ex.getMessage(), LocalDate.now()), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(ConfirmationTokeException.class)
    public ResponseEntity<ApiErrorResponse> handleDateException(ConfirmationTokeException ex) {
        return new ResponseEntity<>(new ApiErrorResponse(HttpStatus.UNAUTHORIZED, ex.getMessage(), LocalDate.now()), HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(DataNotFoundException.class)
    public ResponseEntity<ApiErrorResponse> handlePasswordException(DataNotFoundException ex) {
        return new ResponseEntity<>(new ApiErrorResponse(HttpStatus.BAD_REQUEST, ex.getMessage(), LocalDate.now()), HttpStatus.BAD_REQUEST);
    }

}