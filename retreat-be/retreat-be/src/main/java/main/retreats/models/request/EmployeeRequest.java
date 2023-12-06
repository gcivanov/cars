package main.retreats.models.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import main.retreats.models.client.Position;

@Getter
@Setter
public class EmployeeRequest {
    @NotNull
    private Long id;

    @NotNull
    private Position position;

    @NotNull
    private String skillsText;

    //    TODO GEORGI NOT USE IT TILL WE HAVE Some Skills Field by the Users
//    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
//    @JoinColumn(name = "fk_employee", referencedColumnName = "id")
//    private Set<EmployeeSkill> employeeSkills = new HashSet<>();

    private String additionalInformation;
}

