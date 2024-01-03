package main.cars.services;

import main.cars.config.UserDetailsImpl;
import main.cars.config.exception.DataNotFoundException;
import main.cars.models.client.Company;
import main.cars.models.client.Employee;
import main.cars.models.request.EmployeeRequest;
import main.cars.repositories.client.CompanyRepository;
import main.cars.repositories.client.EmployeeRepository;
import org.springframework.stereotype.Service;

@Service
public class EmployeeService {

    private final EmployeeRepository employeeRepository;

    private final CompanyRepository companyRepository;



    public EmployeeService(EmployeeRepository employeeRepository,
                           CompanyRepository companyRepository) {
        this.employeeRepository = employeeRepository;
        this.companyRepository = companyRepository;
    }

    public Employee getMyInfo(UserDetailsImpl userDetails) {
        Employee emp = this.employeeRepository.findByAccountId(userDetails.getId())
                .orElseThrow(() -> new DataNotFoundException("Account not found"));
        return emp;
    }

    public Employee updateEmployee(EmployeeRequest employeeRequest) {
        Employee employee = this.employeeRepository.findById(employeeRequest.getId())
                .orElseThrow(() -> new DataNotFoundException("Employee not found"));

        employee.setPosition(employeeRequest.getPosition());
        employee.setAdditionalInformation(employeeRequest.getAdditionalInformation());

        Employee employeeResult = this.employeeRepository.save(employee);
        return employeeResult;
    }

    public Company updateCompany(Company company) {
        Company companyResult = this.companyRepository.save(company);
        return companyResult;
    }
}
