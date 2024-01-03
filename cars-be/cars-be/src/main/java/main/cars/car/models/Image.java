package main.cars.car.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.URL;

@Getter
@Entity
@NoArgsConstructor
@Table(name = "car_image")
public class Image {

    public Image(String url, Short orderNum) {
        this.url = url;
        this.orderNum = orderNum;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @URL
    @Size(max = 600)
    @Column(length = 600, nullable = false)
    private String url;

    @NotNull
    @Column(nullable = false)
    private Short orderNum;
}
