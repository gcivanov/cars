package main.cars.car.repositories;

import main.cars.car.models.Maker;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MakerRepository extends JpaRepository<Maker, Long> {
    Optional<Maker> findByNameIgnoreCase(String name);
}
