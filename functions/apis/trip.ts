import { https } from 'firebase-functions'
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
  '澎湖縣'
]

const levels = ['A', 'B', 'C']

const types = ['高山步道', '郊山步道', '中級山步道']

const ref = db.collection('trips')

const searchTripsFromFireStore = async (
  data: Partial<TripFilter>
): Promise<Trip[]> => {
  const filters = {
    level: levels,
    type: types,
    region: regions,
    ...data
  }

  const result: Trip[] = []

  await ref
    .get()
    .then((snapshot) => {
      snapshot.forEach((doc) => {
        const rec = doc.data()

        const passfilter = filter(filters, rec as Trip)

        if (passfilter) {
          result.push({
            ...rec,
            tripId: doc.id
          } as Trip)
        }
      })
    })
    .then(() => result)
    .catch(() => [])

  return result
}

const searchSpecificTrop = async (tripId: string): Promise<Trip> => {
  const result = await ref.doc(tripId).get()

  if (result.exists) {
    return { ...(result.data() as Trip), tripId }
  }

  throw new HttpsError('not-found', "This trip doesn't exist")
}

export const searchTrip = https.onCall(async (data: { tripId: string }) => {
  try {
    const result = await searchSpecificTrop(data.tripId)
    return result
  } catch {
    throw new HttpsError('not-found', "This trip doesn't exist")
  }
})

export const searchTrips = https.onCall(async (data) => {
  const result = await searchTripsFromFireStore(data)
  return result
})