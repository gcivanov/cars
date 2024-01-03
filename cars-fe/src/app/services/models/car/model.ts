import { Maker } from "./maker";

export class Model {
  constructor(public id: number,
              public model: string,
              public maker: Maker){ }
}
