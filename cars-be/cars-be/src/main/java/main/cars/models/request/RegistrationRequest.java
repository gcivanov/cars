package main.cars.models.request;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import main.cars.models.client.Employee;
import main.cars.models.enums.GenderType;
import main.cars.models.enums.RoleType;
import org.hibernate.validator.constraints.Length;
import org.springframework.lang.Nullable;

import java.time.LocalDate;

@Getter
@Setter
public class RegistrationRequest {

    @NotNull
    private RoleType role;

    @NotNull
    private String firstName;

    @NotNull
    private String lastName;

    @NotNull
    @Email
    private String email;

    @NotNull
    private String password;

    @Nullable
    @Enumerated(EnumType.STRING)
    private GenderType genderType;

    @NotNull
    private LocalDate dateOfBirth;

    @NotNull
    @Length(min = 10)
    private String phone;

    @NotNull
    private Boolean receiveNewsEmails;

    @Nullable
    private Employee employee;
}
