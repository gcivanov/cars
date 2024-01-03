package main.cars.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;

import java.time.LocalDate;
import java.util.UUID;

@Getter
@Entity
public class ConfirmationToken {
    private static final int EXPIRATION_DAYS = 7;

    public ConfirmationToken(Account account) {
        this.account = account;
        this.expiryDate = this.calculateExpiryDate(EXPIRATION_DAYS);
        this.token = UUID.randomUUID().toString();
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Column(nullable = false)
    private String token;

    @OneToOne(targetEntity = Account.class, fetch = FetchType.EAGER)
    @JoinColumn(nullable = false, name = "account_id")
    private Account account;

    private LocalDate expiryDate;

    private LocalDate calculateExpiryDate(int days) {
        return LocalDate.now().plusDays(days);
    }
}
