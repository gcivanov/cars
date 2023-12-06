package main.retreats.repositories;

import main.retreats.models.AccountEvent;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccountEventRepository extends JpaRepository<AccountEvent, Long> {
}
