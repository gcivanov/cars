import { catchError } from 'rxjs/operators';
import { PasswordChange } from './models/password-change';
import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { Account } from "./models/account";
import { environment } from "src/environments/environment";
import { AccountMyUpdate } from './models/account-my-update';
import { CErrorHandler } from './c-error-handler.service';

@Injectable({
  providedIn: 'root'
})
export class AccountService {
  constructor(private http: HttpClient,
              private errorHandler: CErrorHandler) {
  }

  //TODO GEORGI add global errror
  getMyAccountInfo(): Observable<Account> {
    return this.http.get<Account>(`${environment.apiUrl}/account/info`);
  }

  updateAccountData(acc: AccountMyUpdate): Observable<any> {
    return this.http.post(`${environment.apiUrl}/account/update/data`, acc);
  }

  passwordChange(passwordChange: PasswordChange): Observable<any> {
    return this.http.post<any>(`${environment.apiUrl}/account/change/password`, passwordChange).pipe(
      catchError((error: any) => {
        return this.errorHandler.openErrorDialog(error);
      }
    ));
  }
}
