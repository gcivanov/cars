package main.cars.services;

import main.cars.config.UserDetailsImpl;
import main.cars.config.exception.PasswordException;
import main.cars.models.Account;
import main.cars.models.request.AccountMyUpdateRequest;
import main.cars.models.request.PasswordChangeRequest;
import main.cars.models.responses.AccountResponse;
import main.cars.repositories.AccountRepository;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.MethodNotAllowedException;

@Service
public class AccountService {

    private AccountRepository accountRepository;
    private PasswordEncoder passwordEncoder;

    public AccountService(AccountRepository accountRepository,
                          PasswordEncoder passwordEncoder) {
        this.accountRepository = accountRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public AccountResponse getMyInfo(Long id) {
        Account account = this.accountRepository.findById(id)
                .orElseThrow(() -> new UsernameNotFoundException("Account not found"));
        return new AccountResponse(account);
    }

    public void updateMyAccountData(UserDetailsImpl tokenUserDetails, AccountMyUpdateRequest request) {
        if (!tokenUserDetails.getUsername().equals(request.getEmail())) {
            throw new MethodNotAllowedException("Account Data change not allowed", null);
        }
        Account account = this.accountRepository.findById(tokenUserDetails.getId())
                .orElseThrow(() -> new UsernameNotFoundException("Account not found"));
        account.setFirstName(request.getFirstName());
        account.setLastName(request.getLastName());
        account.setPictureUrl(request.getPictureUrl());
        account.setGenderType(request.getGenderType());
        account.setDateOfBirth(request.getDateOfBirth());
        account.setReceiveNewsEmails(request.getReceiveNewsEmails());
        account.setPhone(request.getPhone());

        this.accountRepository.save(account);
    }

    public void changeMyPassword(UserDetailsImpl tokenUserDetails, PasswordChangeRequest passwordChangeRequest) {
        if (!tokenUserDetails.getUsername().equals(passwordChangeRequest.getEmail())) {
            throw new MethodNotAllowedException("Password change not allowed", null);
        }
        Account account = this.accountRepository.findById(tokenUserDetails.getId())
                .orElseThrow(() -> new UsernameNotFoundException("Account not found"));

        if (!this.passwordEncoder.matches(passwordChangeRequest.getCurrentPassword(), account.getPassword())) {
            throw new PasswordException("Password change not allowed");
        }

        account.setPassword(this.passwordEncoder.encode(passwordChangeRequest.getNewPassword()));
        this.accountRepository.save(account);
    }
}
