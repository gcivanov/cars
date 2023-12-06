package main.retreats.models.client;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import main.retreats.models.enums.CurrencyType;

import java.time.LocalDate;
import java.util.Currency;

@Getter
@Setter
@Entity
public class EventPrice {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private LocalDate fromDate;
    private LocalDate toDate;

    @NotNull
    @Column(nullable = false)
    private Double price;

    @NotNull
    @Column(nullable = false)
    private Currency currency;

    private String description; //No hotels included ..
}
