import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { emailValidator } from '../../utils/app-validators';

@Component({
  selector: 'app-footer',
  templateUrl: './footer.component.html',
  styleUrls: ['./footer.component.scss']
})
export class FooterComponent implements OnInit {

  public feedbackForm!: FormGroup;
  public subscribeForm!: FormGroup;
  constructor(public formBuilder: FormBuilder) { }

  ngOnInit() {
    this.feedbackForm = this.formBuilder.group({
      email: ['', Validators.compose([Validators.required, emailValidator])],
      message: ['', Validators.required]
    });
    this.subscribeForm = this.formBuilder.group({
      email: ['', Validators.compose([Validators.required, emailValidator])]
    });
  }

  public onFeedbackFormSubmit(values:Object):void {
    if (this.feedbackForm.valid) {
      console.log(values);
    }
  }

  public onSubscribeFormSubmit(values:Object):void {
    if (this.subscribeForm.valid) {
      console.log(values);
    }
  }

}
