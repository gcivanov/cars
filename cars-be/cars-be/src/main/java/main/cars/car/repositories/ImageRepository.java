package main.cars.car.repositories;

import main.cars.car.models.Image;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ImageRepository extends JpaRepository<Image, Long> {
    Optional<Image> findByUrlIgnoreCase(String url);
}
