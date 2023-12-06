package main.retreats.repositories.client;

import main.retreats.models.client.EventCluster;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventClusterRepository extends JpaRepository<EventCluster, Long> {
}
