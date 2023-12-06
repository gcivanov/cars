package main.retreats.repositories.client;

import main.retreats.models.client.EventPrice;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventPriceRepository extends JpaRepository<EventPrice, Long> {
}
