import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { EventService } from 'src/app/services/event.service';
import { NewEventCategoryRequest } from 'src/app/services/models/new-event-category-request';
import { first } from 'rxjs';


@Component({
  selector: 'app-confirm-add-category-event-dialog',
  templateUrl: './confirm-add-category-event-dialog.html',
  styleUrls: ['./confirm-add-category-event-dialog.scss']
})
export class ConfirmAddCategoryEventDialogComponent implements OnInit {

  public fg!: FormGroup;

  constructor(public dialogRef: MatDialogRef<ConfirmAddCategoryEventDialogComponent>,
              private formBuilder: FormBuilder,
              private eventService: EventService) {
  }

  ngOnInit(): void {
    this.fg = this.formBuilder.group({
      name: ['', Validators.required],
      description: '',
    });
  }

  onConfirm(values: NewEventCategoryRequest): void {
    if (!!this.fg.valid) {
      this.eventService.addEventCategort(values)
      .subscribe({
          next: () => {
            this.dialogRef.close(true);
          },
          error: error => {
            this.dialogRef.close(false);
          }
      });
    }
  }

  onDismiss(): void {
    this.dialogRef.close(false);
  }

}
