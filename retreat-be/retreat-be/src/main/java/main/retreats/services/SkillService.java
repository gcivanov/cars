package main.retreats.services;

import main.retreats.models.client.Employee;
import main.retreats.models.client.EmployeeSkill;
import main.retreats.models.client.Skill;
import main.retreats.models.responses.SkillDeleteListResponse;
import main.retreats.repositories.client.EmployeeRepository;
import main.retreats.repositories.client.EmployeeSkillRepository;
import main.retreats.repositories.client.SkillRepository;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class SkillService {

    private final SkillRepository skillRepository;
    private final EmployeeRepository employeeRepository;
    private final EmployeeSkillRepository employeeSkillRepository;

    public SkillService(SkillRepository skillRepository,
                        EmployeeRepository employeeRepository,
                        EmployeeSkillRepository employeeSkillRepository) {
        this.skillRepository = skillRepository;
        this.employeeRepository = employeeRepository;
        this.employeeSkillRepository = employeeSkillRepository;
    }

    public List<Skill> getAll() {
        return this.skillRepository.findAll();
    }

    public Set<Skill> getAllSubSkills(Long skillId) {
        return this.getAllConnectedSkills(skillId);
    }

    public Skill save(Skill skill) {
        return this.skillRepository.save(skill);
    }

    public SkillDeleteListResponse getDeleteListBySkill(long id) {
        Set<Skill> allSkillsForDeletion = this.getAllConnectedSkills(id);
        Set<EmployeeSkill> allEmployeeSkillsForDeletion = this.employeeSkillRepository.findAllByFkSkills(allSkillsForDeletion.stream().map(Skill::getId).collect(Collectors.toSet()));
        Set<Employee> allEmployeesForDeletion = this.employeeRepository.findAllByEmployeeSkillsIn(allEmployeeSkillsForDeletion);

        //TODO Add PROJECTS
        return new SkillDeleteListResponse(allSkillsForDeletion, allEmployeesForDeletion, "TBD");
    }
    
    public List<Skill> delete(long id) {
        Set<Skill> allSkillsForDeletion = this.getAllConnectedSkills(id);
        Set<EmployeeSkill> allEmployeeSkillsForDeletion = this.employeeSkillRepository.findAllByFkSkills(allSkillsForDeletion.stream().map(Skill::getId).collect(Collectors.toSet()));
        this.employeeSkillRepository.deleteAll(allEmployeeSkillsForDeletion);
        this.skillRepository.deleteAll(allSkillsForDeletion);

        this.skillRepository.deleteById(id);

        //TODO Add PROJECTS

        return getAll();
    }

    public Set<Skill> getAllConnectedSkills(Long skillId) {
        Skill baseSkill = this.skillRepository.findById(skillId).get();
        Set<Skill> allConnectedSkills = this.findAllChildSkills(new HashSet<>(Arrays.asList(baseSkill)), new HashSet<>());
        return allConnectedSkills;
    }

    private Set<Skill> findAllChildSkills(Set<Skill> skills, Set<Skill> result) {
        if (skills != null && !skills.isEmpty()) {
            result.addAll(skills);
            skills = this.skillRepository.findAllBySuperSkillIds(
                    skills.stream().map(Skill::getId).collect(Collectors.toSet()));

            return findAllChildSkills(skills, result);
        }
        return result;
    }
}
