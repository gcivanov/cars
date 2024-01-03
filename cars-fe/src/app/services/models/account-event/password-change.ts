export class PasswordChange {
  constructor(public email: string,
              public currentPassword: string,
              public newPassword: string,
              public confirmNewPassword: string){ }
}
