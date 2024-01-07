import { Injectable } from "@angular/core";
import { environment } from 'src/environments/environment';
import { Image } from "./models/car/image";

@Injectable({
  providedIn: 'root'
})
export class CommonService {


  public getBeUrl(): string {
    return environment.apiUrl;
  }

  public calcCarImgPath(offerId: number | null, img: string): string {
    if (!offerId)
      return "";
    return `${environment.apiUrl}/car/img/${offerId}/${img}`;
  }

  public calcCarImgOrder(_images: Image[]): Image[] {
    return _images.sort((first, second) => first.orderNum - second.orderNum);
  }
}
