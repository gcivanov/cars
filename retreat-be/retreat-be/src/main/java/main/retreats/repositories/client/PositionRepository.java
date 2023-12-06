package main.retreats.repositories.client;

import main.retreats.models.client.Position;
import main.retreats.models.enums.RequestStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PositionRepository extends JpaRepository<Position, String> {

    List<Position> findAllByOrderByOrderNumber();
    List<Position> findAllByStatusOrderByOrderNumber(RequestStatus status);
}
