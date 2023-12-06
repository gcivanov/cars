package main.retreats.controllers;

import main.retreats.config.UserDetailsImpl;
import main.retreats.models.request.AccountMyUpdateRequest;
import main.retreats.models.request.PasswordChangeRequest;
import main.retreats.models.responses.AccountResponse;
import main.retreats.services.AccountService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/account")
public class AccountController {

    private AccountService accountService;

    public AccountController(AccountService accountService) {
        this.accountService = accountService;
    }

    @GetMapping("/info")
    public ResponseEntity<AccountResponse> getMyBaseInfo(@AuthenticationPrincipal UserDetailsImpl userDetails) {
        return ResponseEntity.ok(this.accountService.getMyInfo(userDetails.getId()));
    }

    @ResponseStatus(HttpStatus.OK)
    @PostMapping("/change/password")
    public void changeMyPassword(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody PasswordChangeRequest passwordChangeRequest) {
        this.accountService.changeMyPassword(userDetails, passwordChangeRequest);
    }


    @ResponseStatus(HttpStatus.OK)
    @PostMapping("/update/data")
    public void changeMyData(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody AccountMyUpdateRequest accountMyUpdateRequest) {
        this.accountService.updateMyAccountData(userDetails, accountMyUpdateRequest);
    }
}
