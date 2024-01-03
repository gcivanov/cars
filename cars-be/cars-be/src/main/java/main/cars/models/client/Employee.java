package main.cars.models.client;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import main.cars.models.Account;

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
    @JoinColumn(nullable = false, name = "fk_company")
    private Company company;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "fk_position", nullable = false)
    private Position position;

    private String additionalInformation;

    @Transient
    private String information;

    @NotNull
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(nullable = false, name = "fk_account")
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
                && Objects.equals(position, employee.position)
                && Objects.equals(additionalInformation, employee.additionalInformation);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, account.getFirstName(), account.getLastName(), account.getEmail(), company.getId());
    }
}
