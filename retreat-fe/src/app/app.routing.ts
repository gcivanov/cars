import { NgModule } from '@angular/core';
import { Routes, RouterModule, PreloadAllModules  } from '@angular/router';
import { PagesComponent } from './pages/pages.component';
import { NotFoundComponent } from './shared/not-found/not-found.component';
import { AuthGuard } from './services/auth.guard';
import { LockScreenComponent } from './pages/lock-screen/lock-screen.component';

export const routes: Routes = [
  {
    path: '',
    component: PagesComponent,
    children: [
      { path: '', loadChildren: () => import('./pages/home/home.module').then(m => m.HomeModule) },
      { path: 'login', loadChildren: () => import('./pages/login/login.module').then(m => m.LoginModule) },
      { path: 'register', loadChildren: () => import('./pages/register/register.module').then(m => m.RegisterModule) },
      { path: 'about', loadChildren: () => import('./pages/about/about.module').then(m => m.AboutModule) },
      { path: 'submit', loadChildren: () => import('./pages/submit/submit.module').then(m => m.SubmitModule), canActivate: [AuthGuard] },
      { path: 'account', loadChildren: () => import('./pages/account/account.module').then(m => m.AccountModule), canActivate: [AuthGuard] }
    ],
  },
  { path: 'lock-screen', component: LockScreenComponent },
  { path: '**', component: NotFoundComponent }
];

@NgModule({
  declarations: [],
  imports: [
    RouterModule.forRoot(routes, {
      preloadingStrategy: PreloadAllModules, // <- comment this line for activate lazy load
      // initialNavigation: 'enabledNonBlocking', // for one load page, without reload
      // useHash: true
    })
  ],
  exports: [
      RouterModule
  ]
})
export class AppRoutingModule { }
