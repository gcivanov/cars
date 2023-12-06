package main.retreats.repositories;

import main.retreats.models.Account;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AccountRepository extends JpaRepository<Account, Long> {
    Optional<Account> findByEmailIgnoreCase(String email);
    Boolean existsByEmailIgnoreCase(String email);
}
