import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { environment } from "src/environments/environment";
import { CErrorHandler } from './c-error-handler.service';
import { EventCategory } from "./models/event";
import { NewEventCategoryRequest } from "./models/new-event-category-request";

@Injectable({
  providedIn: 'root'
})
export class EventService {
  constructor(private http: HttpClient,
              private errorHandler: CErrorHandler) {
  }

  getEventCategories(): Observable<EventCategory[]> {
    return this.http.get<EventCategory[]>(`${environment.apiUrl}/event/categories`);
  }

  addEventCategort(category: NewEventCategoryRequest): Observable<any> {
    return this.http.post<any>(`${environment.apiUrl}/event/add/category`, category);
  }


  // passwordChange(passwordChange: PasswordChange): Observable<any> {
  //   return this.http.post<any>(`${environment.apiUrl}/account/change/password`, passwordChange).pipe(
  //     catchError((error: any) => {
  //       return this.errorHandler.openErrorDialog(error);
  //     }
  //   ));
  // }
}
