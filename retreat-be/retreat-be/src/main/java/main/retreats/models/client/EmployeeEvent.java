package main.retreats.models.client;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import main.retreats.models.EventRating;
import main.retreats.models.client.Event;

import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@Entity
public class EmployeeEvent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(cascade = CascadeType.DETACH)
    @JoinColumn(name = "fk_event")
    private Event event;

    @ManyToOne(cascade = CascadeType.DETACH)
    @JoinColumn(name = "fk_employee")
    private Employee employee;

    @NotNull
    @Column(columnDefinition = "boolean default false")
    private boolean isOwner;

    private String additionalInformation;

    @OneToMany(cascade = CascadeType.DETACH, fetch = FetchType.LAZY)
    @JoinColumn(name = "fk_employee_event", referencedColumnName = "id")
    private Set<EventRating> eventRatings;
}
