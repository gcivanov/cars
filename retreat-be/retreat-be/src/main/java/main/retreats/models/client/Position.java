package main.retreats.models.client;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import main.retreats.models.enums.RequestStatus;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "position",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = "name"),
                @UniqueConstraint(columnNames = "orderNumber")
        })
public class Position {

    @Id
    private String id;

    @NotNull
    @Column(nullable = false)
    private String name;

    private String description;

    @NotNull
    @Column(name = "order_number", nullable = false)
    private Integer orderNumber;

    @NotNull
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private RequestStatus status;
}
