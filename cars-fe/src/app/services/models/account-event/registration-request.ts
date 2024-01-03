import { Employee } from './employee';
import { GenderType, RoleType } from "./account";

export class RegistrationRequest {
  constructor(public role: RoleType,
              public firstName: string,
              public lastName: string,
              public email: string,
              public password: string,
              public genderType: GenderType | null,
              public dateOfBirth: Date,
              public receiveNewsEmails: boolean,
              public phone: string,
              public employee: Employee | null){ }
}
