package main.cars.services.login;

import jakarta.transaction.Transactional;
import main.cars.config.JwtTokenProvider;
import main.cars.config.UserDetailsImpl;
import main.cars.config.exception.ConfirmationTokeException;
import main.cars.config.exception.EmailExistsException;
import main.cars.models.Account;
import main.cars.models.Admin;
import main.cars.models.ConfirmationToken;
import main.cars.models.Role;
import main.cars.models.client.Company;
import main.cars.models.client.Employee;
import main.cars.models.enums.RoleType;
import main.cars.models.request.LoginRequest;
import main.cars.models.request.RegistrationRequest;
import main.cars.models.responses.JWTAuthResponse;
import main.cars.models.responses.AccountBaseResponse;
import main.cars.repositories.AccountRepository;
import main.cars.repositories.AdminRepository;
import main.cars.repositories.ConfirmationTokenRepository;
import main.cars.repositories.RoleRepository;
import main.cars.repositories.client.CompanyRepository;
import main.cars.repositories.client.EmployeeRepository;
import main.cars.services.email.EmailService;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.management.relation.RoleNotFoundException;
import java.time.LocalDate;
import java.util.Set;

@Service
public class AuthServiceImpl implements AuthService {

    private AuthenticationManager authenticationManager;
    private AccountRepository accountRepository;
    private AdminRepository adminRepository;
    private EmployeeRepository employeeRepository;
    private CompanyRepository companyRepository;
    private RoleRepository roleRepository;
    private PasswordEncoder passwordEncoder;
    private JwtTokenProvider jwtTokenProvider;
    private EmailService emailService;
    private ConfirmationTokenRepository confirmationTokenRepository;

    public AuthServiceImpl(
            JwtTokenProvider jwtTokenProvider,
            PasswordEncoder passwordEncoder,
            AuthenticationManager authenticationManager,
            AccountRepository accountRepository,
            AdminRepository adminRepository,
            EmployeeRepository employeeRepository,
            RoleRepository roleRepository,
            EmailService emailService,
            ConfirmationTokenRepository confirmationTokenRepository,
            CompanyRepository companyRepository) {
        this.authenticationManager = authenticationManager;
        this.passwordEncoder = passwordEncoder;
        this.jwtTokenProvider = jwtTokenProvider;
        this.accountRepository = accountRepository;
        this.adminRepository = adminRepository;
        this.employeeRepository = employeeRepository;
        this.roleRepository = roleRepository;
        this.emailService = emailService;
        this.confirmationTokenRepository = confirmationTokenRepository;
        this.companyRepository = companyRepository;
    }

    @Override
    public JWTAuthResponse login(LoginRequest loginDto) {

        Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(
                loginDto.getEmail(), loginDto.getPassword()));

        SecurityContextHolder.getContext().setAuthentication(authentication);

        String token = jwtTokenProvider.generateToken(authentication);

        JWTAuthResponse response = new JWTAuthResponse();
        response.setAccessToken(token);
        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
        response.setAccountBaseInfo(new AccountBaseResponse(userDetails.getFirstName(),
                userDetails.getLastName(), userDetails.getEmail(), userDetails.getRoles()));

        Account account = this.accountRepository.findById(userDetails.getId()).get();
        account.setLastLoggedIn(LocalDate.now());
        this.accountRepository.save(account);

        return response;
    }

    @Override
    @Transactional
    public void registration(RegistrationRequest registrationRequest) throws RoleNotFoundException, EmailExistsException {

        if (!!this.accountRepository.existsByEmailIgnoreCase(registrationRequest.getEmail())) {
            throw new EmailExistsException("Email is already in use!");
        }

        Account account = new Account();
        //TODO GEORGI add PictureUrl
        account.setFirstName(registrationRequest.getFirstName());
        account.setLastName(registrationRequest.getLastName());
        account.setEmail(registrationRequest.getEmail());
        account.setDateOfRegistration(LocalDate.now());
        account.setDateOfBirth(registrationRequest.getDateOfBirth());
        account.setGenderType(registrationRequest.getGenderType());
        account.setReceiveNewsEmails(registrationRequest.getReceiveNewsEmails());
        account.setActive(true); //TODO GEORGI remove when emails rdy
        account.setLocked(false);
        account.setPhone(registrationRequest.getPhone());

        account.setPassword(passwordEncoder.encode(registrationRequest.getPassword()));

        Role role = roleRepository.findByName(registrationRequest.getRole())
                .orElseThrow(() -> new RoleNotFoundException("Registration role not found"));

        account.setRoles(Set.of(role));
        account = this.accountRepository.save(account);

        //employee data
        if (role.getName().equals(RoleType.DEALER)) {
            Company company = new Company();
            company.setName(registrationRequest.getEmployee().getCompany().getName());
            company.setCompanyNumber(registrationRequest.getEmployee().getCompany().getCompanyNumber());
            company.setAddress(registrationRequest.getEmployee().getCompany().getAddress());
            company.setMol(registrationRequest.getEmployee().getCompany().getMol());
            company.setVatId(registrationRequest.getEmployee().getCompany().getVatId());
            company.setDescription(registrationRequest.getEmployee().getCompany().getDescription());
            company.setPhone(registrationRequest.getEmployee().getCompany().getPhone());
            company.setAdditionalInformation(registrationRequest.getEmployee().getCompany().getAdditionalInformation());
            //TODO GEORGI not in ui
            //company.setLogUrl((registrationRequest.getEmployee().getCompany().getLogUrl());
            this.companyRepository.save(company);


            Employee employee = new Employee();
            employee.setPosition(registrationRequest.getEmployee().getPosition());
            employee.setAdditionalInformation(registrationRequest.getEmployee().getAdditionalInformation());
            employee.setAccount(account);
            employee.setCompany(company);
            this.employeeRepository.save(employee);
        }
        else if (role.getName().equals(RoleType.ADMIN)) {
            Admin admin = new Admin();
            admin.setAccount(account);
            this.adminRepository.save(admin);
        }

//        this.sendRegistrationEmail(account);
    }

    //https://stackabuse.com/spring-security-email-verification-registration/
    //https://www.baeldung.com/registration-verify-user-by-email
    public void confirmRegistration(String email, String confirmationToken) {
        ConfirmationToken ct = confirmationTokenRepository.findByToken(confirmationToken)
                .orElseThrow(() -> new ConfirmationTokeException("Missing token"));

        if (ct.getExpiryDate().compareTo(LocalDate.now()) > 0) {
            throw new ConfirmationTokeException("Token expire");
        }
        Account account = accountRepository.findByEmailIgnoreCase(email)
                .orElseThrow(() -> new EmailExistsException("Email dosnt exist!"));

        account.setActive(true);
        this.accountRepository.save(account);
    }

    //TODO Georgi email not connected
    private void sendRegistrationEmail(Account account) {
        ConfirmationToken ct = new ConfirmationToken(account);
        this.confirmationTokenRepository.save(ct);
        this.emailService.createAndSendConfirmRegistration(account.getEmail(), ct.getToken());
    }
}
