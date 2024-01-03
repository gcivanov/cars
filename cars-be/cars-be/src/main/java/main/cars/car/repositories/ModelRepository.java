package main.cars.car.repositories;

import main.cars.car.models.Maker;
import main.cars.car.models.Model;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface ModelRepository extends JpaRepository<Model, Long> {

    @Query(nativeQuery = true, value = "select * from car_model where fk_maker = :fkMaker")
    List<Model> findAllByFkMaker(Long fkMaker);
    Optional<Model> findByModelIgnoreCaseAndMaker(String model, Maker maker);
}
