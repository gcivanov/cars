package main.retreats.repositories;

import main.retreats.models.EventRating;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventRatingRepository extends JpaRepository<EventRating, Long> {
}
