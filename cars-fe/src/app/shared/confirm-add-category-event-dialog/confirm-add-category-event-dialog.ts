import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Component, OnInit } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';


@Component({
  selector: 'app-confirm-add-category-event-dialog',
  templateUrl: './confirm-add-category-event-dialog.html',
  styleUrls: ['./confirm-add-category-event-dialog.scss']
})
export class ConfirmAddCategoryEventDialogComponent implements OnInit {

  public fg!: FormGroup;

  constructor(public dialogRef: MatDialogRef<ConfirmAddCategoryEventDialogComponent>,
              private formBuilder: FormBuilder) {
  }

  ngOnInit(): void {
    this.fg = this.formBuilder.group({
      name: ['', Validators.required],
      description: '',
    });
  }

  onConfirm(values: any): void {
    if (!!this.fg.valid) {
      // this.eventService.addEventCategort(values)
      // .subscribe({
      //     next: () => {
      //       this.dialogRef.close(true);
      //     },
      //     error: error => {
      //       this.dialogRef.close(false);
      //     }
      // });
    }
  }

  onDismiss(): void {
    this.dialogRef.close(false);
  }

}
