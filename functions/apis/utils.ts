import type { Trip, TripFilter } from '@types'

const priceInterval: {
  [key: number]: number[]
} = {
  1: [0, 3000],
  2: [3000, 5000],
  3: [5000, 7000],
  4: [7000, 10000],
  5: [10000],
}

const checkPriceInterval = (price: number, price_interval: number[]) => {
  return price_interval.some((e) => {
    if (priceInterval[e].length === 1) {
      return price > priceInterval[e][0]
    } else {
      return price > priceInterval[e][0] && price < priceInterval[e][1]
    }
  })
}

const checkDayInterval = (difference: number, dayInterval: 1 | 2 | 3 | 4) => {
  if (dayInterval < 4) {
    return difference <= dayInterval
  } else {
    return difference > 3
  }
}

export default function filter(filters: Partial<TripFilter>, data: Trip) {
  return Object.keys(filters).every((e) => {
    switch (e) {
      case 'startDate': {
        return filters?.startDate ? data.startDate > filters.startDate : true
      }
      case 'endDate': {
        return filters?.endDate ? data.endDate < filters.endDate : true
      }
      case 'level': {
        return filters?.level ? data.level in filters.level : true
      }
      case 'type': {
        return filters?.type ? data.type in filters.type : true
      }
      case 'region': {
        return filters?.region ? data.area.city in filters.region : true
      }
      case 'price_interval': {
        return filters?.price_interval
          ? checkPriceInterval(data.price, filters.price_interval)
          : true
      }
      case 'day_interval': {
        const difference = Math.ceil(
          (data.endDate - data.startDate) / (365 * 24 * 60 * 60 * 1000)
        )

        return filters?.day_interval
          ? checkDayInterval(difference, filters.day_interval)
          : true
      }
      default: {
        return true
      }
    }
  })
}
