import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { AppService } from 'src/app/app.service';
import { Property } from 'src/app/app.models';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { CarsService } from 'src/app/services/service-car/cars.service';
import { Offer, PagginationOffers } from 'src/app/services/models/car/offer';
import { MatSlideToggleChange } from '@angular/material/slide-toggle';
import { MatSnackBar } from '@angular/material/snack-bar';
import { FormGroup } from '@angular/forms';

@Component({
  selector: 'app-my-offers',
  templateUrl: './my-offers.component.html',
  styleUrls: ['./my-offers.component.scss']
})
export class MyOffersComponent implements OnInit {
  displayedColumns: string[] = ['id', 'image', 'title', 'price',  'published', 'ends', 'views', "status", 'edit']; //'image', 'title', 'published', 'views',
  dataSource!: MatTableDataSource<Offer>;

  public offers?: Offer[];
  public loading: boolean = false;
  private searchFields: any;
  public offersTotalItems: number = 0;
  public offersCurrentPage: number = 0;
  public offersPageSize: number = 50;

  public offerStatuses = [
    "OPEN", "RESERVED", "SOLD", "REMOVED"
  ]


  constructor(public carService: CarsService,
              private snackBar: MatSnackBar) { }

  ngOnInit() {
    const requestObj = {
      page: this.offersCurrentPage,
      size: this.offersPageSize
    };
    this.carService.getAllNOffers(requestObj).subscribe((res: PagginationOffers) => {
      this.initDataSource(res, true);
    });
  }

  private initDataSource(res: PagginationOffers, initLoad: boolean = false) {
    if (initLoad) {
      this.dataSource = new MatTableDataSource<Offer>(res.items);
    } else {
      this.dataSource.data = res.items;
    }
    this.offersTotalItems = res.totalItems;
  }

  public pageEvents(event: any) {
    if (event.previousPageIndex != this.offersCurrentPage) {
      this.snackBar.open("something went wron, please refresh", '×', { panelClass: 'errror', verticalPosition: 'top', duration: 3000 });
    } else {
      this.offersCurrentPage = event.pageIndex;
      this.loadOffers();
    }
  }

  public onActiveClick(event: MatSlideToggleChange, offer: Offer) {
    if (!!event) {
      const toggle: boolean = event.checked;
      this.carService.activateDeactivateOffer({id: offer.id!, active: toggle}).subscribe({
        next: () => {
          offer.active = toggle;
          this.snackBar.open('SUCCESS', '×', { panelClass: 'success', verticalPosition: 'top', duration: 3000 })
        },
        error: (error) => {
            this.snackBar.open(error.error?.detail || error.error?.message, '×', { panelClass: 'errror', verticalPosition: 'top', duration: 3000 });
            event.source.checked = !event.checked;
          }
      });
    }
  }

  public onUpdateStatusClick(event: any, offer: Offer) {
    if (!!event) {
      const value = event.value;
      this.carService.updateOfferStatus({id: offer.id!, status: value}).subscribe({
        next: () => {
          offer.offerStatus = value;
          this.snackBar.open('SUCCESS', '×', { panelClass: 'success', verticalPosition: 'top', duration: 3000 })
        },
        error: (error) => {
            this.snackBar.open(error.error?.detail || error.error?.message, '×', { panelClass: 'errror', verticalPosition: 'top', duration: 3000 });
            event.source.value = offer.offerStatus;
          }
      });

    }
  }


  public searchClicked() {
    this.loadOffers();
  }

  public searchChanged(event: FormGroup) {
    this.searchFields = event;
  }

  public getFirstOfferImage(offer: Offer): string {
    let result = offer.images.filter(el => !el.url.includes("kar-media"))
                  .sort((a, b) => a.orderNum - b.orderNum);
    return result[0]?.url;
  }

  private loadOffers() {
    this.loading = true;

    let models = null;
    if (!!this.searchFields?.value?.maker) {
      models = this.searchFields?.value?.model ? this.searchFields?.value?.model : this.searchFields?.value?.maker.models;
    }
    const requestObj = {
      page: this.offersCurrentPage,
      size: this.offersPageSize!,
      // search: this.offersSort,
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
    this.carService.getAllNOffers(requestObj).subscribe((res: PagginationOffers) => {
      this.initDataSource(res);
    });
  }
}
