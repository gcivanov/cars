import { Component, OnInit, Output, EventEmitter, Input } from '@angular/core';
import { SearchOrderType } from 'src/app/services/models/car/offer';

@Component({
  selector: 'app-toolbar',
  templateUrl: './toolbar.component.html',
  styleUrls: ['./toolbar.component.scss']
})
export class ToolbarComponent implements OnInit {

  @Input() isHomePage: boolean = false;
  @Input() showSidenavToggle: boolean = false;
  @Input() maxLength?: number = undefined;
  @Output() onSidenavToggle: EventEmitter<any> = new EventEmitter<any>();
  @Output() onChangeCount: EventEmitter<any> = new EventEmitter<any>();
  @Output() onChangeSorting: EventEmitter<any> = new EventEmitter<any>();
  @Output() onChangeViewType: EventEmitter<any> = new EventEmitter<any>();

  public viewType: string = 'grid';
  public viewCol: number = 25;
  public counts = [20, 40, 60, 100];
  public count:any;
  public sortings: SearchOrderType[] =
    [
      SearchOrderType.D, SearchOrderType.V, SearchOrderType.T, SearchOrderType.N, SearchOrderType.L, SearchOrderType.H
    ]
  public sort:any;

  constructor() { }

  ngOnInit() {

    if (!!this.maxLength && this.counts[this.counts.length - 1] > this.maxLength) {
      this.counts = this.counts.filter(el => el > this.maxLength!);
    }

    if (this.counts.length > 2) {
      this.count = (this.isHomePage) ? this.counts[0] : this.counts[1];
    }

    this.sort = this.sortings[0];
  }

  ngOnChanges(){
    // console.log(' show toggle - ' ,this.showSidenavToggle)
  }

  public changeCount(count: any){
    this.count = count;
    this.onChangeCount.emit(count);
  }

  public changeSorting(sort: any){
    this.sort = sort;
    this.onChangeSorting.emit(sort);
  }

  public changeViewType(viewType: any, viewCol: any){
    this.viewType = viewType;
    this.viewCol = viewCol;
    this.onChangeViewType.emit({viewType:viewType, viewCol:viewCol});
  }

  public sidenavToggle(){
    this.onSidenavToggle.emit();
  }
}
