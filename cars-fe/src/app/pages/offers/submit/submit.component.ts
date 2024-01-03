import { CarsService } from 'src/app/services/service-car/cars.service';
import {  forkJoin, merge } from 'rxjs';
import { Component, OnInit, ViewChild, OnDestroy } from '@angular/core';
import { MatStepper } from '@angular/material/stepper';
import { FormGroup, FormBuilder, Validators, FormArray, AbstractControlOptions, FormControl } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';

import { dateBetween, numberBetween } from 'src/app/theme/utils/app-validators';
import { MatDialog } from '@angular/material/dialog';
import { MatCheckboxChange } from '@angular/material/checkbox';
import * as moment from 'moment';
import { TranslateService } from '@ngx-translate/core';
import { Offer } from 'src/app/services/models/car/offer';
import { AdditionalSearchOptions } from 'src/app/services/models/car/additional-search-options';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-submit',
  templateUrl: './submit.component.html',
  styleUrls: ['./submit.component.scss']
})
export class SubmitComponent implements OnInit, OnDestroy {
  @ViewChild('horizontalStepper') horizontalStepper!: MatStepper;

  public submitForm!: FormGroup;

  //URL
  public urlControl!: FormControl;
  public offer?: Offer;

  public infoForm?: FormGroup;
  public additionalInfoForm?: FormGroup;

  public additionalSearchOptions?: AdditionalSearchOptions;
  public loading: boolean = false;

  private subActiveRoute: any;

  constructor(
              private fb: FormBuilder,
              private snackBar: MatSnackBar,
              private router: Router,
              private carService: CarsService,
              private translate: TranslateService,
              private activatedRoute: ActivatedRoute) {

  }
  dateUpdated(){}

  ngOnInit() {

    forkJoin({
      additionalSearchOptions: this.carService.getAdditionalSearchOptions()
    }).subscribe({
        next: (resposneObj) => {
        this.additionalSearchOptions = resposneObj.additionalSearchOptions;
      },
      error: (error) =>
      this.snackBar.open(
        (error.error?.detail || error.error?.message), '×', { panelClass: 'errror', verticalPosition: 'top', duration: 3000 })
    });

    this.urlControl = this.fb.control('',
        {nonNullable: true, validators: [Validators.required, Validators.pattern(/^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$/)]});

    this.submitForm = this.fb.group({
      info: this.infoForm,
      additional: this.additionalInfoForm
    });

    this.subActiveRoute = this.activatedRoute.params.subscribe(params => {
      const offerId = params['id'];
      if (!!offerId) {
        this.loading = true;
        this.carService.getOfferById(offerId).subscribe({
          next: (offer: Offer) => {
            this.offer = offer;
            this.initForms();
            this.urlControl.setValue(this.offer.publisherUrl);
            this.urlControl.disable();
            this.loading = false;
          },
          error: (error) => {
            this.snackBar.open(
              (error.error?.detail || error.error?.message), '×', { panelClass: 'errror', verticalPosition: 'top', duration: 3000 });
            this.loading = false;
          }
      });
      }
    });


  }
  private initForms(): void {
    if (!!this.offer) {
      this.infoForm = this.fb.group({
        id: [{ value: this.offer.id, disabled: true },{nonNullable: true, validators: [Validators.required]}],
        makerName: [{ value: this.offer.model.maker.name, disabled: true }, {nonNullable: true, validators: [Validators.required]}], //NOT IN THE OBJECT
        modelName: [{ value: this.offer.model.model, disabled: true }, {nonNullable: true, validators: [Validators.required]}], //NOT IN THE OBJECT
        modelInfo:  [this.offer.modelInfo, {nonNullable: false}],
        location: [{ value: this.offer.location, disabled: true }, {nonNullable: false}],
        engineInfo: [this.offer.engineInfo, {nonNullable: false}],
        colorInfo: [this.offer.colorInfo, {nonNullable: false}],
        driveType: [this.offer.driveType, {nonNullable: true, validators: [Validators.required]}], //Dropdown
        fuelType: [this.offer.fuelType, {nonNullable: true, validators: [Validators.required]}], //Dropdown
        transmissionType: [this.offer.transmissionType, {nonNullable: true, validators: [Validators.required]}], //Dropdown
        year: [this.offer.year, {nonNullable: true, validators: [Validators.required, Validators.min(1900), Validators.max(2099)]}],
        kilometers: [this.offer.kilometers, {nonNullable: true, validators: [Validators.required, Validators.min(0)]}],
        seats: [this.offer.seats, {nonNullable: false}],

        carfaxLink: [this.offer.carfaxLink, {nonNullable: true, validators: [Validators.required]}],
      });

      this.additionalInfoForm = this.fb.group({
        price: [this.offer.price, {nonNullable: true, validators: [Validators.required, Validators.min(0)]}],
        priceTo: [this.offer.priceTo, {validators: [Validators.required, Validators.min(0)]}],
        startPrice: [this.offer.startPrice, {validators: [Validators.required, Validators.min(0)]}],
        priceNow: [this.offer.priceNow, {validators: [Validators.min(0)]}],
        currency: [{ value: this.offer.currency, disabled: true }, {nonNullable: true, validators: [Validators.required, Validators.pattern("/^[a-zA-Z]{3}")]}],
        additionalInfo: [this.offer.additionalInfo, {nonNullable: false}],
        startCodeType: [this.offer.startCodeType, {nonNullable: true, validators: [Validators.required]}],
        deliveryInfo: [ this.offer.deliveryInfo || 'Срок за доставка: 6 до 9 седмици', {nonNullable: true, validators: [Validators.required]}],
        ratingOfFive: [this.offer.ratingOfFive, {nonNullable: true, validators: [Validators.required]}],
        publishDate: [{ value: moment(this.offer.publishDate, "YYYY-MM-DD HH:mm:SS.sssZZ"), disabled: true }, {nonNullable: true, validators: [Validators.required]}],
        endDate: [moment(this.offer.endDate, 'YYYY-MM-DD HH:mm:SS.sssZZ'), {nonNullable: true, validators: [Validators.required]}],
      }, {validators: [
        dateBetween('publishDate', 'endDate'),
        numberBetween('price', 'priceTo'),
        numberBetween('startPrice', 'price'),
        numberBetween('price', 'priceNow')
      ]} as AbstractControlOptions);

      this.submitForm.setControl('info', this.infoForm);
      this.submitForm.setControl('additional', this.additionalInfoForm);
    }
  }


