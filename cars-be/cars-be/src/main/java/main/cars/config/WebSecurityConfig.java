package main.cars.config;

import lombok.AllArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@AllArgsConstructor
@Configuration
public class WebSecurityConfig {
    //https://www.bezkoder.com/spring-boot-jwt-authentication/
    //https://www.javaguides.net/2023/05/spring-boot-spring-security-jwt-mysql.html



    private CustomUserDetailsService userDetailsService;

    private JwtAuthenticationEntryPoint authEntryPoint;

    private JwtAuthenticationFilter jwtAuthenticationFilter;

    private static final String[] guardedRequests = {
            "/offer/**"};


    @Bean
    public static PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();

        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());

        return authProvider;
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception {
        return configuration.getAuthenticationManager();
    }

   @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//                .exceptionHandling(exception -> exception.authenticationEntryPoint(authEntryPoint))
        http.csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests((authorize) -> {
                    authorize.requestMatchers("/auth/login", "/employee/all/positions", "/car/**").permitAll();
                    authorize.requestMatchers(guardedRequests).authenticated();
                    authorize.anyRequest().authenticated();
                });
       http.authenticationProvider(authenticationProvider());
       http.addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);

       return http.build();
    }
}
