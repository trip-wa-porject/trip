// level 跟 status 可以規定嚴格一點

export interface Trip {
  id: string;
  title: string;
  startDate: number;
  endDate: number;
  area: {
    city: string;
    county: string;
  }[];
  type: string;
  level: 'A' | 'B' | 'C';
  roadImage: string;
  price: number;
  memberPrice: number;
  url: string;
  applicants: number;
  limitation: number;
  images: string[];
  information: {
    applyStart: number;
    applyEnd: number;
    applyWay: string;
    gatherPlace: string;
    gatherTime: number;
    transportationWay: string;
    transportationInfo: string;
    preDepartureMeetingDate: number;
    preDepartureMeetingPlace: string;
    memo: string;
    leader: string;
    guides: string[];
    note: string;
    arriveSite: string;
  };
  status: number;
}

export interface TripFilter {
  startDate: number;
  endDate: number;
  level: string[];
  type: string[];
  region: string[];
  price_interval: number[];
  day_interval: 1 | 2 | 3 | 4;
}
