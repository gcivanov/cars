import { EmployeeService } from './../../../services/employee.service';
import { Component, OnInit, ViewChild } from '@angular/core';
import { AbstractControlOptions, FormBuilder, FormGroup, NgForm, Validators } from '@angular/forms';
import { emailValidator, matchingPasswords } from 'src/app/theme/utils/app-validators';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Account, GenderType, RoleType } from 'src/app/services/models/account';
import { AccountService } from 'src/app/services/account.service';
import { PasswordChange } from 'src/app/services/models/password-change';
import { TranslateService } from '@ngx-translate/core';
import { AccountMyUpdate } from 'src/app/services/models/account-my-update';
import { formatCustomDate } from 'src/app/theme/utils/app-common';
import { AuthService } from 'src/app/services/auth.service';
import { forkJoin } from "rxjs";
import { Employee, Position } from 'src/app/services/models/employee';
import { Company } from 'src/app/services/models/company';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {

  public userTypes = [
    { id: RoleType.USER },
    { id: RoleType.ORGANIZER }
  ];
  public genderTypes = [
    { id: GenderType.MAN },
    { id: GenderType.WOMAN },
    { id: GenderType.UNDEFINED }
  ];
  // public skillsTypes = [];

  //Employee
  public allPositions?: Position[];

  public hide = true;
  public infoForm?: FormGroup;
  @ViewChild('passwordFormNgForm') passwordFormNgForm?: NgForm;
  public passwordForm?: FormGroup;
  public professionalForm!: FormGroup;
  public companyForm!: FormGroup;

  public infoFormChanges: boolean = false;
  public passwordFormChanges: boolean = false;
  public professionalFormChanges: boolean = false;
  public companyFormChanges: boolean = false;
  public showCompanyData: boolean = false;

  constructor(private formBuilder: FormBuilder,
              private snackBar: MatSnackBar,
              private translate: TranslateService,
              private authService: AuthService,
              private accountService: AccountService,
              private employeeService: EmployeeService) {

    this.showCompanyData = !!!this.authService.userValue?.accountBaseInfo?.roles?.includes(RoleType.USER);
  }

  ngOnInit() {

    /**
     *
    forkJoin([
      this.userService.getEmployees(),
      this.skillService.getSills()
    ]).subscribe(resArr => {
     */

    if (!!!this.showCompanyData) {
      this.accountService.getMyAccountInfo().subscribe((account: Account) => {
        let info = account;
        this.setupInitForm(info);
      });
    } else {
      forkJoin({
        account: this.accountService.getMyAccountInfo(),
        allPositions: this.employeeService.getAllPositions(),
        employee: this.employeeService.getMyEmployeeInfo()}
      ).subscribe(resposneObj => {
        this.setupInitForm(resposneObj.account);
        this.allPositions = resposneObj.allPositions;
        this.setupEmployeeForm(resposneObj.employee);
      });
    }
    this.setupResetPasswordForm();

  }

  public onInfoFormSubmit(values: AccountMyUpdate):void {
    if (this.infoForm?.valid) {
      values.email = this.infoForm?.get('email')?.value;
      if (typeof values.dateOfBirth === 'object') {
        values.dateOfBirth = formatCustomDate(values.dateOfBirth);
      }
      this.accountService.updateAccountData(values).subscribe({
        next: (v) => {
          this.snackBar.open(this.translate.instant('SUCCESS.ACCOUNT_UPDATE'), '×', { panelClass: 'success', verticalPosition: 'top', duration: 3000 })
        },
        error: (error) => this.snackBar.open(error.error?.detail || error.error?.message, '×', { panelClass: 'errror', verticalPosition: 'top', duration: 3000 }),
      });
    }
  }

  public onPasswordFormSubmit(values: PasswordChange):void {
    if (this.passwordForm?.valid) {
      values.email = this.infoForm?.get('email')?.value;
      this.accountService.passwordChange(values).subscribe({
        next: (v) => {
          this.passwordFormNgForm?.resetForm();
          this.snackBar.open(this.translate.instant('SUCCESS.PASSWORD_RESET'), '×', { panelClass: 'success', verticalPosition: 'top', duration: 3000 })
        }
      });

    }
  }
  public onCompamyFormSubmit(values: Company):void {
    if (this.companyForm?.valid) {
      this.employeeService.updateCompany(values).subscribe({
        next: (v) => {
          this.setupCompanyForm(v);
          this.snackBar.open(this.translate.instant('SUCCESS.COMPANY_FORM_RESET'), '×', { panelClass: 'success', verticalPosition: 'top', duration: 3000 })
        },
        error: (error) => {
          this.companyForm.reset();
          this.snackBar.open(error.error?.detail || error.error?.message, '×', { panelClass: 'errror', verticalPosition: 'top', duration: 3000 })
        }
      });
    }
  }
  public onProfessionalFormSubmit(values: Employee):void {
    if (this.professionalForm?.valid) {
      this.employeeService.updateEmplyee(values).subscribe({
        next: (v) => {
          this.setupEmployeeForm(v);
          this.snackBar.open(this.translate.instant('SUCCESS.ACCOUNT_UPDATE'), '×', { panelClass: 'success', verticalPosition: 'top', duration: 3000 });
        },
        error: (error) => {
          this.professionalForm.reset();
          this.snackBar.open(error.error?.detail || error.error?.message, '×', { panelClass: 'errror', verticalPosition: 'top', duration: 3000 })
        }
      });
    }
  }

  private setupInitForm(info: Account) {
    this.infoForm = this.formBuilder.group({
      id: [info.id, {nonNullable: true}],
      role: [{value: info.roles.toString(), disabled: true}, {nonNullable: true, Validators: Validators.required}] ,
      firstName: [info.firstName, { Validators: [Validators.required, Validators.minLength(2)]}],
      lastName: [info.lastName, {nonNullable: true, Validators: [Validators.required, Validators.minLength(2)]}],
      email: [{value: info.email, disabled: true}, {nonNullable: true, Validators: [Validators.required, Validators.email, emailValidator]}],
      dateOfBirth: [info.dateOfBirth, {nonNullable: true, Validators: [Validators.required, Validators.pattern(/^\d{1,2}\.\d{1,2}\.\d{4}$/)]}],
      genderType: [info.genderType, {nonNullable: true, Validators: [Validators.required]}],
      phone: [info.phone, {nonNullable: true, Validators:
        [Validators.required, Validators.pattern("^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$")]}],
      receiveNewsEmails: [info.receiveNewsEmails, {nonNullable: true}],
    });
    this.infoForm.valueChanges.subscribe(() => {
      if (this.infoForm?.get('dateOfBirth')?.valid) {
        if (this.infoForm?.get('dateOfBirth')?.value != null) {
          this.infoFormChanges = true;
        } else {
          this.infoForm?.get('dateOfBirth')?.setErrors(Validators.required);
        }
      }
    });
  }

  private setupResetPasswordForm() {
    this.passwordForm = this.formBuilder.group({
      currentPassword: ['', Validators.compose([Validators.required, Validators.minLength(8)])],
      newPassword: ['', Validators.compose([Validators.required, Validators.minLength(8)])],
      confirmNewPassword: ['', Validators.required],
    }, {validator: matchingPasswords('newPassword', 'confirmNewPassword')} as AbstractControlOptions);
    this.passwordForm.valueChanges.subscribe(() => this.passwordFormChanges = true);
  }

  private setupEmployeeForm(emp: Employee) {
    this.setupCompanyForm(emp.company);

    this.professionalForm = this.formBuilder.group({
      id: [emp.id, {nonNullable: true}],
      position: [emp.position, {nonNullable: true, Validators: [Validators.required]}],
      skillsText: [emp.skillsText, {nonNullable: true, Validators: [Validators.required]}],
      additionalInformation: [emp.company.additionalInformation, {nonNullable: true}]
    });
    this.professionalForm.valueChanges.subscribe(() => this.professionalFormChanges = true);
  }

  private setupCompanyForm(company: Company) {
    this.companyForm = this.formBuilder.group({
      id: [company.id, {nonNullable: true}],
      name: [company.name, {nonNullable: true, Validators: [Validators.required]}],
      address: [company.address, {nonNullable: true, Validators: [Validators.required, Validators.minLength(5)]}],
      companyNumber: [company.companyNumber, {nonNullable: true, Validators: [Validators.required, Validators.pattern("^[0-9]{9}")]}],
      vatId: [company.vatId, {nonNullable: true, Validators: [Validators.pattern("^$|^[A-Z]{2}[0-9]{9}")]}],
      description: [company.description, {nonNullable: true, Validators: [Validators.required]}],
      phone: [company.phone, {nonNullable: true, Validators:
        [Validators.required, Validators.pattern("^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$")]}],
      additionalInformation: company.additionalInformation,


      organization: null,
      facebook: null,
      twitter: null,
      linkedin: null,
      instagram: null,
      website: null
    });
    this.companyForm.valueChanges.subscribe(() => this.companyFormChanges = true);
  }

  comparePositionObjects(obj1: Position, obj2: Position) {
    return obj1 && obj2 && obj1.id === obj2.id;
  }
}
