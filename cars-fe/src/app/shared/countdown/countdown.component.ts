import { Moment } from 'moment';
import { AfterViewInit, Component, ElementRef, Input, OnInit, ViewChild } from '@angular/core';
import * as moment from 'moment';

@Component({
  selector: 'app-countdown',
  templateUrl: './countdown.component.html',
  styleUrls: ['./countdown.component.scss']
})
export class CountdownComponent implements AfterViewInit {

  @Input({required: true}) targetTime!: Moment;

  @ViewChild('days', { static: true }) days!: ElementRef;
  @ViewChild('hours', { static: true }) hours!: ElementRef;
  @ViewChild('minutes', { static: true }) minutes!: ElementRef;
  @ViewChild('seconds', { static: true }) seconds!: ElementRef;

  constructor() { }

  ngAfterViewInit() {
    setInterval(() => {


      const diffMilliseconds = this.targetTime.diff(moment());

      const days = Math.floor(diffMilliseconds / (24*60*60*1000));
      const daysms = diffMilliseconds % (24*60*60*1000);
      const hours = Math.floor(daysms / (60*60*1000));
      const hoursms = diffMilliseconds % (60*60*1000);
      const minutes = Math.floor(hoursms / (60*1000));
      const minutesms = diffMilliseconds % (60*1000);
      const sec = Math.floor(minutesms / 1000);

      this.days.nativeElement.innerText = days;
      this.hours.nativeElement.innerText = hours;
      this.minutes.nativeElement.innerText = minutes;
      this.seconds.nativeElement.innerText = sec;
    }, 1000);
  }
}
