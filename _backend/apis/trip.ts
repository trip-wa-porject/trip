// import { https, logger } from 'firebase-functions/v1'
// import type { Trip, TripFilter } from '@types'
// import { db } from 'auth'

// const searchTripsOnCall = https.onCall(async (data) => {
//   return await searchTrips(data)
// })

// const searchTrips = async (data: TripFilter) => {
//   let result = []

//   logger.info({ structuredData: true, data: data })

//   let startDateFrom = new Date(Date.now()).toISOString().slice(0, 10)
//   let startDateTo = new Date(Date.now() + 365 * 24 * 60 * 60 * 1000)
//     .toISOString()
//     .slice(0, 10)

//   let level = ['A', 'B', 'C']

//   if (data.startDateFrom) {
//     startDateFrom = data.startDateFrom
//   }

//   if (data.startDateTo) {
//     startDateTo = data.startDateTo
//   }

//   if (data.level) {
//     level = data.level
//   }

//   return db
//     .collection('trips')
//     .where('startDate', '>=', startDateFrom)
//     .where('startDate', '<=', startDateTo)
//     .where('level', 'in', level)
//     .orderBy('startDate')
//     .get()
//     .then((snapshot) =>
//       snapshot.forEach((doc) => {
//         let rec = doc.data()

//         logger.info(`filtering document id: ${doc.id}`)

//         if (filter(data, rec)) {
//           result.push({ id: doc.id, ...doc.data() })
//         }
//       })
//     )
//     .then(() => result)
//     .catch((err) => console.error(err))
// }
