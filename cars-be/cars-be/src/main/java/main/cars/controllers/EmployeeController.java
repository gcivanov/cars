package main.cars.controllers;

import jakarta.validation.Valid;
import main.cars.config.UserDetailsImpl;
import main.cars.models.client.Company;
import main.cars.models.client.Employee;
import main.cars.models.client.Position;
import main.cars.models.request.EmployeeRequest;
import main.cars.services.EmployeeService;
import main.cars.services.PositionService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
}
