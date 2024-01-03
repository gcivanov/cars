import { Model } from "./model";
import { SearchOrderType } from "./offer";

export class SearchPaginationRequest {
  constructor(public page: number = 0,
              public size: number = 0,
              public search?: SearchOrderType | null,
              public price?: number | null,
              public priceTo?: number | null,
              public models?: Model[] | null,
              public kilometersFrom?: number | null,
              public kilometersTo?: number | null,
              public yearFrom?: number | null,
              public yearTo?: number | null,
              public driveTypeList?: any[] | null,
              public fuelTypeList?: any[] | null,
              public transmissionTypeList?: any[] | null) { }
}

export class ActivateOfferRequest {
  constructor(public id: number,
              public active: boolean) { }
}

export class StatusOfferRequest {
  constructor(public id: number,
              public status: string) { }
}
