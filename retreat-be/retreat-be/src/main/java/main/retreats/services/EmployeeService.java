package main.retreats.services;

import jakarta.transaction.Transactional;
import main.retreats.config.UserDetailsImpl;
import main.retreats.config.exception.DataNotFoundException;
import main.retreats.models.client.Company;
import main.retreats.models.client.Employee;
import main.retreats.models.client.EmployeeSkill;
import main.retreats.models.client.Skill;
import main.retreats.models.request.EmployeeRequest;
import main.retreats.models.request.SearchEmployeeRequest;
import main.retreats.models.request.SearchSkillRequest;
import main.retreats.repositories.client.CompanyRepository;
import main.retreats.repositories.client.EmployeeRepository;
import main.retreats.repositories.client.EmployeeSkillRepository;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class EmployeeService {

    private final static int MINIMUM_RESULT_SKILLS = 5;

    private final EmployeeRepository employeeRepository;

    private final CompanyRepository companyRepository;

    private final EmployeeSkillRepository employeeSkillRepository;

    private final SkillService skillService;

    public EmployeeService(EmployeeRepository employeeRepository,
                           EmployeeSkillRepository employeeSkillRepository,
                           SkillService skillService,
                           CompanyRepository companyRepository) {
        this.employeeRepository = employeeRepository;
        this.employeeSkillRepository = employeeSkillRepository;
        this.skillService = skillService;
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
        employee.setSkillsText(employeeRequest.getSkillsText());
        employee.setAdditionalInformation(employeeRequest.getAdditionalInformation());

        Employee employeeResult = this.employeeRepository.save(employee);
        return employeeResult;
    }

    public Company updateCompany(Company company) {
        Company companyResult = this.companyRepository.save(company);
        return companyResult;
    }

    //TODO GEORGI NOT IN USE to end

    public List<Employee> getAll() {
        return this.employeeRepository.findAll();
    }

    public List<Employee> getAllSupervisors() {
        return this.employeeRepository.findAllSupervisors();
    }

    public Set<EmployeeSkill> getEmployeeSkillsBasedOnSkills(Set<Long> skillIds) {
        Set<EmployeeSkill> allEmpSkills = this.employeeSkillRepository.findAllByFkSkills(skillIds);
        return allEmpSkills;
    }

    public void deleteEmployeeSkills(Set<EmployeeSkill> employeeSkills) {
        this.employeeSkillRepository.deleteAll(employeeSkills);
    }

    public Set<Employee> getEmployeesBasedOnSkills(Set<EmployeeSkill> empSkills) {
        Set<Employee> allEmp = this.employeeRepository.findAllByEmployeeSkillsIn(empSkills);
        return allEmp;
    }

    public Set<Employee> search(SearchEmployeeRequest searchEmployeeRequest) {

        Set<Employee> resultEmployees = new HashSet<>();
        boolean areEmployeeNames = searchEmployeeRequest.getSearchedEmployeesNames() != null && !searchEmployeeRequest.getSearchedEmployeesNames().isEmpty();
        boolean areEmployeePositions = searchEmployeeRequest.getSearchedEmployeesPositionIds() != null && !searchEmployeeRequest.getSearchedEmployeesPositionIds().isEmpty();
        if (areEmployeeNames || areEmployeePositions) {
            if (!areEmployeeNames) {
                resultEmployees.addAll(this.employeeRepository.findAllByPositionIds(searchEmployeeRequest.getSearchedEmployeesPositionIds()));
            } else if (!areEmployeePositions) {
                resultEmployees.addAll(this.employeeRepository.findAllByStrNames(this.extractStringNames(searchEmployeeRequest.getSearchedEmployeesNames())));
            } else {
                resultEmployees.addAll(this.employeeRepository.findAllByStrNamesOrPositionIds(
                        this.extractStringNames(searchEmployeeRequest.getSearchedEmployeesNames()), searchEmployeeRequest.getSearchedEmployeesPositionIds()));
            }
        } else {
            resultEmployees.addAll(this.employeeRepository.findAll());
        }

        //TODO Create a native SQL for skill search
        Set<SearchSkillRequest> searchedSkills = searchEmployeeRequest.getSearchedSkills();
        Set<SearchSkillRequest> childSkills = new HashSet<>();
        for (SearchSkillRequest searchedSkill : searchedSkills) {
            Set<Skill> allSkills = skillService.getAllConnectedSkills(searchedSkill.getFkSkill());
            if (allSkills.size() > 1) {
                allSkills.forEach(skill -> {
                    if (!searchedSkills.stream().anyMatch(el->el.getFkSkill() == skill.getId())) {
                        childSkills.add(new SearchSkillRequest(skill.getId(), skill.getName()));
                    }
                });
            }
        }
        searchedSkills.addAll(childSkills);

//        if(searchedSkills != null && !searchedSkills.isEmpty()) {
//
//            Set<Employee> resultEmployeesAfterSkillSeach = new HashSet<>();
//            final int searchedSkillsSize = searchedSkills.size();
//            resultEmployeesAfterSkillSeach = this.filterEmployeesBySkills(resultEmployees, searchedSkills);
//
//            if (resultEmployeesAfterSkillSeach.size() < MINIMUM_RESULT_SKILLS) {
//
//                //1st search for all LVL's
//                AtomicBoolean isSkillWithSkillLvl = new AtomicBoolean(false);
//                Set<SearchSkillRequest> allLvlsSearchedSkills = searchedSkills.stream().map(el -> {
//                    SearchSkillRequest newEl = new SearchSkillRequest(el);
//                    if (newEl.getSkillLvl() != null) {
//                        newEl.setSkillLvl(null);
//                        isSkillWithSkillLvl.set(true);
//                    }
//                    return newEl;
//                }).collect(Collectors.toSet());
//
//                if (isSkillWithSkillLvl.get()) {
//                    resultEmployees.removeAll(resultEmployeesAfterSkillSeach);
//                    resultEmployeesAfterSkillSeach.addAll(this.filterEmployeesBySkills(resultEmployees, allLvlsSearchedSkills).stream().map(employee -> {
//                        employee.setInformation(String.format("Matched partly %s%% of skills", Math.round(((float) allLvlsSearchedSkills.size() / (float) searchedSkillsSize) * 100)));
//                        return employee;
//                    }).collect(Collectors.toSet()));
//                }
//
//                //Search for sub strings
//                List<Set<SearchSkillRequest>> searchedSubSkills = this.extractUniqueSubSkills(new ArrayList<>(searchedSkills));
//                for (int numElementsToRemove = 1; numElementsToRemove < searchedSkillsSize && resultEmployeesAfterSkillSeach.size() < MINIMUM_RESULT_SKILLS; ++numElementsToRemove) {
//                    final int currentSearchedSkillsSize = searchedSkillsSize - numElementsToRemove;
//                    List<Set<SearchSkillRequest>> newSkillsForSearch = searchedSubSkills.stream().filter(skill -> skill.size() == currentSearchedSkillsSize).collect(Collectors.toList());
//
//                    final int percentOfMatchedSkills = Math.round(((float) currentSearchedSkillsSize / (float) searchedSkillsSize) * 100);
//                    for (Set<SearchSkillRequest> skillsForSearch : newSkillsForSearch) {
//                        resultEmployees.removeAll(resultEmployeesAfterSkillSeach);
//                        resultEmployeesAfterSkillSeach.addAll(this.filterEmployeesBySkills(resultEmployees, skillsForSearch).stream().map(employee -> {
//                            employee.setInformation(String.format("Matched %s%% of skills", percentOfMatchedSkills));
//                            return employee;
//                        }).collect(Collectors.toSet()));
//
//                        if (isSkillWithSkillLvl.get()) {
//                            resultEmployees.removeAll(resultEmployeesAfterSkillSeach);
//                            resultEmployeesAfterSkillSeach.addAll(this.filterEmployeesBySkills(resultEmployees, skillsForSearch.stream().map
//                                            (el -> {
//                                                el.setSkillLvl(null);
//                                                return el;
//                                            }).collect(Collectors.toSet()))
//                                    .stream().map(employee -> {
//                                        employee.setInformation(String.format("Matched partly %s%% of skills", percentOfMatchedSkills));
//                                        return employee;
//                                    }).collect(Collectors.toSet()));
//                        }
//                    }
//
//                }
//                resultEmployees = resultEmployeesAfterSkillSeach;
//            }
//        }

        return resultEmployees;
    }

    private String extractStringNames(Set<String> listNames) {
        StringBuilder stringBuilder = new StringBuilder();
        if (listNames != null && !listNames.isEmpty()) {
            Iterator<String> namesIterator = listNames.iterator();
            stringBuilder.append(namesIterator.next().trim());
            while(namesIterator.hasNext()) {
                stringBuilder.append(String.format("|%s", namesIterator.next().trim()));
            }
        }
        return stringBuilder.isEmpty() ? ".*" : stringBuilder.toString();
    }

//    private Set<Employee> filterEmployeesBySkills(Set<Employee> employees, Set<SearchSkillRequest> searchedSkills) {
//        return employees.stream().filter(employee -> {
//            List<EmployeeSkill> matchedSkills = employee.getEmployeeSkills().stream().filter(empSkill ->
//                    searchedSkills.stream().filter(skill ->
//                            skill.getFkSkill() == empSkill.getSkill().getId() && (skill.getSkillLvl() == null || skill.getSkillLvl().equals(empSkill.getSkillLvl()))
//                    ).findAny().isPresent()
//            ).collect(Collectors.toList());
//            return matchedSkills.size() == searchedSkills.size();
//        }).collect(Collectors.toSet());
//    }
    public static List<Set<SearchSkillRequest>> extractUniqueSubSkills(List<SearchSkillRequest> skills) {

        if (skills.size() == 0) return Collections.emptyList();

        List<Set<SearchSkillRequest>> result = new ArrayList<>();
        Set<SearchSkillRequest> subarray = Set.of(skills.get(0));
        generateSubArrays(result, subarray, skills, 1);

        return result;
    }

    private static void generateSubArrays(List<Set<SearchSkillRequest>> result,
                                          Set<SearchSkillRequest> subarray,
                                          List<SearchSkillRequest> arr, int i) {

        if (i == arr.size()) { // base case
            result.add(subarray);
            return;
        }
        // recursive case
        result.add(subarray);
        Set<SearchSkillRequest> copy = new HashSet<>(subarray);
        copy.add(arr.get(i));
        generateSubArrays(result, copy, arr, i + 1); // proceed working with the copy
        generateSubArrays(result, Set.of(arr.get(i)), arr, i + 1); // start a new branch of subarrays
    }
}
