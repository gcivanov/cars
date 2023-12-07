export class Event {
  constructor(public id: number | null,
              public name: string,
              public description: string,
              public startTime: Date,
              public endTime: Date,
              public prices: EventPrice[],
              public type: EventType,
              public category: EventCategory,
              public maxParticipants: number | null,
              public location: string | null,
              public locationGooglePin: string | null,
              public additionalInformation: string | null,
              public status: string = 'REQUESTED'){ }
}

export class EventPrice {
  constructor(public id: number | null,
              public fromDate: Date | null,
              public toDate: Date | null,
              public price: number,
              public description: string | null) { }
}

export enum EventType {
  RETREAT = "RETREAT",
  EVENT = "EVENT"
}

export class EventCategory {
  constructor(public id: number | null,
              public name: string,
              public description: string | null,
              public status: string = 'REQUESTED',
              public parentId: number | null,
              public imageUrl: string | null,
              public requestedBy: string) { }
}
export enum CurrencyType {
  BGN = "BGN",
  EUR = "EUR"
}

export const activeCurrencies: CurrencyType[] = [
  CurrencyType.BGN
]

export enum REPEAT_INTERVAL {
  MONTHLY = "MONTHLY",
  WEEKLY = "WEEKLY",
  EVERY_YEAR = "EVERY_YEAR",
  CUSTOM_INTERVAL = "CUSTOM_INTERVAL"
}
