
export class Feature {
  constructor(public id: number,
              public name: SVGAnimatedString,
              public featureCategory: FeatureCategory) {}
}

export class FeatureCategory {
  constructor(public id: number,
              public name: string) {}
}
