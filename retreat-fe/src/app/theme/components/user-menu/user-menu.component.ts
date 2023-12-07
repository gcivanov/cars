import { Component, OnInit } from '@angular/core';
import { AppService } from 'src/app/app.service';
import { AuthService } from 'src/app/services/auth.service';
import { AccountBaseInfo } from 'src/app/services/models/account-base-info';

@Component({
  selector: 'app-user-menu',
  templateUrl: './user-menu.component.html',
  styleUrls: ['./user-menu.component.scss']
})
export class UserMenuComponent implements OnInit {

  public userName: string = '';
  public email: string = '';
  public baseInfo?: AccountBaseInfo;

  constructor(public appService: AppService,
              private authService: AuthService) {

    if (!!this.authService.userValue) {
      this.getBaseAccountInfo(this.authService.userValue?.accountBaseInfo);
    }
    this.authService.somebodyLoggedIn.subscribe((is: boolean) => {
          if (!!!is) {
            this.userName = '';
            this.email = '';
          } else {
            this.getBaseAccountInfo(this.authService.userValue!.accountBaseInfo);
          }
      });
  }

  ngOnInit() {
  }

  public logout() {
    this.authService.logout();
  }

  private getBaseAccountInfo(baseInfo: AccountBaseInfo) {
    this.userName = `${baseInfo.firstName} ${baseInfo.lastName}`;
    this.email = baseInfo.email;
  }

}
