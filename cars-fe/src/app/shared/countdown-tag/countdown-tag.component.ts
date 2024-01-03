import { Moment } from 'moment';
import { AfterViewInit, Component, ElementRef, Input, OnInit, ViewChild } from '@angular/core';
import * as moment from 'moment';

@Component({
  selector: 'app-countdown-tag',
  templateUrl: './countdown-tag.component.html',
  styleUrls: ['./countdown-tag.component.scss']
})
export class CountdownTagComponent implements AfterViewInit {

  @Input({required: true}) targetTime!: Moment;

  @ViewChild('hours', { static: true }) hours!: ElementRef;
  @ViewChild('minutes', { static: true }) minutes!: ElementRef;
  @ViewChild('seconds', { static: true }) seconds!: ElementRef;

  loading: boolean = true;

  constructor() { }

  ngAfterViewInit() {

    setInterval(() => {
      const diffMilliseconds = this.targetTime.diff(moment());

      const hours = Math.floor(diffMilliseconds / (60*60*1000));
      const hoursms = diffMilliseconds % (60*60*1000);
      const minutes = Math.floor(hoursms / (60*1000));
      const minutesms = diffMilliseconds % (60*1000);
      const sec = Math.floor(minutesms / 1000);


      this.hours.nativeElement.innerText = hours;
      this.minutes.nativeElement.innerText = minutes;
      this.seconds.nativeElement.innerText = sec;
      this.loading = false;
    }, 1000);
  }
}
