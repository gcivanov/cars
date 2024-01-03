import { ErrorHandler, NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';


import { NgProgressModule } from 'ngx-progressbar';
import { NgProgressHttpModule } from 'ngx-progressbar/http';
import { AppRoutingModule } from './app.routing';
import { PagesComponent } from './pages/pages.component';
import { NotFoundComponent } from './shared/not-found/not-found.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { AppSettings } from './app.settings';
import { FormsModule } from '@angular/forms';
import { HttpClient, HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';


import { environment } from 'src/environments/environment';
import { TranslateModule, TranslateLoader, MissingTranslationHandler } from '@ngx-translate/core';
import { TranslateHttpLoader } from '@ngx-translate/http-loader';
export function HttpLoaderFactory(httpClient: HttpClient) {
  return new TranslateHttpLoader(httpClient, environment.url +'/assets/i18n/', '.json');
}

import { SharedModule } from './shared/shared.module';
import { SocialIconsComponent } from './theme/components/social-icons/social-icons.component';
import { Toolbar1Component } from './theme/components/toolbar1/toolbar1.component';
import { CurrencyComponent } from './theme/components/currency/currency.component';
import { LangComponent } from './theme/components/lang/lang.component';
import { FooterComponent } from './theme/components/footer/footer.component';
import { AppInterceptor } from './theme/utils/app-interceptor';
import { UserMenuComponent } from './theme/components/user-menu/user-menu.component';
import { ToolbarHorizontalMenuComponent } from './theme/components/menu/toolbar-horizontal-menu/toolbar-horizontal-menu.component';
import { UserLoginComponent } from './theme/components/user-login/user-login.component';
import { JwtInterceptor } from './theme/utils/jwt-interceptor';
import { LockScreenComponent } from './pages/lock-screen/lock-screen.component';
import { MissingTranslationHelper } from './theme/utils/MissingTranslationHelper';
import { GlobalErrorHandler } from './services/global-error-handler.service';

@NgModule({
  declarations: [
    AppComponent,
    PagesComponent,
    NotFoundComponent,
    SocialIconsComponent,
    Toolbar1Component,
    CurrencyComponent,
    LangComponent,
    FooterComponent,
    UserMenuComponent,
    ToolbarHorizontalMenuComponent,
    UserLoginComponent,
    LockScreenComponent,
  ],
  imports: [
    BrowserModule,
    NgProgressModule,
    NgProgressHttpModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    FormsModule,
    HttpClientModule,
    //shared
    // MatCardModule,
    // MatIconModule,
    // MatFormFieldModule,
    // MatInputModule,
    // FlexLayoutModule,
    TranslateModule.forRoot({
      loader: {
        provide: TranslateLoader,
        useFactory: HttpLoaderFactory,
        deps: [HttpClient]
      },
      missingTranslationHandler: {provide: MissingTranslationHandler, useClass: MissingTranslationHelper}
    }),
    SharedModule

  ],
  providers: [AppSettings,
    { provide: ErrorHandler, useClass: GlobalErrorHandler},
    { provide: HTTP_INTERCEPTORS, useClass: AppInterceptor, multi: true },
    { provide: HTTP_INTERCEPTORS, useClass: JwtInterceptor, multi: true }],
  bootstrap: [AppComponent]
})
export class AppModule { }
