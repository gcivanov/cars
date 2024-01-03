import { ErrorHandler, Injectable } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';

@Injectable({
  providedIn: 'root'
})
export class GlobalErrorHandler implements ErrorHandler {

  constructor(private snackBar: MatSnackBar,
              private translate: TranslateService) {
  }
  handleError(error: any): void {
    //HttpErrorResponse is the error from end-point
    this.snackBar.open(this.translate.instant('ERROR.PLEASE_TRY_AGAIN'), '×', { panelClass: 'errror', verticalPosition: 'top', duration: 15000 });
    // console.error(error);
  }
}
