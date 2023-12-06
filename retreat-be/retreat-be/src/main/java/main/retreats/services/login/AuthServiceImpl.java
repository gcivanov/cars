package main.retreats.services.login;

import jakarta.transaction.Transactional;
import main.retreats.config.JwtTokenProvider;
import main.retreats.config.UserDetailsImpl;
import main.retreats.config.exception.ConfirmationTokeException;
import main.retreats.config.exception.EmailExistsException;
import main.retreats.models.Account;
import main.retreats.models.ConfirmationToken;
import main.retreats.models.Role;
import main.retreats.models.client.Company;
import main.retreats.models.client.Employee;
import main.retreats.models.enums.RoleType;
import main.retreats.models.request.LoginRequest;
import main.retreats.models.request.RegistrationRequest;
import main.retreats.models.responses.JWTAuthResponse;
import main.retreats.models.responses.AccountBaseResponse;
import main.retreats.repositories.AccountRepository;
import main.retreats.repositories.ConfirmationTokenRepository;
import main.retreats.repositories.RoleRepository;
import main.retreats.repositories.client.CompanyRepository;
import main.retreats.repositories.client.EmployeeRepository;
import main.retreats.services.email.EmailService;
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
            EmployeeRepository employeeRepository,
            RoleRepository roleRepository,
            EmailService emailService,
            ConfirmationTokenRepository confirmationTokenRepository,
            CompanyRepository companyRepository) {
        this.authenticationManager = authenticationManager;
        this.passwordEncoder = passwordEncoder;
        this.jwtTokenProvider = jwtTokenProvider;
        this.accountRepository = accountRepository;
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
        if (role.getName().equals(RoleType.ORGANIZER)) {
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
            employee.setSkillsText(registrationRequest.getEmployee().getSkillsText());
            employee.setAdditionalInformation(registrationRequest.getEmployee().getAdditionalInformation());
            employee.setAccount(account);
            employee.setCompany(company);
            this.employeeRepository.save(employee);
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
