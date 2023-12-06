package main.retreats.models;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import main.retreats.models.enums.RoleType;

@Getter
@Setter
@Entity
@Table(name = "role",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = "name")
        })
public class Role {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private RoleType name;
}
