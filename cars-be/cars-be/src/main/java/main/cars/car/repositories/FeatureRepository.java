package main.cars.car.repositories;

import main.cars.car.models.Feature;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FeatureRepository extends JpaRepository<Feature, Long> {
    Optional<Feature> findByNameIgnoreCase(String name);
}
