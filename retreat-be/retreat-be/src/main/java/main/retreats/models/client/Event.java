package main.retreats.models.client;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import main.retreats.models.enums.EventType;
import main.retreats.models.enums.RequestStatus;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@Entity
public class Event {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Column(nullable = false)
    private String name;

    @NotNull
    @Column(nullable = false)
    private String description;

    @NotNull
    @Column(nullable = false)
    private LocalDate createdOn;

    @NotNull
    @Column(nullable = false)
    private LocalDate startTime;

    @NotNull
    @Column(nullable = false)
    private LocalDate endTime;

    @NotNull
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "fk_event", referencedColumnName = "id")
    private Set<EventPrice> prices = new HashSet<>();

    @NotNull
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private EventType type;

    @ManyToMany(cascade = CascadeType.DETACH)
    @JoinTable(name = "event_event_category",
                joinColumns = {@JoinColumn(name="fk_event", referencedColumnName = "id")},
                inverseJoinColumns = {@JoinColumn(name="fk_category", referencedColumnName = "id")})
    private Set<EventCategory> category;

    private Integer maxParticipants;

    private String location;

    private String locationGooglePin;

    @ManyToOne
    @JoinColumn(name = "fk_cluster")
    private EventCluster cluster;

    private String additionalInformation;

    @NotNull
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private RequestStatus status;

    @NotNull
    @Column(nullable = false)
    private LocalDate statusDate;
}
