package main.cars.car.models;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;
import main.cars.models.Admin;
import org.hibernate.validator.constraints.URL;
import org.springframework.boot.context.properties.bind.DefaultValue;

import java.time.OffsetDateTime;
import java.util.Currency;
import java.util.HashSet;
import java.util.Set;


@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "car_offer")
public class Offer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @ManyToOne(cascade = {CascadeType.DETACH, CascadeType.PERSIST})
    @JoinColumn(name = "fk_car_model", nullable = false)
    private Model model;

    @Size(max = 50)
    @Column(length = 50)
    private String modelInfo;

    @Size(max = 50)
    @Column(length = 50)
    private String engineInfo;

    @Size(max = 50)
    @Column(length = 50)
    private String colorInfo;

    @NotNull
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private DriveType driveType;

    @NotNull
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private FuelType fuelType;

    @NotNull
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private TransmissionType transmissionType;

    @NotNull
    @Column(nullable = false)
    private Integer year;

    @NotNull
    @Column(nullable = false)
    private Integer kilometers;

    private Short seats;

    @Size(max = 500)
    @Column(length = 500)
    private String additionalInfo;

    @URL
    @Size(max = 220)
    @Column(length = 220)
    private String carfaxLink;

    @ManyToMany(fetch = FetchType.EAGER, cascade = {CascadeType.DETACH, CascadeType.PERSIST})
    @JoinTable(name = "car_offer_feature",
                joinColumns = @JoinColumn(name = "fk_car_offer"),
                inverseJoinColumns = @JoinColumn(name = "fk_car_feature"))
    Set<Feature> features = new HashSet<>();

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "fk_car_offer", referencedColumnName = "id")
    private Set<Image> images;

    private String location;

    @NotNull
    @Column(nullable = false)
    private Double price;

    private Double priceTo;

    private Double priceNow;

    private Double startPrice;

    @NotNull
    @Column(nullable = false, columnDefinition = "bigint default 0")
    private Long views = 0L;

    @NotNull
    @Column(nullable = false)
    private Currency currency = Currency.getInstance("BGN");

    @Enumerated(EnumType.STRING)
    private StartCodeType startCodeType;

    private String deliveryInfo;

    private Double ratingOfFive;

    @NotNull
    @Column(nullable = false)
    private Boolean active = false;

//    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX")
    @NotNull
    @Column(nullable = false)
//    private LocalDate publishDate;
    private OffsetDateTime publishDate;

//    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX")
    @NotNull
    @Column(nullable = false)
//    private LocalDate endDate;
    private OffsetDateTime endDate;

    @JsonFormat(pattern="yyyy-MM-dd")
    @NotNull
    @Size(max = 600)
    @Column(nullable = false, length = 600)
    private String publisherUrl;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, columnDefinition = "enum ('OPEN','RESERVED','SOLD','CLOSED') default 'OPEN'")
    private OfferStatusType offerStatus = OfferStatusType.OPEN;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, cascade = {CascadeType.DETACH, CascadeType.PERSIST})
    @JoinColumn(nullable = false, name = "fk_cluster")
    private OfferCluster cluster;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.DETACH)
    @JoinColumn(nullable = false, name = "fk_admin")
    private Admin admin;

}
