import type { Trip, TripFilter } from '@types'

const priceInterval: {
  [key: number]: number[]
} = {
  0: [0, 3000],
  1: [3000, 5000],
  2: [5000, 7000],
  3: [7000, 10000],
  4: [10000],
}

const checkPriceInterval = (price: number, price_intervals: number[]) => {
  return price_intervals.some((e) => {
    if (priceInterval[e].length === 1) {
      return price > priceInterval[e][0]
    } else {
      return price > priceInterval[e][0] && price < priceInterval[e][1]
    }
  })
}

const checkDayInterval = (difference: number, dayInterval: number) => {
  if (dayInterval < 4) {
    return difference === dayInterval
  } else {
    return difference > 3
  }
}

export default function filter(filters: Partial<TripFilter>, data: Trip) {
  return Object.keys(filters).every((e) => {
    switch (e) {
      case 'endDate': {
        return filters?.endDate ? data.endDate < filters.endDate : true
      }
      case 'regions': {
        return filters?.regions
          ? data.area.some((e) => {
              return filters?.regions?.includes(e.city)
            })
          : true
      }
      case 'price_intervals': {
        return filters?.price_intervals
          ? checkPriceInterval(data.price, filters.price_intervals)
          : true
      }
      case 'day_intervals': {
        const difference = Math.ceil(
          (data.endDate - data.startDate) / (24 * 60 * 60 * 1000)
        )

        return filters?.day_intervals
          ? filters?.day_intervals?.some((e) => checkDayInterval(difference, e))
          : true
      }
      case 'keyword': {
        return filters.keyword
          ? data.title.indexOf(filters.keyword) !== -1 ||
              data.tripId.indexOf(filters.keyword) !== -1 ||
              data.information.guides.some(
                (e) => e.indexOf(filters.keyword ?? '') !== -1
              )
          : true
      }
      default: {
        return true
      }
    }
  })
}
