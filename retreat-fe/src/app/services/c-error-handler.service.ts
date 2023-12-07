import { Injectable } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';

@Injectable({
  providedIn: 'root'
})
export class CErrorHandler {

  constructor(private snackBar: MatSnackBar) {
  }

  public openErrorDialog(error: any): any {
    this.snackBar.open(error.error?.detail || error.error?.message, '×', { panelClass: 'errror', verticalPosition: 'top', duration: 13000 });
    return error;
  }
}
