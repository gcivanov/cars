import {  merge } from 'rxjs';
import { CurrencyType, EventType, activeCurrencies, REPEAT_INTERVAL } from './../../services/models/event';
import { Component, OnInit, ViewChild, ElementRef, NgZone } from '@angular/core';
import { MatStepper } from '@angular/material/stepper';
import { FormGroup, FormBuilder, Validators, FormArray, AbstractControlOptions } from '@angular/forms';
import { EventService } from 'src/app/services/event.service';
import { MatSnackBar } from '@angular/material/snack-bar';
import { EventCategory } from 'src/app/services/models/event';

import { ThemePalette } from '@angular/material/core';
import { dateBetween } from 'src/app/theme/utils/app-validators';
import { MatDialog } from '@angular/material/dialog';
import { ConfirmAddCategoryEventDialogComponent } from 'src/app/shared/confirm-add-category-event-dialog/confirm-add-category-event-dialog';
import { MatCheckboxChange } from '@angular/material/checkbox';
// import { MapsAPILoader } from '@agm/core';
import * as moment from 'moment';
import { DateRange } from '@angular/material/datepicker';

@Component({
  selector: 'app-submit',
  templateUrl: './submit.component.html',
  styleUrls: ['./submit.component.scss']
})
export class SubmitComponent implements OnInit {
  @ViewChild('horizontalStepper') horizontalStepper!: MatStepper;
  // @ViewChild('addressAutocomplete') addressAutocomplete!: ElementRef;
  public submitForm!: FormGroup;
  public features = [];

  //events
  public eventCategories: EventCategory[] = [];
  public eventTypes: EventType[] = [
    EventType.RETREAT,
    EventType.EVENT
  ];
  public durationAsObj? : {
    months: number,
    weeks: number,
    days: number,
    hours: number,
    min: number
  } = undefined;

  public isRepeatableEvent: boolean = false;

  //repeat date`s
  selectedDateRange: DateRange<Date> = new DateRange(new Date('2023-04-04'), new Date('2023-04-07'));
  // {
  //   start: new Date('2023-04-04'),
  //   end: new Date('2023-04-05')
  // }

  //Prices
  public currencyTypes: CurrencyType[] = activeCurrencies;
  public isMultiPriceActive: boolean = false;
  public repeatIntervals: REPEAT_INTERVAL[] = [
    REPEAT_INTERVAL.EVERY_YEAR,
    REPEAT_INTERVAL.MONTHLY,
    REPEAT_INTERVAL.WEEKLY,
    REPEAT_INTERVAL.CUSTOM_INTERVAL
  ]

  // public propertyStatuses = [];
  // public cities = [];
  // public neighborhoods = [];
  // public streets = [];
  // public lat: number = 40.678178;
  // public lng: number = -73.944158;
  // public zoom: number = 12;

  public disabled = false;
  public showSpinners = true;
  public showSeconds = false;
  public touchUi = false;
  public enableMeridian = false;
  public stepHour = 1;
  public stepMinute = 1;
  public stepSecond = 1;
  public color: ThemePalette = 'primary';
  public minDate?: any;
  public maxDate?: any;


  constructor(private eventService: EventService,
              private fb: FormBuilder,
              private snackBar: MatSnackBar,
              public dialog: MatDialog,
              // private mapsAPILoader: MapsAPILoader,
              private ngZone: NgZone) {

  }
  dateUpdated(){}

  ngOnInit() {

    this.eventService.getEventCategories().subscribe({
      next: (v: EventCategory[]) => {
        this.eventCategories = v;
      },
      error: (error) => this.snackBar.open(error.error?.detail || error.error?.message, '×', { panelClass: 'errror', verticalPosition: 'top', duration: 3000 }),
    });

    // this.features = this.appService.getFeatures();
    // this.propertyStatuses = this.appService.getPropertyStatuses();
    // this.cities = this.appService.getCities();
    // this.neighborhoods = this.appService.getNeighborhoods();
    // this.streets = this.appService.getStreets();

    this.submitForm = this.fb.group({
      basic: this.fb.group({
        name: ['', Validators.required],
        description: ['', Validators.required],
        startTime: ['', Validators.required],
        endTime: ['', Validators.required],
        repeatable: this.fb.group({
          isRepeatable: [false, Validators.required],
          repeatInterval: [''],
          result: this.fb.array([
            {
              date: null
            },{
              date: null
            },{
              date: null
            },{
              date: null
            },
          ]),
        }),
        type: ['', Validators.required],
        category: ['', Validators.required],
        maxParticipants: ['', Validators.required],
        additionalInformation: '',
      }, {validator: dateBetween('startTime', 'endTime')} as AbstractControlOptions)
      ,
      prices: this.fb.array([
        this.initPriceGroup()
      ]),
      address: this.fb.group({
        location: '',// ['', Validators.required],
        city: '',//['', Validators.required],
        zipCode: '',
        neighborhood: '',
        street: ''
      }),
      media: this.fb.group({
        videos: this.fb.array([ this.createVideo() ]),
        additionalFeatures: this.fb.array([ this.createFeature() ]),
        featured: false
      })
    });
    merge(
      this.submitForm.controls['basic'].get('startTime')!.valueChanges,
      this.submitForm.controls['basic'].get('endTime')!.valueChanges
    ).subscribe(values => {
      const start = this.submitForm.controls['basic'].get('startTime');
      const end = this.submitForm.controls['basic'].get('endTime');
      if (!!start && start.valid && !!end && end.value) {
        const startTime = start.value;
        const endTime = end.value;
        const duration = moment.duration(endTime.diff(startTime));

        this.durationAsObj = (duration.asMinutes() > 0) ? {
          months: duration.months(),
          weeks: duration.weeks(),
          days: duration.days() % 7,
          hours: duration.hours(),
          min: duration.minutes()
        } : undefined;
      }
    });
    this.submitForm.controls['basic'].get('repeatable')!.get('isRepeatable')!.valueChanges.subscribe(value => {
      const repeatInterval = this.submitForm.controls['basic'].get('repeatable')!.get('repeatInterval');
      repeatInterval?.setValidators(value ? Validators.required : null);
    });

    // this.setCurrentPosition();
    // this.placesAutocomplete();
  }

