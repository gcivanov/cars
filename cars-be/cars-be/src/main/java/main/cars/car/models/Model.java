package main.cars.car.models;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.Set;

@Getter
@Entity
@NoArgsConstructor
@Table(name = "car_model")
public class Model {

    public Model(String model, Maker maker) {
        this.model = model;
        this.maker = maker;
        this.addedDate = LocalDate.now();
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Column(nullable = false)
    private String model;

    private LocalDate addedDate;

    @NotNull
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.PERSIST}, fetch = FetchType.EAGER)
    @JoinColumn(nullable = false, name = "fk_maker")
    private Maker maker;
}
