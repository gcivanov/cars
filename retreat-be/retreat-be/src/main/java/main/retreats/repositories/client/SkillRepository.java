package main.retreats.repositories.client;

import main.retreats.models.client.Skill;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Set;

public interface SkillRepository extends JpaRepository<Skill, Long> {
    @Query(value = "select * from skill where super_skill_id = :superSkillId ;", nativeQuery = true)
    Set<Skill> findAllBySuperSkillId(Long superSkillId);

    @Query(value = "select * from skill where super_skill_id in (:superSkillIds) ;", nativeQuery = true)
    Set<Skill> findAllBySuperSkillIds(Set<Long> superSkillIds);

}
