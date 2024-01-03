import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators} from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { first } from 'rxjs';
import { AuthService } from 'src/app/services/auth.service';
import { LoginRequest } from 'src/app/services/models/account-event/login-request';
import { emailValidator } from 'src/app/theme/utils/app-validators';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  public loginForm!: FormGroup;
  public hide = true;
  constructor(public fb: FormBuilder,
              public router: Router,
              public snackBar: MatSnackBar,
              private translate: TranslateService,
              private authService: AuthService) { }

  ngOnInit() {
    this.authService.logout(false);
    this.loginForm = this.fb.group({
      email: [null, Validators.compose([Validators.required, Validators.email, emailValidator])],
      password: [null, Validators.compose([Validators.required, Validators.minLength(8)])]
    });
  }

  public onLoginFormSubmit(values: LoginRequest):void {
    if (this.loginForm.valid) {
      this.authService.login(values)
              .pipe(first())
              .subscribe({
                next: () => {
                  // get return url from query parameters or default to home page
                  this.router.navigateByUrl('/');
              },
              error: error => {
                this.loginForm.reset();
                this.snackBar.open(this.translate.instant('ERROR.PLEASE_TRY_AGAIN'), '×', { panelClass: 'errror', verticalPosition: 'top', duration: 3000 });
              }});
    }
  }

}
