package main.cars.repositories;

import main.cars.models.Admin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface AdminRepository extends JpaRepository<Admin, Long> {


    @Query(value = "SELECT * FROM admin WHERE fk_account = :fk ", nativeQuery = true)
    Optional<Admin> findByFkAccount(Long fk);
}
