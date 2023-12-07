import { GenderType } from "./account";

export class AccountMyUpdate {
  constructor(public firstName: string,
              public lastName: string,
              public email: string,
              public pictureUrl: string | null,
              public genderType: GenderType,
              public dateOfBirth: Date | string,
              public receiveNewsEmails: boolean,
              public phone: string){ }
}
