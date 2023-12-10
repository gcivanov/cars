import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { AccountComponent } from './account.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { MyPropertiesComponent } from './my-properties/my-properties.component';
import { FavoritesComponent } from './favorites/favorites.component';
import { ProfileComponent } from './profile/profile.component';
import { EditPropertyComponent } from './edit-property/edit-property.component';
import { MyAccountsComponent } from './my-accounts/my-accounts.component';

export const routes: Routes = [
  {
    path: '',
    component: AccountComponent, children: [
      { path: '', redirectTo: 'profile', pathMatch: 'full' },
      { path: 'my-properties', component: MyPropertiesComponent },
      // { path: 'my-properties/:id', component: EditPropertyComponent },
      { path: 'favorites', component: FavoritesComponent },
      { path: 'profile', component: ProfileComponent }
    ]
  }
];

@NgModule({
  declarations: [
    DashboardComponent,
    AccountComponent,
    MyPropertiesComponent,
    FavoritesComponent,
    ProfileComponent,
    MyAccountsComponent,
    // EditPropertyComponent
  ],
  imports: [
    CommonModule,
    RouterModule.forChild(routes),
    SharedModule,
  ]
})
export class AccountModule { }