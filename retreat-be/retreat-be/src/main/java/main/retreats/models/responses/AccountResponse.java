package main.retreats.models.responses;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import main.retreats.models.Account;
import main.retreats.models.Role;
import main.retreats.models.enums.GenderType;
import main.retreats.models.enums.RoleType;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

@Setter
@Getter
public class AccountResponse {

    public AccountResponse(Account account) {
        this.firstName = account.getFirstName();
        this.lastName = account.getLastName();
        this.email = account.getEmail();
        this.active = account.getActive();
        this.locked = account.getLocked();
        this.dateOfRegistration = account.getDateOfRegistration();
        this.pictureUrl = account.getPictureUrl();
        this.genderType = account.getGenderType();
        this.dateOfBirth = account.getDateOfBirth();
        this.receiveNewsEmails = account.getReceiveNewsEmails();
        this.phone = account.getPhone();
        this.roles = account.getRoles().stream().map(el -> el.getName()).collect(Collectors.toSet());
        this.lastLoggedIn = account.getLastLoggedIn();
    }

    @NotNull
    private String firstName;

    @NotNull
    private String lastName;

    @NotNull
    @Email
    private String email;

    @NotNull
    private Boolean active;

    @NotNull
    private Boolean locked;

//    @JsonFormat(pattern="MM/dd/yyyy")
    @NotNull
    @JsonFormat(pattern="yyyy-MM-dd")
    private LocalDate dateOfRegistration;

    private String pictureUrl;

    @NotNull
    private GenderType genderType;

    @NotNull
    @JsonFormat(pattern="yyyy-MM-dd")
    private LocalDate dateOfBirth;

    @NotNull
    private Boolean receiveNewsEmails;

    @NotNull
    private String phone;

    @NotNull
    private Set<RoleType> roles = new HashSet<>();

    @JsonFormat(pattern="yyyy-MM-dd")
    private LocalDate lastLoggedIn;
}
