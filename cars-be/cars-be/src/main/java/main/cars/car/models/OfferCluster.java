package main.cars.car.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "car_offer_cluster",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = "name"),
        })
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class OfferCluster {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Column(nullable = false)
    private String name;

    private String additionalInformation;
}
