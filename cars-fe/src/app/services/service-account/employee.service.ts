import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Employee, Position } from '../models/account-event/employee';
import { Company } from '../models/account-event/company';

@Injectable({
  providedIn: 'root'
})
export class EmployeeService {

  constructor(private http: HttpClient) {
  }

  public getAllPositions(): Observable<Position[]> {
    return this.http.get<Position[]>(`${environment.apiUrl}/employee/all/positions`);
  }

  public getMyEmployeeInfo(): Observable<Employee> {
    return this.http.get<Employee>(`${environment.apiUrl}/employee/info`);
  }

  public updateEmplyee(employee: Employee): Observable<Employee> {
    return this.http.post<Employee>(`${environment.apiUrl}/employee/update`, employee);
  }

  public updateCompany(company: Company): Observable<Company> {
    return this.http.post<Company>(`${environment.apiUrl}/employee/company/update`, company);
  }

}
