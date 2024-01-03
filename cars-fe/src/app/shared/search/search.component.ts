import { AdditionalSearchOptions } from '../../services/models/car/additional-search-options';
import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { AbstractControlOptions, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CarsService } from 'src/app/services/service-car/cars.service';
import { forkJoin } from 'rxjs';
import { MakerResponse, ModelResponse } from 'src/app/services/models/car/responses';
import { numberBetween } from 'src/app/theme/utils/app-validators';

@Component({
  selector: 'app-search', //app-properties-search
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.scss']
})
export class SearchComponent implements OnInit {
  @Input() vertical: boolean = false;
  @Input() searchOnBtnClick: boolean = true;

  @Input() removedSearchField?: string;
  @Output() onSearchChange: EventEmitter<any> = new EventEmitter<any>();
  @Output() onSearchClick: EventEmitter<any> = new EventEmitter<any>();

  public showMore: boolean = false;
  public form!: FormGroup;
  public makers: MakerResponse[] = [];
  public models?: ModelResponse[] = [];
  public additionalSearchOptions?: AdditionalSearchOptions;


  constructor(public carService: CarsService, public fb: FormBuilder) { }

  ngOnInit() {
    if(this.vertical){
      this.showMore = true;
    };
    forkJoin({
      makerResponse: this.carService.getAllActiveMakers(),
      additionalSearchOptions: this.carService.getAdditionalSearchOptions()
    }).subscribe(resposneObj => {
      this.makers = resposneObj.makerResponse;
      this.additionalSearchOptions = resposneObj.additionalSearchOptions;
    });
    this.form = this.fb.group({
      maker: null,
      model: null,
      price: this.fb.group({
        from: [null, {nonNullable: false, validators: [Validators.min(0)]}],
        to: [null, {nonNullable: false, validators: [Validators.min(0)]}]
      }, {validator: [
        numberBetween('from', 'to')
      ]} as AbstractControlOptions),
      yearBuilt: this.fb.group({
        from: [null, {nonNullable: false, validators: [Validators.pattern(/^[1-9]{1}\d{3}$/), Validators.min(1900), Validators.max(2099)]}],
        to: [null, {nonNullable: false, validators: [Validators.pattern(/^[1-9]{1}\d{3}$/), Validators.min(1900), Validators.max(2099)]}]
      }, {validator: [
        numberBetween('from', 'to')
      ]} as AbstractControlOptions),
      transmission: null,
      fuel: null,
      drive: null,
      kilometers: this.fb.group({
        from:  [null, {nonNullable: false, validators: [Validators.min(0), Validators.max(99999999)]}],
        to:  [null, {nonNullable: false, validators: [Validators.min(0), Validators.max(99999999)]}],
      }, {validator: [
        numberBetween('from', 'to')
      ]} as AbstractControlOptions)
    });

    this.form.get('maker')?.valueChanges.subscribe((maker: MakerResponse) => {
      this.models = maker?.models?.sort((one, two) => one.model < two.model ? -1 : 1);
    });
    this.form.valueChanges.subscribe(() => {
      if (!!this.form.valid) {
        this.onSearchChange.emit(this.form);
      }
    })
  }

  public reset(){
    this.form.reset();
  }

  public search() {
    this.onSearchClick.emit();
  }
}
