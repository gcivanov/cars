export class Company {
  constructor(public id: number,
              public name: string,
              public logUrl: string | null,
              public companyNumber: string,
              public address: string,
              public vatId: string | null,
              public description: string | null,
              public phone: string | null,
              public additionalInformation: string | null,){ }
}
