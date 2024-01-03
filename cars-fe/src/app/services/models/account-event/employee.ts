import { Company } from "./company";

export class Employee {
  constructor(public id: number,
              public position: Position,
              public company: Company){ }
}

export class Position {
  constructor(public id: string,
              public name: string,
              public description: string,
              public orderNumber: number){ }
}
