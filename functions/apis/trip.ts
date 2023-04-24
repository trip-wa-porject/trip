import { https, logger } from 'firebase-functions'
import type { Trip, TripFilter } from '../@types'
import { db } from '../auth'
import filter from './utils'
import { HttpsError } from 'firebase-functions/v1/auth'

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

const ref = db.collection('trips')

const searchTripsFromFireStore = async (
  data: Partial<TripFilter>
): Promise<{ results: Trip[]; count: number }> => {
  const filterKeys = [
    'startDate',
    'endDate',
    'levels',
    'types',
    'regions',
    'price_intervals',
    'day_interval',
    'keyword',
    'page',
  ]

  const data_keys = Object.keys(data)

  if (data_keys.length > 0 && !data_keys.every((e) => filterKeys.includes(e))) {
    // 400
    throw new HttpsError('invalid-argument', 'invalid search keys')
  }

  const filters = {
    levels,
    types,
    regions,
    page: 0,
    ...data,
  }

  const result: Trip[] = []
  let totalCount: number = 0

  await ref
    .orderBy('startDate')
    .limit(20)
    .startAfter(filters.page * 20)
    .get()
    .then((snapshot) => {
      totalCount = snapshot.docs.length

      snapshot.forEach((doc) => {
        const rec = doc.data()

        const passfilter = filter(filters, rec as Trip)

        if (passfilter) {
          result.push({
            ...rec,
            tripId: doc.id,
          } as Trip)
        }
      })
    })
    .then(() => logger.info('search filters', filters))
    .catch(() => [])

  return {
    results: result,
    count: totalCount,
  }
}

const searchSpecificTrip = async (tripId: string): Promise<Trip> => {
  const result = await ref.doc(tripId).get()

  if (result.exists) {
    return { ...(result.data() as Trip), tripId }
  }

  throw new HttpsError('not-found', "This trip doesn't exist")
}

export const searchTrip = https.onCall(async (data: { tripId: string }) => {
  if (!data?.tripId) {
    throw new HttpsError('invalid-argument', 'must containes tripId for search')
  }

  if (typeof data?.tripId !== 'string') {
    throw new HttpsError('invalid-argument', 'type of tripId illegal')
  }

  try {
    const result = await searchSpecificTrip(data.tripId)
    return result
  } catch {
    throw new HttpsError('not-found', "This trip doesn't exist")
  }
})

export const searchTrips = https.onCall(async (data: TripFilter) => {
  const result = await searchTripsFromFireStore(data)
  return result
})
