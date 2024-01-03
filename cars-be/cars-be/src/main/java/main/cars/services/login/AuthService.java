package main.cars.services.login;

import main.cars.config.exception.EmailExistsException;
import main.cars.models.request.LoginRequest;
import main.cars.models.request.RegistrationRequest;
import main.cars.models.responses.JWTAuthResponse;

import javax.management.relation.RoleNotFoundException;

public interface AuthService {
    JWTAuthResponse login(LoginRequest loginRequest);
    void registration(RegistrationRequest registrationRequest) throws RoleNotFoundException, EmailExistsException;
}
