package main.cars.services;

import main.cars.models.client.Position;
import main.cars.models.enums.RequestStatus;
import main.cars.repositories.client.PositionRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PositionService {
    private final PositionRepository positionRepository;

    public PositionService(PositionRepository positionRepository) {
        this.positionRepository = positionRepository;
    }

    public List<Position> getAllApproved() {
        return this.positionRepository.findAllByStatusOrderByOrderNumber(RequestStatus.APPROVED);
    }
}
