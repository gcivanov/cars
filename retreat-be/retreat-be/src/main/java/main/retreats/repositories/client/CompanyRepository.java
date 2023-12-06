package main.retreats.repositories.client;

import main.retreats.models.client.Company;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CompanyRepository extends JpaRepository<Company, Long> {
}
