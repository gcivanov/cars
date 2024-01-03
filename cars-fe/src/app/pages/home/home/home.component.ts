import { AfterViewInit, Component, ContentChildren, ElementRef, OnInit, QueryList, ViewChildren } from '@angular/core';
import { filter, map } from 'rxjs/operators';
import { Subscription, forkJoin } from 'rxjs';
import { MediaChange, MediaObserver } from '@angular/flex-layout';
import { debounceTime, distinctUntilChanged } from 'rxjs/operators';
import { Property, Pagination, Location } from 'src/app/app.models';
import { Settings, AppSettings } from 'src/app/app.settings';
import { AppService } from 'src/app/app.service';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { CarsService } from 'src/app/services/service-car/cars.service';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { Offer, SearchOrderType } from 'src/app/services/models/car/offer';
import { FormGroup } from '@angular/forms';


@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit, AfterViewInit {

  watcher: Subscription;

  public viewType: string = 'grid';
  public viewCol: number = 25;
  public offersSort: SearchOrderType | null = null;
  public searchFields?: any;

  public offers?: Offer[];

  offersTotalItems?: number = undefined;
  offersPageSize?: number = undefined;
  offersCurrentPage: number = 0;
  loadding: boolean = true;

  constructor(
              public mediaObserver: MediaObserver,
              private carService: CarsService) {


    this.watcher = mediaObserver.asObservable()
      .pipe(filter((changes: MediaChange[]) => changes.length > 0), map((changes: MediaChange[]) => changes[0]))
      .subscribe((change: MediaChange) => {
        if(change.mqAlias == 'xs') {
          this.viewCol = 100;
        }
        else if(change.mqAlias == 'sm'){
          this.viewCol = 50;
        }
        else if(change.mqAlias == 'md'){
          this.viewCol = 33.3;
        }
        else{
          this.viewCol = 25;
        }
      });
  }

  ngAfterViewInit() {
  }

  getData() {
    const myElement = document.getElementById("demo");
    console.log(myElement);
  }

  ngOnInit() {
    //Init base data
    this.loadOffers(20);
  }

  ngOnDestroy(){
    this.resetLoadMore();
    this.watcher.unsubscribe();
  }

  private resetLoadMore(){
    this.loadding = false;
  }

  public searchClicked() {
    this.loadOffers();
  }

  public searchChanged(event: FormGroup) {
    this.searchFields = event;
  }


  //search toolbar
  public changeCount(count: any){
    if (this.offersPageSize != count) {
      this.offersPageSize = count;
      this.loadOffers();
    }
  }

  public changeSorting(sort: any){
    this.offersSort = sort;
    this.loadOffers();
  }

  public changeViewType(obj: any){
    this.viewType = obj.viewType;
    this.viewCol = obj.viewCol;
  }
  //end toolbar

  //load
  loadMore() {
    this.loadding = true;
    if (this.offersCurrentPage == 0) {
      this.offers = [];
    }
    let models = null;
    if (!!this.searchFields?.value?.maker) {
      models = this.searchFields?.value?.model ? this.searchFields?.value?.model : this.searchFields?.value?.maker.models;
    }

    const requestObj = {
      page: this.offersCurrentPage,
      size: this.offersPageSize!,
      search: this.offersSort,
      price: this.searchFields?.value?.price?.from,
      priceTo: this.searchFields?.value?.price?.to,
      models: models,

      kilometersFrom: this.searchFields?.value?.kilometers?.from,
      kilometersTo: this.searchFields?.value?.kilometers?.to,
      yearFrom: this.searchFields?.value?.yearBuilt?.from,
      yearTo: this.searchFields?.value?.yearBuilt?.to,
      driveTypeList: this.searchFields?.value?.drive,
      fuelTypeList: this.searchFields?.value?.fuel,
      transmissionTypeList: this.searchFields?.value?.transmission,

    };
    forkJoin({
      pagginationOffers: this.carService.getAllOffers(requestObj),
    }).subscribe(resposneObj => {

      this.offers = this.offers?.concat(resposneObj.pagginationOffers.items);
      this.offersTotalItems = resposneObj.pagginationOffers.totalItems;
      this.loadding = false;

      ++this.offersCurrentPage;
    });

  }

  private loadOffers(pageCount: number = 20) {
    this.offersTotalItems = 0;
    if (!this.offersPageSize)
      this.offersPageSize = pageCount;
    this.offersCurrentPage = 0;
    this.loadMore();
  }
}
