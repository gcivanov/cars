import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Employee, Position } from '../models/account-event/employee';
import { Company } from '../models/account-event/company';
import { Maker } from '../models/car/maker';
import { AdditionalSearchOptions } from '../models/car/additional-search-options';
import { Offer, PagginationOffers } from '../models/car/offer';
import { Model } from '../models/car/model';
import { MakerResponse } from '../models/car/responses';
import { ActivateOfferRequest, SearchPaginationRequest, StatusOfferRequest } from '../models/car/requests';

@Injectable({
  providedIn: 'root'
})
export class CarsService {

  constructor(private http: HttpClient) {
  }

  public getAllActiveMakers(): Observable<MakerResponse[]> {
    return this.http.get<MakerResponse[]>(`${environment.apiUrl}/car/models`);
  }

  public getAdditionalSearchOptions(): Observable<AdditionalSearchOptions> {
    return this.http.get<AdditionalSearchOptions>(`${environment.apiUrl}/car/additional`);
  }

  public getAllOffers(searchPagination: SearchPaginationRequest): Observable<PagginationOffers> {
    return this.http.post<PagginationOffers>(`${environment.apiUrl}/car/offers/all`, searchPagination);
  }

  public getOfferById(id: number): Observable<Offer> {
    return this.http.get<Offer>(`${environment.apiUrl}/car/offer/${id}`)
  }

  public updateOfferViews(id: number): Observable<void> {
    return this.http.patch<void>(`${environment.apiUrl}/car/update/v/${id}`, {});
  }

  public getAllOffersNonFiltered(searchPagination: SearchPaginationRequest): Observable<PagginationOffers> {
    return this.http.post<PagginationOffers>(`${environment.apiUrl}/car/offers/all`, searchPagination);
  }

  //Guarderd requests:
  public fetch(fetchUrl: string): Observable<Offer> {
    return this.http.post<Offer>(`${environment.apiUrl}/offer/fetch`,
    {
      url: fetchUrl
    });
  }

  public updateOffer(offer: Offer): Observable<Offer> {
    return this.http.post<Offer>(`${environment.apiUrl}/offer/update`, offer);
  }


  public getAllNOffers(searchPagination: SearchPaginationRequest): Observable<PagginationOffers> {
    return this.http.post<PagginationOffers>(`${environment.apiUrl}/offer/offers/n/all`, searchPagination);
  }

  public activateDeactivateOffer(request: ActivateOfferRequest): Observable<void> {
    return this.http.post<void>(`${environment.apiUrl}/offer/offers/active`, request);
  }

  public updateOfferStatus(request: StatusOfferRequest): Observable<void> {
    return this.http.post<void>(`${environment.apiUrl}/offer/offers/status`, request);
  }
}