  get pricesFormArr() {
    return this.submitForm.get("prices") as FormArray;
  }

  private initPriceGroup(): FormGroup {
    let dateValidators = this.isMultiPriceActive ? Validators.required : null;
    return this.fb.group({
      fromDate: ['', dateValidators],
      toDate: ['', dateValidators],
      price: ['', Validators.compose([Validators.required])],
      currency: ['', Validators.required],
      description: ['']
    }, {validator: dateBetween('fromDate', 'toDate')} as AbstractControlOptions);
  }

  public changePriceRange(event: MatCheckboxChange) {
    this.isMultiPriceActive = event.checked;
    if (!!!this.isMultiPriceActive) {
      this.pricesFormArr.clear();
      this.addNewPrice();
    } else {
      this.pricesFormArr.at(0).get('fromDate')?.setValidators(Validators.required);
      this.pricesFormArr.at(0).get('toDate')?.setValidators(Validators.required);
    }
  }
  public setIsRepeatableEvent(event: MatCheckboxChange) {
    this.isRepeatableEvent = event.checked;
  }

  public addNewPrice() {
    this.pricesFormArr.push(this.initPriceGroup());
  }

  public onSelectionChange(e:any){
    if(e.selectedIndex == 4){
      this.horizontalStepper._steps.forEach(step => step.editable = false);
      console.log(this.submitForm.value);
    }
  }
  public reset(){
    this.horizontalStepper.reset();

    const videos = <FormArray>this.submitForm.controls['media'].get('videos');
    while (videos.length > 1) {
      videos.removeAt(0)
    }

    const additionalFeatures = <FormArray>this.submitForm.controls['media'].get('additionalFeatures');
    while (additionalFeatures.length > 1) {
      additionalFeatures.removeAt(0)
    }

    this.submitForm.reset({
      additional: {
        features: this.features
      },
      media:{
        featured: false
      }
    });

  }

  public openAddCategoryDialog() {
    const dialogRef = this.dialog.open(ConfirmAddCategoryEventDialogComponent, {
      maxWidth: '50vw',
      maxHeight: '50vh',
      width: '50%',
    });

    dialogRef.afterClosed().subscribe(res => {
      if (!!res) {
        this.snackBar.open(" ", '×', { panelClass: 'success', verticalPosition: 'top', duration: 3000 })
      }
    });
    return dialogRef;
  }

  // -------------------- Address ---------------------------
  // public onSelectCity(){
  //   this.submitForm.controls.address.get('neighborhood').setValue(null, {emitEvent: false});
  //   this.submitForm.controls.address.get('street').setValue(null, {emitEvent: false});
  // }
  // public onSelectNeighborhood(){
  //   this.submitForm.controls.address.get('street').setValue(null, {emitEvent: false});
  // }

  // private setCurrentPosition() {
  //   if("geolocation" in navigator) {
  //     navigator.geolocation.getCurrentPosition((position) => {
  //       this.lat = position.coords.latitude;
  //       this.lng = position.coords.longitude;
  //     });
  //   }
  // }
  // private placesAutocomplete(){
  //   // this.mapsAPILoader.load().then(() => {
  //   //   let autocomplete = new google.maps.places.Autocomplete(this.addressAutocomplete.nativeElement, {
  //   //     types: ["address"]
  //   //   });
  //   //   autocomplete.addListener("place_changed", () => {
  //   //     this.ngZone.run(() => {
  //   //       let place: google.maps.places.PlaceResult = autocomplete.getPlace();
  //   //       if (place.geometry === undefined || place.geometry === null) {
  //   //         return;
  //   //       };
  //   //       this.lat = place.geometry.location.lat();
  //   //       this.lng = place.geometry.location.lng();
  //   //       this.getAddress();
  //   //     });
  //   //   });
  //   // });
  // }

