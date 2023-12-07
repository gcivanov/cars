import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { ReactiveFormsModule } from '@angular/forms';
// import { SwiperModule } from 'ngx-swiper-wrapper';
import { TranslateModule } from '@ngx-translate/core';
import { FlexLayoutModule } from '@angular/flex-layout';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatBadgeModule } from '@angular/material/badge';
import { MatBottomSheetModule } from '@angular/material/bottom-sheet';
import { MatButtonModule } from '@angular/material/button';
import { MatButtonToggleModule } from '@angular/material/button-toggle';
import { MatCardModule } from '@angular/material/card';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatChipsModule } from '@angular/material/chips';
import { MAT_DATE_LOCALE, MatNativeDateModule, MatRippleModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatDialogModule } from '@angular/material/dialog';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatMenuModule } from '@angular/material/menu';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatRadioModule } from '@angular/material/radio';
import { MatSelectModule } from '@angular/material/select';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { MatSliderModule } from '@angular/material/slider';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { MatSortModule } from '@angular/material/sort';
import { MatStepperModule } from '@angular/material/stepper';
import { MatTableModule } from '@angular/material/table';
import { MatTabsModule } from '@angular/material/tabs';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatTooltipModule } from '@angular/material/tooltip';
import { LogoComponent } from './logo/logo.component';
import { HeaderVideoComponent } from './header-video/header-video.component';
import { MissionComponent } from './mission/mission.component';
import { OurServicesComponent } from './our-services/our-services.component';
import { OurBeliefsComponent } from './our-beliefs/our-beliefs.component';
import { HeaderImageComponent } from './header-image/header-image.component';
import { NgxMatDatetimePickerModule,
          NgxMatTimepickerModule,
          NgxMatDateFormats,
          NGX_MAT_DATE_FORMATS,
          NgxMatDateAdapter} from '@angular-material-components/datetime-picker';
import { NGX_MAT_MOMENT_DATE_ADAPTER_OPTIONS } from '@angular-material-components/moment-adapter';
import { CustomNgxDatetimeAdapter } from '../theme/utils/CustomNgxDatetimeAdapter';
import { ConfirmDialogComponent } from './confirm-dialog/confirm-dialog.component';
import { ConfirmAddCategoryEventDialogComponent } from './confirm-add-category-event-dialog/confirm-add-category-event-dialog';
import { YearCalendarComponent } from './year-calendar/year-calendar.component';

// import { PerfectScrollbarModule } from 'ngx-perfect-scrollbar';
// import { PERFECT_SCROLLBAR_CONFIG } from 'ngx-perfect-scrollbar';
// import { PerfectScrollbarConfigInterface } from 'ngx-perfect-scrollbar';
// const DEFAULT_PERFECT_SCROLLBAR_CONFIG: PerfectScrollbarConfigInterface = {
//   wheelPropagation: false,
//   suppressScrollX: true
// };

// import { AgmCoreModule } from '@agm/core';
// import { AgmSnazzyInfoWindowModule } from '@agm/snazzy-info-window';

// import { PipesModule } from '../theme/pipes/pipes.module';
// import { DirectivesModule } from '../theme/directives/directives.module';

// import { HeaderImageComponent } from './header-image/header-image.component';
// import { HeaderCarouselComponent } from './header-carousel/header-carousel.component';
// import { PropertyItemComponent } from './property-item/property-item.component';
// import { LoadMoreComponent } from './load-more/load-more.component';
// import { PropertiesToolbarComponent } from './properties-toolbar/properties-toolbar.component';
// import { PropertiesSearchComponent } from './properties-search/properties-search.component';
// import { CompareOverviewComponent } from './compare-overview/compare-overview.component';
// import { RatingComponent } from './rating/rating.component';
// import { PropertiesSearchResultsFiltersComponent } from './properties-search-results-filters/properties-search-results-filters.component';
// import { PropertiesCarouselComponent } from './properties-carousel/properties-carousel.component';
// import { ClientsComponent } from './clients/clients.component';
// import { GetInTouchComponent } from './get-in-touch/get-in-touch.component';
// import { CommentsComponent } from './comments/comments.component';
// import { TestimonialsComponent } from './testimonials/testimonials.component';
// import { OurAgentsComponent } from './our-agents/our-agents.component';
// import { HeaderMapComponent } from './header-map/header-map.component';
// import { AlertDialogComponent } from './alert-dialog/alert-dialog.component';
// import { DialogHeaderControlsComponent } from './dialog-header-controls/dialog-header-controls.component';


const CUSTOM_DATE_FORMATS: NgxMatDateFormats = {
  parse: {
    dateInput: 'MM/DD/YYYY HH:mm'
  },
  display: {
    dateInput: 'MM/DD/YYYY HH:mm',
    monthYearLabel: 'MMM YYYY',
    dateA11yLabel: 'LL',
    monthYearA11yLabel: 'MMMM YYYY'
  }
};

