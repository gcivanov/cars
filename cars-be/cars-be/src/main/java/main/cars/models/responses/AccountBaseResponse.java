package main.cars.models.responses;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import main.cars.models.enums.RoleType;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
public class AccountBaseResponse {
    public String firstName;
    public String lastName;
    public String email;
    public Set<RoleType> roles;
}
