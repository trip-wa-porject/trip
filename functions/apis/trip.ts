import { https, logger } from 'firebase-functions'
import type { Trip, TripFilter } from '../@types'
import { db } from '../auth'
import filter from './utils'

const searchTripsOnCall = https.onCall(async (data) => {
  logger.warn('********************************88')
  return await searchTrips(data)
})

const regions = [
  '南投縣',
  '台北市',
  '台中市',
  '台南市',
  '高雄市',
  '台東縣',
  '雲林縣',
  '嘉義縣',
  '新北市',
  '桃園市',
  '基隆市',
  '新竹市',
  '花蓮縣',
  '苗栗縣',
  '彰化縣',
  '屏東縣',
  '宜蘭縣',
  '澎湖縣',
]

const levels = ['A', 'B', 'C']

const types = ['高山步道', '郊山步道', '中級山步道']

const searchTrips = async (data: Partial<TripFilter>) => {
  const result: Trip[] = []

  logger.info({ structuredData: true, data: data })

  const filters = {
    startDate: new Date().getTime(),
    endDate: new Date(Date.now() + 365 * 24 * 60 * 60 * 1000).getTime(),
    level: levels,
    type: types,
    region: regions,
    ...data,
  }

  return db
    .collection('trips')
    .orderBy('startDate')
    .get()
    .then((snapshot) =>
      snapshot.forEach((doc) => {
        const rec = doc.data()

        result.push({
          ...rec,
          id: doc.id,
        } as Trip)

        const passfilter = filter(filters, rec as Trip)
        if (passfilter) {
          result.push({
            ...rec,
            id: doc.id,
          } as Trip)
        }
      })
    )
    .then(() => result)
    .catch(() => [])
}

export { searchTripsOnCall }