@NgModule({
  imports: [
    CommonModule,
    RouterModule,
    ReactiveFormsModule,
    // SwiperModule,
    TranslateModule,
    FlexLayoutModule,
    MatAutocompleteModule,
    MatBadgeModule,
    MatBottomSheetModule,
    MatButtonModule,
    MatButtonToggleModule,
    MatCardModule,
    MatCheckboxModule,
    MatChipsModule,
    MatDatepickerModule,
    MatDialogModule,
    MatExpansionModule,
    MatGridListModule,
    MatIconModule,
    MatInputModule,
    MatListModule,
    MatMenuModule,
    MatNativeDateModule,
    MatPaginatorModule,
    MatProgressBarModule,
    MatProgressSpinnerModule,
    MatRadioModule,
    MatRippleModule,
    MatSelectModule,
    MatSidenavModule,
    MatSliderModule,
    MatSlideToggleModule,
    MatSnackBarModule,
    MatSortModule,
    MatTableModule,
    MatTabsModule,
    MatToolbarModule,
    MatTooltipModule,
    MatStepperModule,
    // PerfectScrollbarModule,
    // AgmCoreModule,
    // AgmSnazzyInfoWindowModule,
    // PipesModule,
    // DirectivesModule
    NgxMatDatetimePickerModule,
    NgxMatTimepickerModule
  ],
  exports: [
    RouterModule,
    ReactiveFormsModule,
    // SwiperModule,
    TranslateModule,
    FlexLayoutModule,
    MatAutocompleteModule,
    MatBadgeModule,
    MatBottomSheetModule,
    MatButtonModule,
    MatButtonToggleModule,
    MatCardModule,
    MatCheckboxModule,
    MatChipsModule,
    MatDatepickerModule,
    MatDialogModule,
    MatExpansionModule,
    MatGridListModule,
    MatIconModule,
    MatInputModule,
    MatListModule,
    MatMenuModule,
    MatNativeDateModule,
    MatPaginatorModule,
    MatProgressBarModule,
    MatProgressSpinnerModule,
    MatRadioModule,
    MatRippleModule,
    MatSelectModule,
    MatSidenavModule,
    MatSliderModule,
    MatSlideToggleModule,
    MatSnackBarModule,
    MatSortModule,
    MatTableModule,
    MatTabsModule,
    MatToolbarModule,
    MatTooltipModule,
    MatStepperModule,
    // PerfectScrollbarModule,
    // AgmCoreModule,
    // AgmSnazzyInfoWindowModule,
    // PipesModule,
    // DirectivesModule,
    LogoComponent,
    HeaderImageComponent,
    // HeaderCarouselComponent,
    // PropertyItemComponent,
    // LoadMoreComponent,
    // PropertiesToolbarComponent,
    // PropertiesSearchComponent,
    // CompareOverviewComponent,
    // RatingComponent,
    // PropertiesSearchResultsFiltersComponent,
    // PropertiesCarouselComponent,
    // ClientsComponent,
    // GetInTouchComponent,
    // CommentsComponent,
    // TestimonialsComponent,
    // OurAgentsComponent,
    MissionComponent,
    OurServicesComponent,
    OurBeliefsComponent,
    // HeaderMapComponent,
    HeaderVideoComponent,
    ConfirmDialogComponent,
    ConfirmAddCategoryEventDialogComponent,
    // AlertDialogComponent,
    // DialogHeaderControlsComponent
    NgxMatDatetimePickerModule,
    NgxMatTimepickerModule,
    YearCalendarComponent
  ],
  declarations: [
    LogoComponent,
    HeaderImageComponent,
    // HeaderCarouselComponent,
    // PropertyItemComponent,
    // LoadMoreComponent,
    // PropertiesToolbarComponent,
    // PropertiesSearchComponent,
    // CompareOverviewComponent,
    // RatingComponent,
    // PropertiesSearchResultsFiltersComponent,
    // PropertiesCarouselComponent,
    // ClientsComponent,
    // GetInTouchComponent,
    // CommentsComponent,
    // TestimonialsComponent,
    // OurAgentsComponent,
    MissionComponent,
    OurServicesComponent,
    OurBeliefsComponent,
    // HeaderMapComponent,
    HeaderVideoComponent,
    ConfirmDialogComponent,
    ConfirmAddCategoryEventDialogComponent,
    YearCalendarComponent,
    // AlertDialogComponent,
    // DialogHeaderControlsComponent
  ],
  providers:[
    {
      provide: NgxMatDateAdapter,
      useClass: CustomNgxDatetimeAdapter,
      deps: [MAT_DATE_LOCALE, NGX_MAT_MOMENT_DATE_ADAPTER_OPTIONS]
    },
    { provide: NGX_MAT_DATE_FORMATS, useValue: CUSTOM_DATE_FORMATS }
    // { provide: PERFECT_SCROLLBAR_CONFIG, useValue: DEFAULT_PERFECT_SCROLLBAR_CONFIG }
  ]
})
export class SharedModule { }
