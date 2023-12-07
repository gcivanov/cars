import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
// import { AgmCoreModule } from '@agm/core';
// import { InputFileModule } from 'ngx-input-file';
import { SubmitComponent } from './submit.component';

export const routes: Routes = [
  { path: '', component: SubmitComponent, pathMatch: 'full'  }
];

@NgModule({
  declarations: [SubmitComponent],
  imports: [
    CommonModule,
    RouterModule.forChild(routes),
    SharedModule,
  ]
})
export class SubmitModule { }
