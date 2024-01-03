package main.cars.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import main.cars.models.enums.GenderType;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "account",
        uniqueConstraints = {
            @UniqueConstraint(columnNames = "email")
        })
public class Account {
//TODO GEORGI history table
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Column(nullable = false)
    private String firstName;

    @NotNull
    @Column(nullable = false)
    private String lastName;

    @NotNull
    @Email
    @Column(nullable = false)
    private String email;

    @NotNull
    @Column(nullable = false)
    private String password;

    @NotNull
    @Column(columnDefinition = "boolean default true")
    private Boolean active;

    @NotNull
    @Column(columnDefinition = "boolean default false")
    private Boolean locked;

    @NotNull
    @Column(nullable = false)
    private LocalDate dateOfRegistration;

    private String pictureUrl;

    @Enumerated(EnumType.STRING)
    private GenderType genderType;

    @NotNull
    @Column(nullable = false)
    private LocalDate dateOfBirth;

    @NotNull
    @Column(nullable = false)
    private Boolean receiveNewsEmails;

    @NotNull
    @Column(columnDefinition = "VARCHAR(20) not null")
    private String phone;

    private LocalDate lastLoggedIn;

    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(  name = "account_role",
            joinColumns = @JoinColumn(name = "account_id"),
            inverseJoinColumns = @JoinColumn(name = "role_id"))
    private Set<Role> roles = new HashSet<>();
}
