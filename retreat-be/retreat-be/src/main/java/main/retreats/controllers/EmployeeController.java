package main.retreats.controllers;

import jakarta.validation.Valid;
import main.retreats.config.UserDetailsImpl;
import main.retreats.models.client.Company;
import main.retreats.models.client.Employee;
import main.retreats.models.client.Position;
import main.retreats.models.request.EmployeeRequest;
import main.retreats.models.request.SearchEmployeeRequest;
import main.retreats.services.EmployeeService;
import main.retreats.services.PositionService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;


@RestController
@RequestMapping("/employee")
public class EmployeeController {

    private final EmployeeService employeeService;
    private final PositionService positionService;

    public EmployeeController(EmployeeService employeeService,
                              PositionService positionService) {
        this.employeeService = employeeService;
        this.positionService = positionService;
    }


    @GetMapping("/info")
    public ResponseEntity<Employee> getMyInfo(@AuthenticationPrincipal UserDetailsImpl userDetails) {
        return ResponseEntity.ok(this.employeeService.getMyInfo(userDetails));
    }

    @ResponseStatus(HttpStatus.ACCEPTED)
    @PostMapping("/update")
    public Employee updateEmployee(@RequestBody @Valid EmployeeRequest employeeRequest) {
        return this.employeeService.updateEmployee(employeeRequest);
    }

    @ResponseStatus(HttpStatus.ACCEPTED)
    @PostMapping("/company/update")
    public Company updateCompany(@RequestBody @Valid Company company) {
        return this.employeeService.updateCompany(company);
    }

    @GetMapping("/all/positions")
    public ResponseEntity<List<Position>> getAllApprovedPositions() {
        return ResponseEntity.ok(this.positionService.getAllApproved());
    }

    //NOT IN USE
    @GetMapping("all")
    public ResponseEntity<List<Employee>> getAll() {
        return ResponseEntity.ok(this.employeeService.getAll());
    }

    //NOT IN USE
    @GetMapping("all/supervisors")
    public ResponseEntity<List<Employee>> getAllSupervisors() {
        return ResponseEntity.ok(this.employeeService.getAllSupervisors());
    }

    //NOT IN USE
    @ResponseStatus(HttpStatus.OK)
    @PostMapping("search")
    public Set<Employee> searchEmployee(@RequestBody SearchEmployeeRequest searchEmployeeRequest) {
        return this.employeeService.search(searchEmployeeRequest);
    }
}
