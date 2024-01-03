import { PasswordChange } from '../models/account-event/password-change';
import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { Account } from "../models/account-event/account";
import { environment } from "src/environments/environment";
import { AccountMyUpdate } from '../models/account-event/account-my-update';

@Injectable({
  providedIn: 'root'
})
export class AccountService {
  constructor(private http: HttpClient) {
  }

  getMyAccountInfo(): Observable<Account> {
    return this.http.get<Account>(`${environment.apiUrl}/account/info`);
  }

  updateAccountData(acc: AccountMyUpdate): Observable<any> {
    return this.http.post(`${environment.apiUrl}/account/update/data`, acc);
  }

  passwordChange(passwordChange: PasswordChange): Observable<any> {
    return this.http.post<any>(`${environment.apiUrl}/account/change/password`, passwordChange);
  }
}
