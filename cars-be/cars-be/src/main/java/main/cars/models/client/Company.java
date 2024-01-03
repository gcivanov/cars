package main.cars.models.client;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "company",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = "name"),
                @UniqueConstraint(columnNames = "vatId")
        })
public class Company {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Column(nullable = false)
    private String name;

    private String logUrl;

    //ЕИК
    @NotNull
    @Column(nullable = false)
    private String companyNumber;

    @NotNull
    @Column(nullable = false)
    private String address;

    //Материално отговорно лице - управител - НЯМА ГО НА ФЕ!
    private String mol;

    //Номер по ддс
    private String vatId;

    private String description;

    @Column(columnDefinition = "VARCHAR(20) not null")
    private String phone;

    private String additionalInformation;
}
