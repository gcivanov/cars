import { AccountBaseInfo } from 'src/app/services/models/account-event/account-base-info';

export class LoginResponse {
  constructor(public accessToken: string,
              public tokenType: string,
              public accountBaseInfo: AccountBaseInfo){ }
}
