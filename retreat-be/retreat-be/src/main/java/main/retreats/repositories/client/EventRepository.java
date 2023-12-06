package main.retreats.repositories.client;

import main.retreats.models.client.Event;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventRepository extends JpaRepository<Event, Long> {
}
