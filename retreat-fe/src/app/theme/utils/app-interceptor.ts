import { AuthService } from './../../services/auth.service';
import { Injectable } from '@angular/core';
import { HttpEvent, HttpInterceptor, HttpHandler, HttpRequest, HttpResponse, HttpErrorResponse, HTTP_INTERCEPTORS } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';

const TOKEN_HEADER_KEY = 'Authorization';

@Injectable()
export class AppInterceptor implements HttpInterceptor {

  //private tokenService: TokenStorageService
  constructor(private authService: AuthService) {}

  intercept (req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {

      // console.log(`Request for ${req.urlWithParams} started...`);

      //const token = this.tokenService.getToken();
      //if (token) {req.clone({ headers: req.heders.set(TOKEN_HEADER_KEY, 'Barber ' + token)});

      return next.handle(req).pipe(map((event: HttpEvent<any>) => {
          if (event instanceof HttpResponse) {
            // console.log(`Request for ${req.urlWithParams} completed...`);
          }
          return event;
        }),
        catchError((error: HttpErrorResponse) => {
          const started = Date.now();
          const elapsed = Date.now() - started;
          console.log(`Request for ${req.urlWithParams} failed after ${elapsed} ms.`);
          if ([401, 403].includes(error.status) && this.authService.userValue) {
            // auto logout if 401 or 403 response returned from api
            this.authService.logout();
          }
          // debugger;
          return throwError(() => error);
        })
      );
  }
}
export const authInterveptorProvicers = [
 { provider: HTTP_INTERCEPTORS, useClass: AppInterceptor, multi: true }
];
