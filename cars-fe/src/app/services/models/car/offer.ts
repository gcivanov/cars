import { Feature } from "./feature";
import { Image } from "./image";
import { Model } from "./model";

export class Offer {
  constructor(public id: number | null,
              public model: Model,
              public price: number,
              public priceTo: number | null,
              public priceNow: number | null,
              public startPrice: number | null,
              public currency: string,
              public location: string | null,
              public modelInfo: string | null,
              public engineInfo: string | null,
              public colorInfo: string | null,
              public driveType: string,
              public fuelType: string,
              public transmissionType: string,
              public startCodeType: string,
              public deliveryInfo: string | null,
              public ratingOfFive: number,
              public year: number,
              public kilometers: number,
              public seats: number | null,
              public additionalInfo: string | null,
              public carfaxLink: string,
              public features: Feature[],
              public images: Image[],
              public publishDate: Date,
              public endDate: Date,
              public active: boolean,
              public publisherUrl: string | null,
              public offerStatus: string) {
              }
}

export class PagginationOffers {
  constructor(public items: Offer[],
              public totalItems: number,
              public totalPages: number,
              public currentPage: number,
              public pageSize: number
  ) {
  }
}

export enum SearchOrderType {
  D = "D", T = "T", N = "N", L = "L", H = "H", V = "V"
}
