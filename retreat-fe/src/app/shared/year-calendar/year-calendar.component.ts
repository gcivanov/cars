import { ChangeDetectionStrategy, ChangeDetectorRef, Component, Inject, OnDestroy, Input } from '@angular/core';
import { DateAdapter, MAT_DATE_FORMATS, MatDateFormats } from '@angular/material/core';
import { DateRange, MatCalendar } from '@angular/material/datepicker';
import { Subject, takeUntil } from 'rxjs';
import * as moment from 'moment';

export interface YearCalendarObj {
  start: moment.Moment,
  end: moment.Moment
}

@Component({
  selector: 'app-year-calendar',
  templateUrl: './year-calendar.component.html',
  styleUrls: ['./year-calendar.component.scss']
})
export class YearCalendarComponent {
  @Input() dates?: YearCalendarObj[];

  exampleHeader = CalendarHeader;

  public allRemainingMOnths: Date[] = [];

  constructor() {
    this.allRemainingMOnths.push(moment().toDate())
    let nextMonthsCount = 0;
    while(++nextMonthsCount <= 24) {
      const startOfNextMonth = moment().add(nextMonthsCount, 'M').startOf('month');
      this.allRemainingMOnths.push(startOfNextMonth.toDate());
    }
  }


  selected = new Date('2023-02-02');
  selectedDateRange: DateRange<Date> = new DateRange(new Date('2023-04-04'), new Date('2023-04-07'));

  logMonth(event:any)  {
    console.log('sda')
    event = null;
  }
  clickCard() {
    console.log("card")
  }


  /** new css */

  public startDays: Date[] = [
    new Date('2023-11-11'), new Date('2023-11-18'),
    new Date('2023-11-12'), new Date('2023-12-15'),
    new Date('2024-01-12'), new Date('2024-02-15'),
  ];

  public isSelectedDate = (event: Date): any => {
    const eventStartOfDay = moment(event).startOf('day');
    let is = this.startDays.find(el => moment(el).startOf('day').isSame(eventStartOfDay));
    let m = moment;
    m(event).startOf('day').isSame(m(this.startDays[3]).startOf('day'))
    const sa = this.startDays[0] == event;
    return is ? "selected" : null;
  }


  daysSelected: any[] = [];
  event: any;
  isSelected = (event: any): any => {
    const date =
      event.getFullYear() +
      "-" +
      ("00" + (event.getMonth() + 1)).slice(-2) +
      "-" +
      ("00" + event.getDate()).slice(-2);
    return this.daysSelected.find(x => x == date) ? "selected" : null;
  };

  select(event: Date, calendar: MatCalendar<Date>) {
    const date =
      event.getFullYear() +
      "-" +
      ("00" + (event.getMonth() + 1)).slice(-2) +
      "-" +
      ("00" + event.getDate()).slice(-2);
    const index = this.daysSelected.findIndex(x => x == date);
    if (index < 0) this.daysSelected.push(date);
    else this.daysSelected.splice(index, 1);

    calendar.updateTodaysDate();
  }
}




export interface CalendarCustomDate {
  month: number;
  selectedDateRange: DateRange<Date>[];
}

/** Custom header component for datepicker. */
@Component({
  selector: 'calendar-header',
  template: `
    <div class="text-center">
      <span>{{periodLabel}}</span>
    </div>
  `,
  changeDetection: ChangeDetectionStrategy.OnPush,

})
export class CalendarHeader<D> implements OnDestroy {
  private _destroyed = new Subject<void>();

  constructor(
      private _calendar: MatCalendar<D>, private _dateAdapter: DateAdapter<D>,
      @Inject(MAT_DATE_FORMATS) private _dateFormats: MatDateFormats, cdr: ChangeDetectorRef) {
    _calendar.stateChanges
        .pipe(takeUntil(this._destroyed))
        .subscribe(() => cdr.markForCheck());
  }

  ngOnDestroy() {
    this._destroyed.next();
    this._destroyed.complete();
  }

  get periodLabel() {
    return this._dateAdapter
        .format(this._calendar.activeDate, this._dateFormats.display.monthYearLabel)
        .toLocaleUpperCase();
  }
}
