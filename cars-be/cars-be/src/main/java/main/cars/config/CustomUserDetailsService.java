package main.cars.config;

import main.cars.models.Account;
import main.cars.repositories.AccountRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private AccountRepository accountRepository;

    public CustomUserDetailsService(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Account user = this.accountRepository.findByEmailIgnoreCase(username).orElseThrow(() -> new UsernameNotFoundException("User not exists by Email"));

        return UserDetailsImpl.build(user);
    }
}
