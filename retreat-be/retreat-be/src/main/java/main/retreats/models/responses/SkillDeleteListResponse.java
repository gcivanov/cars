package main.retreats.models.responses;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import main.retreats.models.client.Employee;
import main.retreats.models.client.Skill;

import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class SkillDeleteListResponse {

    @JsonProperty("skills")
    private Set<Skill> allSkillsForDeletion;
    @JsonProperty("employees")
    private Set<Employee> allEmployeesForDeletion;

    @JsonProperty("projects")
    private String tbd = "tbd";
}
