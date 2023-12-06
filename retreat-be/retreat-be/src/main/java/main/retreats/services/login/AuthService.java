package main.retreats.services.login;

import main.retreats.config.exception.EmailExistsException;
import main.retreats.models.Account;
import main.retreats.models.request.LoginRequest;
import main.retreats.models.request.RegistrationRequest;
import main.retreats.models.responses.JWTAuthResponse;

import javax.management.relation.RoleNotFoundException;
import java.util.List;

public interface AuthService {
    JWTAuthResponse login(LoginRequest loginRequest);
    void registration(RegistrationRequest registrationRequest) throws RoleNotFoundException, EmailExistsException;
}
