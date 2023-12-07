import { EmployeeService } from './../../services/employee.service';
import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators, AbstractControlOptions} from '@angular/forms';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { matchingPasswords, emailValidator } from 'src/app/theme/utils/app-validators';
import { GenderType, RoleType } from 'src/app/services/models/account';
import { RegistrationRequest } from 'src/app/services/models/registration-request';
import { first } from 'rxjs';
import { Employee, Position } from 'src/app/services/models/employee';
import { Company } from 'src/app/services/models/company';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {
  public userTypes = [
    { id: RoleType.USER },
    { id: RoleType.ORGANIZER }
  ];
  public genderTypes = [
    { id: GenderType.MAN },
    { id: GenderType.WOMAN },
    { id: GenderType.UNDEFINED }
  ];

  public allPositions?: Position[];

  public registerForm!: FormGroup;
  public hide = true;
  public showCompanyData: boolean = false;

  public professionalForm!: FormGroup;
  public companyForm!: FormGroup;

  constructor(public formBuilder: FormBuilder,
              public router: Router,
              public snackBar: MatSnackBar,
              private authService: AuthService,
              private employeeService: EmployeeService) { }

  ngOnInit() {
    this.authService.logout(false);
    this.employeeService.getAllPositions().subscribe((positions) => {
      this.allPositions = positions;
      this.registerForm = this.formBuilder.group({
          role: ['', Validators.required],
          firstName: ['', Validators.compose([Validators.required, Validators.minLength(2)])],
          lastName: ['', Validators.compose([Validators.required, Validators.minLength(2)])],
          email: ['', Validators.compose([Validators.required, Validators.email, emailValidator])],
          dateOfBirth: ['', Validators.compose([Validators.required])],
          genderType: ['', Validators.required],
          phone: ['', Validators.compose([Validators.required, Validators.minLength(10)])],
          password: ['', Validators.compose([Validators.required, Validators.minLength(8)])],
          confirmPassword: ['', Validators.required],
          receiveNewsEmails: false
        }, {validator: matchingPasswords('password', 'confirmPassword')} as AbstractControlOptions);

        this.registerForm.get('role')?.valueChanges.subscribe((value: RoleType) => this.showCompanyData = value === RoleType.ORGANIZER);

        this.setupEmployeeForms();

    });
  }

  public onRegisterFormSubmit(values: RegistrationRequest, employee: Employee | null, company: Company | null): void {
    this.registerForm.markAllAsTouched();
    if (this.registerForm.valid) {
      let allValid = false;
      let registerRequest: RegistrationRequest = values;
      if (this.registerForm.get('role')?.getRawValue() !== RoleType.USER) {
        this.professionalForm.markAllAsTouched();
        this.companyForm.markAllAsTouched();
        if (this.professionalForm.valid && this.companyForm.valid) {
          allValid = true;
          registerRequest.employee = employee;
          registerRequest.employee!.company = company!;
        }
      } else {
        allValid = true;
      }

      if (!!allValid) {
        this.authService.register(registerRequest)
        .pipe(first())
        .subscribe({
            next: () => {
                this.snackBar.open('You registered successfully!', '×', { panelClass: 'success', verticalPosition: 'top', duration: 3000 });
                this.router.navigate(['']);
            },
            error: error => {
                this.snackBar.open(error.error.detail || error.error.message, '×', { panelClass: 'errror', verticalPosition: 'top', duration: 3000 });
            }
        });
      }


      // if (this.registerForm.get('role')?.getRawValue() === RoleType.USER) {
      //   this.snackBar.open('USER !', '×', { panelClass: 'success', verticalPosition: 'top', duration: 5000 });
      // } else {
      //   this.professionalForm.markAllAsTouched();
      //   this.companyForm.markAllAsTouched();
      //   this.snackBar.open('NOT USER !', '×', { panelClass: 'success', verticalPosition: 'top', duration: 5000 });
      // }


      console.log(values);
      console.log("e  " );
      console.log(employee);
      console.log("c  ");
      console.log(company);
    //   this.authService.register(values)
    //   .pipe(first())
    //   .subscribe({
    //       next: () => {
    //           this.snackBar.open('You registered successfully!', '×', { panelClass: 'success', verticalPosition: 'top', duration: 3000 });
    //           this.router.navigate(['']);
    //       },
    //       error: error => {
    //           this.snackBar.open(error.error.detail || error.error.message, '×', { panelClass: 'errror', verticalPosition: 'top', duration: 3000 });
    //       }
    //   });
    }
  }

  // public onCompamyFormSubmit(values:Object):void {
  //   if (this.companyForm?.valid) {
  //     this.snackBar.open('Your password changed successfully!', '×', { panelClass: 'success', verticalPosition: 'top', duration: 3000 });
  //   }
  // }
  // public onProfessionalFormSubmit(values:Object):void {
  //   if (this.professionalForm?.valid) {
  //     this.snackBar.open('Your password changed successfully!', '×', { panelClass: 'success', verticalPosition: 'top', duration: 3000 });
  //   }
  // }

  private setupEmployeeForms() {
    this.companyForm = this.formBuilder.group({
      name: ['', Validators.compose([Validators.required])],
      address: ['', Validators.compose([Validators.required, Validators.minLength(5)])],
      companyNumber: ['', Validators.compose([Validators.required, Validators.pattern("^[0-9]{9}")])],
      vatId: ['', Validators.compose([Validators.pattern("^$|^[A-Z]{2}[0-9]{9}")])],
      description: ['', Validators.required],
      phone: ['', Validators.compose([Validators.required, Validators.pattern("^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$")])],
      additionalInformation: '',
    });

    this.professionalForm = this.formBuilder.group({
      position: ['', Validators.required],
      skillsText: [[], Validators.required],
      additionalInformation: ''
    });
  }
}
