import { CUSTOM_ELEMENTS_SCHEMA, NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module'
import { OffersComponent } from './offers.component';
import { OfferComponent } from './offer/offer.component';
import { SubmitComponent } from './submit/submit.component';
import { AuthGuard } from 'src/app/services/auth.guard';

export const routes: Routes = [
  //todo Add guard
  { path: 'submit', component: SubmitComponent, pathMatch: 'full', canActivate: [AuthGuard]},
  { path: 'submit/:id', component: SubmitComponent, pathMatch: 'full', canActivate: [AuthGuard]},
  { path: '', component: OffersComponent, pathMatch: 'full' },
  { path: ':id', component: OfferComponent }
];

@NgModule({
  declarations: [
    OffersComponent,
    OfferComponent,
    SubmitComponent
  ],
  exports: [
    // OffersComponent,
    OfferComponent,
  ],
  imports: [
    CommonModule,
    RouterModule.forChild(routes),
    SharedModule
  ],
  schemas: [
    //Step 3: SWIPER
    CUSTOM_ELEMENTS_SCHEMA
  ]
})
export class OffersModule { }
