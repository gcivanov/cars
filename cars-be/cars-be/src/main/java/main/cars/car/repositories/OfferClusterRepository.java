package main.cars.car.repositories;

import main.cars.car.models.OfferCluster;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface OfferClusterRepository extends JpaRepository<OfferCluster, Long> {
    Optional<OfferCluster> findByNameIgnoreCase(String name);
}
