package main.retreats.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@Entity
public class EventRating {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Min(0)
    @Max(10)
    private Short stars;

    @NotNull
    @Column(nullable = false)
    private String comment;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "fk_account_event", nullable = false)
    private AccountEvent accountEvent;

    @NotNull
    @Column(nullable = false)
    private LocalDate createdOn;

    @NotNull
    @Column(columnDefinition = "boolean default false")
    private Boolean isBlocked;
}
