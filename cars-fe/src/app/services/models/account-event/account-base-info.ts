import { RoleType } from "./account";

export class AccountBaseInfo {
  constructor(public firstName: string,
              public lastName: string,
              public email: string,
              public roles: RoleType[]){ }
}
