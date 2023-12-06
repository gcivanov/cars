package main.retreats.repositories.client;

import main.retreats.models.client.EmployeeEvent;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmployeeEventRepository extends JpaRepository<EmployeeEvent, Long> {
}
