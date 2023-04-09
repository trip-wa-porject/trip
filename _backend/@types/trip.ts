// level 跟 status 可以規定嚴格一點

export interface Trip {
  id: number
  title: string
  startDate: number
  endDate: number
  area: string[]
  type: string
  level: 'A' | 'B' | 'C'
  roadImage: string
  price: number
  memberPrice: number
  url: string
  applicants: number
  limitation: number
  images: string[]
  information: {
    applyStart: number
    applyEnd: number
    applyWay: string
    gatherPlace: string
    gatherTime: number
    transportationWay: string
    transportationInfo: string
    preDepartureMeetingDate: number
    preDepartureMeetingPlace: string
    memo: string
    leader: string
    guides: string[]
    note: string
    arriveSite: string
  }
  status: number
}

export interface TripFilter {
  startDateFrom?: number
  startDateTo?: number
  level?: string[]
}
