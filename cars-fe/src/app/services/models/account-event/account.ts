export class Account {
  constructor(public id: number,
              public firstName: string,
              public lastName: string,
              public email: string,
              public roles: RoleType[],
              public active: boolean,
              public locked: boolean,
              public dateOfRegistration: Date,
              public pictureUrl: string | null,
              public genderType: GenderType | null,
              public dateOfBirth: Date,
              public receiveNewsEmails: boolean,
              public phone: string){ }
}

export enum RoleType {
  USER = "USER",
  DEALER = "DEALER"
}

export enum GenderType {
  MAN = "MAN",
  WOMAN = "WOMAN",
  UNDEFINED = "UNDEFINED"
}
