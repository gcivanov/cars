package main.cars.car.repositories;

import main.cars.car.models.FeatureCategory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FeatureCategoryRepository extends JpaRepository<FeatureCategory, Long> {
    Optional<FeatureCategory> findByNameIgnoreCase(String name);
}