  // // public getAddress(){
  // //   this.mapsAPILoader.load().then(() => {
  // //     let geocoder = new google.maps.Geocoder();
  // //     let latlng = new google.maps.LatLng(this.lat, this.lng);
  // //     geocoder.geocode({'location': latlng}, (results, status) => {
  // //       if(status === google.maps.GeocoderStatus.OK) {
  // //         console.log(results);
  // //         //this.addresstext.nativeElement.focus();
  // //         let address = results[0].formatted_address;
  // //         this.submitForm.controls.location.setValue(address);
  // //         this.setAddresses(results[0]);
  // //       }
  // //     });
  // //   });
  // // }

  // // public getAddress(){
  // //   this.appService.getAddress(this.lat, this.lng).subscribe(response => {
  // //     console.log(response);
  // //     if(response['results'].length){
  // //       let address = response['results'][0].formatted_address;
  // //       this.submitForm.controls.address.get('location').setValue(address);
  // //       this.setAddresses(response['results'][0]);
  // //     }
  // //   })
  // // }
  // // public onMapClick(e:any){
  // //   this.lat = e.coords.lat;
  // //   this.lng = e.coords.lng;
  // //   this.getAddress();
  // // }
  // public onMarkerClick(e:any){
  //   console.log(e);
  // }

  // public setAddresses(result){
  //   this.submitForm.controls.address.get('city').setValue(null);
  //   this.submitForm.controls.address.get('zipCode').setValue(null);
  //   this.submitForm.controls.address.get('street').setValue(null);

  //   var newCity, newStreet, newNeighborhood;

  //   result.address_components.forEach(item =>{
  //     if(item.types.indexOf('locality') > -1){
  //       if(this.cities.filter(city => city.name == item.long_name)[0]){
  //         newCity = this.cities.filter(city => city.name == item.long_name)[0];
  //       }
  //       else{
  //         newCity = { id: this.cities.length+1, name: item.long_name };
  //         this.cities.push(newCity);
  //       }
  //       this.submitForm.controls.address.get('city').setValue(newCity);
  //     }
  //     if(item.types.indexOf('postal_code') > -1){
  //       this.submitForm.controls.address.get('zipCode').setValue(item.long_name);
  //     }
  //   });

  //   if(!newCity){
  //     result.address_components.forEach(item =>{
  //       if(item.types.indexOf('administrative_area_level_1') > -1){
  //         if(this.cities.filter(city => city.name == item.long_name)[0]){
  //           newCity = this.cities.filter(city => city.name == item.long_name)[0];
  //         }
  //         else{
  //           newCity = {
  //             id: this.cities.length+1,
  //             name: item.long_name
  //           };
  //           this.cities.push(newCity);
  //         }
  //         this.submitForm.controls.address.get('city').setValue(newCity);
  //       }
  //     });
  //   }

  //   if(newCity){
  //     result.address_components.forEach(item =>{
  //       if(item.types.indexOf('neighborhood') > -1){
  //         let neighborhood = this.neighborhoods.filter(n => n.name == item.long_name && n.cityId == newCity.id)[0];
  //         if(neighborhood){
  //           newNeighborhood = neighborhood;
  //         }
  //         else{
  //           newNeighborhood = {
  //             id: this.neighborhoods.length+1,
  //             name: item.long_name,
  //             cityId: newCity.id
  //           };
  //           this.neighborhoods.push(newNeighborhood);
  //         }
  //         this.neighborhoods = [...this.neighborhoods];
  //         this.submitForm.controls.address.get('neighborhood').setValue([newNeighborhood]);
  //       }
  //     })
  //   }

  //   if(newCity){
  //     result.address_components.forEach(item =>{
  //       if(item.types.indexOf('route') > -1){
  //         if(this.streets.filter(street => street.name == item.long_name && street.cityId == newCity.id)[0]){
  //           newStreet = this.streets.filter(street => street.name == item.long_name && street.cityId == newCity.id)[0];
  //         }
  //         else{
  //           newStreet = {
  //             id: this.streets.length+1,
  //             name: item.long_name,
  //             cityId: newCity.id,
  //             neighborhoodId: (newNeighborhood) ? newNeighborhood.id : null
  //           };
  //           this.streets.push(newStreet);
  //         }
  //         this.streets = [...this.streets];
  //         this.submitForm.controls.address.get('street').setValue([newStreet]);
  //       }
  //     })
  //   }

  // }




  // -------------------- Media ---------------------------
  public createVideo(): FormGroup {
    return this.fb.group({
      id: null,
      name: null,
      link: null
    });
  }
  public addVideo(): void {
    const videos = this.submitForm.controls['media'].get('videos') as FormArray;
    videos.push(this.createVideo());
  }
  public deleteVideo(index: number) {
    const videos = this.submitForm.controls['media'].get('videos') as FormArray;
    videos.removeAt(index);
  }


  public createFeature(): FormGroup {
    return this.fb.group({
      id: null,
      name: null,
      value: null
    });
  }
  public addFeature(): void {
    const features = this.submitForm.controls['media'].get('additionalFeatures') as FormArray;
    features.push(this.createFeature());
  }
  public deleteFeature(index: number) {
    const features = this.submitForm.controls['media'].get('additionalFeatures') as FormArray;
    features.removeAt(index);
  }


}
