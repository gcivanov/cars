import { HttpClient } from '@angular/common/http';
import { EventEmitter, Injectable, Output } from '@angular/core';
import { Account } from './models/account';
import { BehaviorSubject, Observable, catchError, map } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Router } from '@angular/router';
import { RegistrationRequest } from './models/registration-request';
import { LoginResponse } from './models/auth-response';
import { LoginRequest } from './models/login-request';
import { AccountBaseInfo } from './models/account-base-info';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  @Output() somebodyLoggedIn: EventEmitter<boolean> = new EventEmitter();

  private loginSubject: BehaviorSubject<LoginResponse | null>;
  public loginObj: Observable<LoginResponse | null>;

  constructor(private http: HttpClient,
              private router: Router) {
    this.loginSubject = new BehaviorSubject(JSON.parse(localStorage.getItem('user')!));
    this.loginObj = this.loginSubject.asObservable();
  }

  public get userValue() {
    return this.loginSubject.value;
  }

  login(loginRequest: LoginRequest): Observable<any> {

    return this.http.post<LoginResponse>(`${environment.apiUrl}/auth/login`, loginRequest)
              .pipe(map(user => {
                // store user details and jwt token in local storage to keep user logged in between page refreshes
                localStorage.setItem('user', JSON.stringify(user));
                this.loginSubject.next(user);
                this.somebodyLoggedIn.emit(true);
                return user;
              }), catchError((error: any) => {
                this.somebodyLoggedIn.emit(false);
                return error;
              }));
  }

  logout(redirect: boolean = true) {
    // remove user from local storage and set current user to null
    localStorage.removeItem('user');
    this.loginSubject.next(null);
    if (redirect) {
      this.router.navigate(['/login']);
    }
    this.somebodyLoggedIn.emit(false);
  }

  register(user: RegistrationRequest) {
    this.somebodyLoggedIn.emit(false);
    return this.http.post(`${environment.apiUrl}/auth/register`, user);
  }
}
