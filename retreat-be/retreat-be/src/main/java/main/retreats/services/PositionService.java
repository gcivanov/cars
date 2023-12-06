package main.retreats.services;

import main.retreats.models.client.Position;
import main.retreats.models.enums.RequestStatus;
import main.retreats.repositories.client.PositionRepository;
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
