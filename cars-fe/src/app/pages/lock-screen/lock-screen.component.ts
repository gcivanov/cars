import { Component, OnDestroy, OnInit, ViewEncapsulation } from '@angular/core';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators} from '@angular/forms';
import { AuthService } from 'src/app/services/auth.service';
import { LoginRequest } from 'src/app/services/models/account-event/login-request';
import { MatSnackBar } from '@angular/material/snack-bar';
import { first } from 'rxjs';
import { TranslateService } from '@ngx-translate/core';

@Component({
  selector: 'app-lock-screen',
  templateUrl: './lock-screen.component.html',
  styleUrls: ['./lock-screen.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class LockScreenComponent implements OnInit, OnDestroy {

  public date: any = new Date();
  public timerInterval: any;
  public username: string = '';
  public form!: FormGroup;

  private email?: string;

  constructor(private fb: FormBuilder,
              private router: Router,
              private authService: AuthService,
              private snackBar: MatSnackBar,
              private translate: TranslateService) {
    const accBaseInfo = this.authService.userValue?.accountBaseInfo;
    if (!!accBaseInfo) {
      this.username = `${accBaseInfo.firstName} ${accBaseInfo.lastName}`;
      this.email = accBaseInfo.email;
    } else {
      this.router.navigate(['/login']);
    }
  }

  ngOnInit() {
    this.timerInterval = setInterval(() => {
      this.date = new Date();
    }, 1000);
    this.form = this.fb.group({
      email: [this.email, {nonNullable: true}],
      password: ['', Validators.compose([Validators.required, Validators.minLength(8)])]
    });
  }

  ngAfterViewInit(){
    document.getElementById('preloader')?.classList.add('hide');
    this.authService.logout(false);
  }

  ngOnDestroy(){
    clearInterval(this.timerInterval);
  }

  public onSubmit(values: LoginRequest):void {
    if (this.form.valid) {
      this.authService.login(values)
        .pipe(first())
        .subscribe({
          next: () => {
            this.router.navigateByUrl('/');
        },
        error: error => {
          this.form.reset();
          this.snackBar.open(this.translate.instant('ERROR.PASSWORD_WRONG'), '×', { panelClass: 'errror', verticalPosition: 'top', duration: 3000 });
        }});
    }
  }

}
