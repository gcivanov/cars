package main.retreats.models.client;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class EmployeeSkill {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotNull
    @ManyToOne(cascade = CascadeType.DETACH)
    @JoinColumn(name = "fk_skill", nullable = false)
    private Skill skill;

    private String additionalInformation;

    @NotNull
    @Column(name = "order_number", nullable = false)
    private Integer orderNumber;
}
