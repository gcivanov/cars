package main.retreats.models.responses;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import main.retreats.models.enums.RoleType;
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
