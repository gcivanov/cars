package main.retreats.models.request;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
public class SearchEmployeeRequest {
    private Set<SearchSkillRequest> searchedSkills;
    private Set<String> searchedEmployeesNames;
    private Set<String> searchedEmployeesPositionIds;
}
