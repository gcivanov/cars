export class Property {
    constructor(public id: number,
                public title: string,
                public desc: string,
                public propertyType: string,
                public propertyStatus: string[],
                public city: string,
                public zipCode: string[],
                public neighborhood: string[],
                public street: string[],
                public location: Location,
                public formattedAddress: string,
                public features: string[],
                public featured: boolean,
                public priceDollar: Price,
                public priceEuro: Price,
                public bedrooms: number,
                public bathrooms: number,
                public garages: number,
                public area: Area,
                public yearBuilt: number,
                public ratingsCount: number,
                public ratingsValue: number,
                public additionalFeatures: AdditionalFeature[],
                public gallery: Gallery[],
                public plans: Plan[],
                public videos: Video[],
                public published: string,
                public lastUpdate: string,
                public views: number){ }
}


export class Area {
    constructor(
                public value: number,
                public unit: string,
                public id?: number | undefined | null){ }
}

export class AdditionalFeature {
    constructor(
                public name: string,
                public value: string,
                public id?: number | undefined | null){ }
}

export class Location {
    constructor(public propertyId: number,
                public lat: number,
                public lng: number){ }
}

export class Price {
    public sale?: number;
    public rent?: number| undefined | null;
}


export class Gallery {
    constructor(
                public small: string,
                public medium: string,
                public big: string,
                public id?: number | undefined | null){ }
}

export class Plan {
    constructor(
                public name: string,
                public desc: string,
                public area: Area | undefined,
                public rooms: number,
                public baths: number,
                public image: string,
                public id?: number | undefined | null){ }
}

export class Video {
    constructor(
                public name: string,
                public link: string,
                public id?: number | undefined | null){ }
}

export class Pagination {
    constructor(public page: number,
                public perPage: number,
                public prePage: number | undefined | null,
                public nextPage: number | undefined | null,
                public total: number,
                public totalPages: number){ }
}

