package main.retreats.models.client;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import main.retreats.models.enums.RequestStatus;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "event_category",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = "name")
        })
public class EventCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Column(nullable = false)
    private String name;

    private String description;

    private Long parentId;

    @NotNull
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private RequestStatus status;

    private String imageUrl;

    @NotNull
    @Email
    @Column(nullable = false)
    private String requestedBy;
}
