package main.retreats.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import main.retreats.models.client.Event;

import java.time.LocalDate;

@Getter
@Setter
@Entity
public class AccountEvent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(cascade = CascadeType.DETACH)
    @JoinColumn(name = "fk_event")
    private Event event;

    //TODO GEORGI ADD IT
    private String paymentInformation;

    private String additionalInformation;

    @ManyToOne(cascade = CascadeType.DETACH)
    @JoinColumn(name = "fk_account")
    private Account account;

    @NotNull
    @Column(nullable = false)
    private LocalDate createdOn;
}
