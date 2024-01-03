import { FormGroup, FormControl } from '@angular/forms';

export function emailValidator(control: FormControl): {[key: string]: any} {
  var emailRegexp = /[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$/;
  if (control.value && !emailRegexp.test(control.value)) {
      return {invalidEmail: true};
  }
  return {};
}

export function matchingPasswords(passwordKey: string, passwordConfirmationKey: string) {
  return (group: FormGroup) => {
      let password= group.controls[passwordKey];
      let passwordConfirmation= group.controls[passwordConfirmationKey];
      if (password.value !== passwordConfirmation.value) {
          return passwordConfirmation.setErrors({mismatchedPasswords: true})
      }
  }
}


export function dateBetween(startTime: string, endTime: string) {
  return (group: FormGroup) => {
      let dateFirst = group.controls[startTime];
      let dateSecond = group.controls[endTime];
      if ((dateFirst.valid || (dateFirst.disabled && dateFirst.value)) && dateSecond.valid && !!dateSecond.value
              && dateFirst.value.isSameOrAfter(dateSecond.value)) {

          return dateSecond.setErrors({dateBetween: true})
      }
  }
}

export function numberBetween(first: string, second: string) {
  return (group: FormGroup) => {
      let dateFirst = group.controls[first];
      let dateSecond = group.controls[second];
      if (dateFirst.valid && dateSecond.valid && !!dateSecond.value
              && dateFirst.value > dateSecond.value) {

          return dateSecond.setErrors({numberBetween: true})
      }
  }
}
