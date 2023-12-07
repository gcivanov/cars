import { AccountBaseInfo } from 'src/app/services/models/account-base-info';
export class LoginResponse {
  constructor(public accessToken: string,
              public tokenType: string,
              public accountBaseInfo: AccountBaseInfo){ }
}
