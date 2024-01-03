package main.cars.controllers.login;

import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import main.cars.config.exception.EmailExistsException;
import main.cars.models.request.LoginRequest;
import main.cars.models.request.RegistrationRequest;
import main.cars.models.responses.JWTAuthResponse;
import main.cars.services.login.AuthService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.management.relation.RoleNotFoundException;
import java.time.DateTimeException;
import java.time.LocalDate;

@AllArgsConstructor
@RestController
@RequestMapping("/auth")
public class AuthController {

    private AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<JWTAuthResponse> authenticate(@Valid @RequestBody LoginRequest loginDto){
        JWTAuthResponse response = authService.login(loginDto);

        return ResponseEntity.ok(response);
    }

    @PostMapping("/register")
    public ResponseEntity register(@Valid @RequestBody RegistrationRequest registrationRequest) throws RoleNotFoundException, EmailExistsException {
//        if (registrationRequest.getDateOfBirth().isAfter(LocalDate.now())) {
//            throw new DateTimeException("Invalid date of birth");
//        }
//        this.authService.registration(registrationRequest);

        return ResponseEntity.ok("");
    }

    @PostMapping("/confirm")
    public ResponseEntity confirm() {
        /*
        this.authService.confirmRegistration
         */
        return null;
    }
}
