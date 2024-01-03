export class MakerResponse {
  constructor(public id: number,
              public name: string,
              public count: number | null,
              public models: ModelResponse[] | null
              ){ }
}

export class ModelResponse {
  constructor(public id: number,
              public model: string,
              public count: number | null){ }
}
