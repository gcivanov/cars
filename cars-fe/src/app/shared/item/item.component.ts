import { Component, OnInit, Input, ViewChild, SimpleChange, ElementRef, AfterViewInit } from '@angular/core';

import { Offer } from 'src/app/services/models/car/offer';
import { Property } from 'src/app/app.models';
import { SwiperContainer } from 'swiper/element';
import { SwiperOptions } from 'swiper/types';
import { Image } from 'src/app/services/models/car/image';
import * as moment from 'moment';
import { Moment } from 'moment';
import { CommonService } from 'src/app/services/common.service';
// import { CompareOverviewComponent } from '../compare-overview/compare-overview.component';

@Component({
  selector: 'app-item',
  templateUrl: './item.component.html',
  styleUrls: ['./item.component.scss']
})
export class ItemComponent implements OnInit, AfterViewInit {

  @Input({required: true}) offer!: Offer;
  @Input() property!: Property;
  @Input() viewType: string = "grid";
  @Input() fullWidthPage: boolean = true;
  public column:number = 4;

  @ViewChild('swiper') swiper!: ElementRef<SwiperContainer>;

  swiperConfig: SwiperOptions = {
    spaceBetween: 10,
    navigation: true,
  }
  index: number = 0;

  constructor(private commonService: CommonService) {
  }

  ngOnInit() {

  }

  ngAfterViewInit() {
    //swipe
    if (this.swiper)
      this.swiper.nativeElement.swiper.activeIndex = this.index;
  }

  public getColumnCount(value: any){
    if(value == 25){
      this.column = 4;
    }
    else if(value == 33.3){
      this.column = 3;
    }
    else if(value == 50){
      this.column = 2
    }
    else{
      this.column = 1;
    }
  }

  public getEndTimeAsMoment(): Moment {
    return moment(this.offer.endDate, "YYYY-MM-DD HH:mm:SS.sssZZ");
  }


  public addToCompare(){
    // this.appService.addToCompare(this.property, CompareOverviewComponent, (this.settings.rtl) ? 'rtl':'ltr'); //ONLY ltr
  }

  public onCompare(){
    // return this.appService.Data.compareList.filter(item=>item.id == this.property.id)[0];
  }

  //swipe
  slideChange(swiper: any) {
    this.index = swiper.detail[0].activeIndex;
  }

  public getOrderImages(_images: Image[]): Image[] {
    return this.commonService.calcCarImgOrder(_images);
  }


  public getImg(image: Image): String {
    return this.commonService.calcCarImgPath(this.offer.id, image.url);
  }

  public getOfferEndDate(endDate: any) {
    let date = endDate
  }

}
