import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-rating',
  templateUrl: './rating.component.html',
  styleUrls: ['./rating.component.scss']
})
export class RatingComponent {

  @Input({required: true}) rating!: number;
  readonly max: number = 5;
  stars?: Array<string>;
  constructor() { }

  ngDoCheck() {
    if(this.rating) {
      this.calculateAvgValue();
    }
  }

  public calculateAvgValue(){
    if (this.rating > 5.0) {
      this.rating = 5.0;
    }
    this.stars = [];
    const intRating = this.rating | 0;
    for (let i = 0; i < intRating; ++i) {
      this.stars.push('star');
    }

    const floatPointRating = this.rating - intRating;
    if (floatPointRating > 0) {
      if (floatPointRating > 0.7) {
        this.stars.push('star');
      } else if (floatPointRating > 0.2) {
        this.stars.push('star_half');
      } else {
        this.stars.push('star_border');
      }
    }

    let maxIndex = this.max - intRating - floatPointRating;
    while (maxIndex > 0.99) {
      this.stars.push('star_border');
      --maxIndex;
    }
  }

  public tooltip() {
    const rait = this.rating > this.max ? this.max : this.rating;
    return `${rait > 0 ? rait : 0}/${this.max}`;
  }
}
