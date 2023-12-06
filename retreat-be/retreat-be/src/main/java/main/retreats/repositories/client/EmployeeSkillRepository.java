package main.retreats.repositories.client;

import main.retreats.models.client.EmployeeSkill;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Set;

public interface EmployeeSkillRepository extends JpaRepository<EmployeeSkill, Long> {

    @Query(value = "select * from employee_skill where fk_skill in (:skillIds) ;", nativeQuery = true)
    Set<EmployeeSkill> findAllByFkSkills(Set<Long> skillIds);

}
