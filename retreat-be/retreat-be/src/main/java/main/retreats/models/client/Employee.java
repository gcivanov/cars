package main.retreats.models.client;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import main.retreats.models.Account;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@Entity
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "fk_company")
    private Company company;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "fk_position", nullable = false)
    private Position position;

    @NotNull
    @Column(columnDefinition = "VARCHAR(520) not null")
    private String skillsText;

//    TODO GEORGI NOT USE IT TILL WE HAVE Some Skills Field by the Users
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "fk_employee", referencedColumnName = "id")
    private Set<EmployeeSkill> employeeSkills = new HashSet<>();

    private String additionalInformation;

    @Transient
    private String information;

    @NotNull
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "fk_account")
    private Account account;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Employee employee = (Employee) o;
        return Objects.equals(id, employee.id) && Objects.equals(account.getFirstName(), employee.getAccount().getFirstName())
                && Objects.equals(account.getLastName(), employee.getAccount().getLastName())
                && Objects.equals(account.getEmail(), employee.getAccount().getEmail())
                && Objects.equals(company.getId(), employee.getCompany().getId())
                && Objects.equals(position, employee.position) && Objects.equals(employeeSkills, employee.employeeSkills)
                && Objects.equals(additionalInformation, employee.additionalInformation);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, account.getFirstName(), account.getLastName(), account.getEmail(), company.getId());
    }
}