  public onSelectionChange(e: any){
    if(e.selectedIndex == 4){
      this.horizontalStepper._steps.forEach(step => step.editable = false);
      console.log(this.submitForm.value);
    }
  }

  //buy now checkbox
  public valueChangeBuyNowCheckbox(event: MatCheckboxChange) {
    if (!!event.checked) {
      this.additionalInfoForm?.get('priceTo')?.disable();
      this.additionalInfoForm?.get('priceTo')?.clearValidators();
      this.additionalInfoForm?.get('priceTo')?.updateValueAndValidity();
      this.additionalInfoForm?.get('startPrice')?.disable();
      this.additionalInfoForm?.get('startPrice')?.clearValidators();
      this.additionalInfoForm?.get('startPrice')?.updateValueAndValidity();
      this.additionalInfoForm?.get('priceNow')?.disable();
      this.additionalInfoForm?.get('priceNow')?.updateValueAndValidity();
    } else {
      this.additionalInfoForm?.get('priceTo')?.enable();
      this.additionalInfoForm?.get('priceTo')?.setValidators([Validators.required, Validators.min(0)]);
      this.additionalInfoForm?.get('priceTo')?.updateValueAndValidity();
      this.additionalInfoForm?.get('startPrice')?.enable();
      this.additionalInfoForm?.get('startPrice')?.setValidators([Validators.required, Validators.min(0)]);
      this.additionalInfoForm?.get('startPrice')?.updateValueAndValidity();
      this.additionalInfoForm?.get('priceNow')?.enable();
      this.additionalInfoForm?.get('priceNow')?.updateValueAndValidity();
    }
  }

  //update offer
  public updateOffer() {
    if(!!this.offer && this.infoForm?.valid && this.additionalInfoForm?.valid) {
      this.offer.year = this.infoForm.value.year;
      this.offer.transmissionType = this.infoForm.value.transmissionType;
      this.offer.seats = this.infoForm.value.seats;
      this.offer.modelInfo = this.infoForm.value.modelInfo;
      this.offer.kilometers = this.infoForm.value.kilometers;
      this.offer.fuelType = this.infoForm.value.fuelType;
      this.offer.engineInfo = this.infoForm.value.engineInfo;
      this.offer.driveType = this.infoForm.value.driveType;
      this.offer.colorInfo = this.infoForm.value.colorInfo;
      this.offer.carfaxLink = this.infoForm.value.carfaxLink;

      this.offer.additionalInfo = this.additionalInfoForm.value.additionalInfo;
      this.offer.deliveryInfo = this.additionalInfoForm.value.deliveryInfo;
      this.offer.endDate = this.additionalInfoForm.value.endDate;
      this.offer.price = this.additionalInfoForm.value.price;
      this.offer.priceTo = this.additionalInfoForm.value.priceTo;
      this.offer.priceNow = this.additionalInfoForm.value.priceNow;
      this.offer.startPrice = this.additionalInfoForm.value.startPrice;
      this.offer.ratingOfFive = this.additionalInfoForm.value.ratingOfFive;
      this.offer.startCodeType = this.additionalInfoForm.value.startCodeType;
    }
  }

  public activate() {
    if (this.offer) {
      this.offer.active = true;
      this.carService.updateOffer(this.offer).subscribe({
        next: (res: Offer) => {
          this.offer = res;
          this.router.navigate([`/offers/${this.offer.id}`]);
        },
        error: (error) => {
          this.snackBar.open(
            ((error.error?.detail || error.error?.message)), '×', { panelClass: 'errror', verticalPosition: 'top', duration: 3000 });
        }
      });
    } else {
      this.snackBar.open(
        this.translate.instant('ERROR.URL_FECH_FAILD'), '×', { panelClass: 'errror', verticalPosition: 'top', duration: 3000 })
    }
  }

  //GET URL DATA
  async fetch() {
    if (this.urlControl.valid) {

      this.loading = true;
      this.carService.fetch(this.urlControl.value).subscribe({
        next: (v: Offer) => {
          this.offer = v;
          this.initForms();
          this.snackBar.open(
            ('SUCCESS.URL_DATA_FETCH'), '×', { panelClass: 'success', verticalPosition: 'top', duration: 3000 });
          this.loading = false;
        },
        error: (error) => {
          this.snackBar.open(
            ('ERROR.URL_FECH_FAILD'), '×', { panelClass: 'errror', verticalPosition: 'top', duration: 3000 });
          this.loading = false;
        }
      });
    } else {
      this.urlControl.markAsTouched();
    }
  }

  ngOnDestroy() {
    if (this.subActiveRoute)
      this.subActiveRoute.unsubscribe();
  }
}
