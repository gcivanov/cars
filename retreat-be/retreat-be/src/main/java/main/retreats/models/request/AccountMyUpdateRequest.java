package main.retreats.models.request;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import main.retreats.models.enums.GenderType;

import java.time.LocalDate;

@Setter
@Getter
public class AccountMyUpdateRequest {

    @NotNull
    private String firstName;

    @NotNull
    private String lastName;

    @NotNull
    @Email
    private String email;

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
}