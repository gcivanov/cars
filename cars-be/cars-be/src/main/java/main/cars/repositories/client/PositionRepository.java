package main.cars.repositories.client;

import main.cars.models.client.Position;
import main.cars.models.enums.RequestStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PositionRepository extends JpaRepository<Position, String> {

    List<Position> findAllByOrderByOrderNumber();
    List<Position> findAllByStatusOrderByOrderNumber(RequestStatus status);
}
