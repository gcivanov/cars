import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit, ViewChild, HostListener } from '@angular/core';
import { Router, NavigationEnd } from '@angular/router';

@Component({
  selector: 'app-account',
  templateUrl: './account.component.html',
  styleUrls: ['./account.component.scss']
})
export class AccountComponent implements OnInit {

  @ViewChild('sidenav') sidenav: any;
  public sidenavOpen: boolean = true;
  public userName: string = '';

  public links = [
    { name: 'Profile', href: 'profile', icon: 'person' },
    { name: 'My Properties', href: 'my-properties', icon: 'view_list' },
    { name: 'Favorites', href: 'favorites', icon: 'favorite' },
    { name: 'Submit', href: '/submit', icon: 'add_circle' },
    { name: 'Logout', href: '/login', icon: 'power_settings_new' },
  ];
  constructor(public router: Router,
              private authService: AuthService) {
    if (!!this.authService.userValue) {
      this.userName = `${this.authService.userValue?.accountBaseInfo.firstName}
                        ${this.authService.userValue?.accountBaseInfo.lastName}`;
    }
    this.authService.somebodyLoggedIn.subscribe((is: boolean) => {
          if (!!!is) {
            this.userName = '';
          } else {
            this.userName = `${this.authService.userValue?.accountBaseInfo.firstName}
                             ${this.authService.userValue?.accountBaseInfo.lastName}`;
          }
      });
  }

  ngOnInit() {
    if(window.innerWidth < 960){
      this.sidenavOpen = false;
    };
  }

  @HostListener('window:resize')
  public onWindowResize():void {
    (window.innerWidth < 960) ? this.sidenavOpen = false : this.sidenavOpen = true;
  }

  ngAfterViewInit(){
    this.router.events.subscribe(event => {
      if (event instanceof NavigationEnd) {
        if(window.innerWidth < 960){
          this.sidenav.close();
        }
      }
    });
  }


}
