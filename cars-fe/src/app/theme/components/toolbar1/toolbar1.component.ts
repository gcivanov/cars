import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { AppService } from 'src/app/app.service';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-toolbar1',
  templateUrl: './toolbar1.component.html'
})
export class Toolbar1Component implements OnInit {

  @Output() onMenuIconClick: EventEmitter<any> = new EventEmitter<any>();
  public isLoggedIn: boolean = false;


  constructor(public appService: AppService,
              private authService: AuthService) {

    this.isLoggedIn = !!this.authService.userValue;
    this.authService.somebodyLoggedIn.subscribe((is: boolean) => this.isLoggedIn = is);
  }

  ngOnInit() { }

  public sidenavToggle(){
    this.onMenuIconClick.emit();
  }
}
