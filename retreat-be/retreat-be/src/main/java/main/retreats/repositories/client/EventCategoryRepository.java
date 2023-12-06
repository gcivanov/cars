package main.retreats.repositories.client;

import main.retreats.models.client.EventCategory;
import main.retreats.models.enums.RequestStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EventCategoryRepository extends JpaRepository<EventCategory, Long> {

    List<EventCategory> findAllByStatusOrderByName(RequestStatus status);
}
