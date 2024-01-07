import { Component, OnInit, ViewChild, ElementRef, AfterViewInit, Input, OnDestroy } from '@angular/core';
import { FormBuilder} from '@angular/forms';
import { ActivatedRoute } from '@angular/router';

import { SwiperOptions } from 'swiper/types';
import { CarsService } from 'src/app/services/service-car/cars.service';
import { Offer } from 'src/app/services/models/car/offer';
import { SwiperContainer } from 'swiper/element';
import { Image } from 'src/app/services/models/car/image';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { Feature } from 'src/app/services/models/car/feature';
import * as moment from 'moment';
import { Moment } from 'moment';
import { TranslateService } from '@ngx-translate/core';
import { CommonService } from 'src/app/services/common.service';

@Component({
  selector: 'app-offer',
  templateUrl: './offer.component.html',
  styleUrls: ['./offer.component.scss']
})
export class OfferComponent implements OnInit, AfterViewInit, OnDestroy {

  @Input() offer!: Offer;

  private sub: any;

  //swiper
  @ViewChild('swiper') swiper!: ElementRef<SwiperContainer>;
  swiperConfig: SwiperOptions = {
    spaceBetween: 10,
    navigation: true,
  }
  index: number = 0;

  @ViewChild('swiperThumbs') swiperThumbs!: ElementRef<SwiperContainer>;
  swiperThumbsConfig: SwiperOptions = {
    spaceBetween: 10,
    slidesPerView: 4,
    freeMode: true,
    watchSlidesProgress: true,
  }

  constructor(
              public carsService: CarsService,
              private activatedRoute: ActivatedRoute,
              private domSanitizer: DomSanitizer,
              private translate: TranslateService,
              public fb: FormBuilder,
              private commonService: CommonService) {
  }

  ngOnInit() {
    if (!this.offer) {
      this.sub = this.activatedRoute.params.subscribe(params => {

        this.carsService.getOfferById(params['id']).subscribe((offer: Offer) => {
          this.offer = offer;
          if (this.swiper)
            this.swiper.nativeElement.swiper.activeIndex = this.index;
          this.carsService.updateOfferViews(this.offer.id!).subscribe();
        });
      });
    }
  }

  ngOnDestroy() {
    if (this.sub)
      this.sub.unsubscribe();
  }

  ngAfterViewInit() {
    //swipe
    if (this.swiper)
      this.swiper.nativeElement.swiper.activeIndex = this.index;
    if (this.swiperThumbs)
      this.swiperThumbs.nativeElement.swiper.activeIndex = this.index;
  }

  public addToCompare(){
    // this.appService.addToCompare(this.property, CompareOverviewComponent, (this.settings.rtl) ? 'rtl':'ltr');
  }

  public onCompare(){
    // return this.appService.Data.compareList.filter(item=>item.id == this.property.id)[0];
  }

  //swipe
  slideChange(swiper: any) {
    this.index = swiper.detail[0].activeIndex;
  }

  public getEndTimeAsMoment(): Moment {
    return moment(this.offer.endDate, "YYYY-MM-DD HH:mm:SS.sssZZ");
  }

  //get end date as str
  public getEdnDate(): string {
    const date = this.getEndTimeAsMoment();
    let strDate = date.format("DD @ YYYY HH:mm:SS");
    strDate = strDate.replace('@', this.translate.instant(`MONTH.${date.month() + 1}`));
    return strDate;
  }

  //get ordered images
  public getOrderImages(_images: Image[]): Image[] {
    return this.commonService.calcCarImgOrder(_images);
  }

  public getImg(image: Image): String {
    return this.commonService.calcCarImgPath(this.offer.id, image.url);
  }

  //carfax link in expansion panel
  public goToCarfaxLink(offer: Offer, event: any) {
    event.stopPropagation();
    window.open(offer.carfaxLink, "_blank");
  }

  public getCarfaxUrl(offer: Offer): SafeResourceUrl {
    let url = this.domSanitizer.bypassSecurityTrustResourceUrl(offer.carfaxLink);
    return this.domSanitizer.bypassSecurityTrustResourceUrl(offer.carfaxLink);
  }

  //group features
  public groupFeauters(offer: Offer) {
    return this.groupFeaturesByCategory(offer.features);
  }
  private groupFeaturesByCategory(devices: Feature[]) {
    const categories = Array.from(new Set(devices.map(item => item.featureCategory.name)));
    return categories.map(item => {
      const categories = item ? { category: item } : null;

      return {
        ...categories,
        items: devices.filter(device => device.featureCategory.name === item)
      };
    });
  }


}
