package main.retreats.repositories.client;

import main.retreats.models.client.Employee;
import main.retreats.models.client.EmployeeSkill;
import main.retreats.models.client.Position;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;
import java.util.Set;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {

    List<Employee> findAllByPositionNotIn(List<Position> positions);

    Optional<Employee> findByAccountId(Long accountId);

    @Query(value = "select * from employee where fk_position not in ('AC', 'C')", nativeQuery = true)
    List<Employee> findAllSupervisors();

    Set<Employee> findAllByEmployeeSkillsIn(Set<EmployeeSkill> employeeSkills);

    @Query(value = "SELECT * FROM employee WHERE first_name regexp concat_ws('|', :strNames )" +
            "  or last_name regexp concat_ws('|', :strNames ) ORDER BY last_name;", nativeQuery = true)
    List<Employee> findAllByStrNames(String strNames);

    @Query(value = "SELECT * FROM employee WHERE fk_position in :positionIds ORDER BY last_name; ", nativeQuery = true)
    List<Employee> findAllByPositionIds(Set<String> positionIds);

    @Query(value = "SELECT * FROM employee WHERE (first_name regexp concat_ws('|', :strNames )" +
            "  or last_name regexp concat_ws('|', :strNames )) AND fk_position in :positionIds ORDER BY last_name;", nativeQuery = true)
    Set<Employee> findAllByStrNamesOrPositionIds(String strNames, Set<String> positionIds);
}
