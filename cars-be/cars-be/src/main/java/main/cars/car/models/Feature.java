package main.cars.car.models;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@NoArgsConstructor
@Entity
@Table(name = "car_feature")
public class Feature {

    public Feature(String name, FeatureCategory category) {
        this.name = name;
        this.featureCategory = category;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Size(max = 60)
    @Column(nullable = false, length = 60)
    private String name;

    @NotNull
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.PERSIST})
    @JoinColumn(name = "fk_car_feature_category", nullable = false)
    private FeatureCategory featureCategory;

}
