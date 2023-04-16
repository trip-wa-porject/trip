import { https, logger } from 'firebase-functions'
import type { Register, Payment, User, Trip } from '../@types'
import { db } from '../auth'
import { HttpsError } from 'firebase-functions/v1/auth'

const ref = db.collection('register')

const checkUserAndTripExists = async (info: {
  tripId: string
  userId: string
}) => {
  const { tripId, userId } = info
  try {
    const tripChecker = await db.collection('trips').doc(tripId).get()

    const userChecker = await db.collection('users').doc(userId).get()

    if (tripChecker.exists && userChecker.exists) {
      return true
    } else {
      return false
    }
  } catch {
    return false
  }
}

const UserAddRegisterTrip = async (data: {
  userId: string
  tripId: string
}) => {
  const { userId, tripId } = data

  const ref = db.collection('users')

  const user = await ref.doc(userId).get()
  if (!user.exists) {
    return Promise.reject('This User not exist')
  }

  const userData = user.data() as User

  if (
    Array.isArray(userData?.registerTrips) &&
    userData?.registerTrips?.includes(tripId)
  ) {
    return Promise.reject('This Trip is already register')
  }

  const oldData = Array.isArray(userData?.registerTrips)
    ? [...userData?.registerTrips]
    : []

  return ref.doc(userId).update({ registerTrips: [...oldData, tripId] })
}

const TripAddRegisterUser = async (data: {
  userId: string
  tripId: string
}) => {
  const { userId, tripId } = data

  const ref = db.collection('trips')

  const trip = await ref.doc(tripId).get()
  if (!trip.exists) {
    return Promise.reject('This Trip not exist')
  }

  const tripData = trip.data() as Trip

  if (
    Array.isArray(tripData?.applicants) &&
    tripData?.applicants?.includes(userId)
  ) {
    return Promise.reject('This User is already register')
  }

  const oldData = Array.isArray(tripData?.applicants)
    ? [...tripData?.applicants]
    : []

  return ref.doc(tripId).update({ registerUsers: [...oldData, userId] })
}

const filterRegisters = async (userId: string) => {
  const results: Register[] = []

  await ref
    .where('userId', '==', userId)
    .get()
    .then((snapshot) =>
      snapshot.forEach((e) => results.push(e.data() as Register))
    )
    .catch()

  return results
}

export const createRegister = https.onCall(async (data: Register) => {
  const keys = Object.keys(data)
  if (!['tripId', 'userId', 'status'].every((e) => keys.includes(e))) {
    throw new HttpsError('invalid-argument', 'Not enough information')
  }

  const { tripId, userId } = data

  const checker = await checkUserAndTripExists({ tripId, userId })
  if (!checker) {
    throw new HttpsError('not-found', "Trip or User doesn't exist")
  }

  try {
    const addRegister = ref.add({
      ...data,
      paymentExpireDate: new Date().getTime() + 86400000,
      createDate: new Date().getTime(),
      updateDate: new Date().getTime(),
      paymentInfo: {}
    })
    const tripAddUser = TripAddRegisterUser(data)
    const userAddTrip = UserAddRegisterTrip(data)

    const [doc, user, trip] = await Promise.all([
      addRegister,
      tripAddUser,
      userAddTrip
    ])

    return { registerId: doc.id }
  } catch (e) {
    logger.info(`create User failed`, e)
    return {}
  }
})

export const updateRegister = https.onCall(
  async (data: {
    registerId: string
    status: number
    paymentInfo: Payment
  }) => {
    const keys = Object.keys(data)
    if (
      !['registerId', 'status', 'paymentInfo'].every((e) => keys.includes(e))
    ) {
      throw new HttpsError('invalid-argument', 'Not enough information')
    }

    const { registerId, status, paymentInfo } = data

    const checker = await ref.doc(registerId).get()
    if (!checker.exists) {
      throw new HttpsError('not-found', "Register doesn't exist")
    }

    checker.ref.update({ status, paymentInfo })
    try {
      const _ = await checker.ref.update({ status, paymentInfo })

      return { status: true }
    } catch {
      return {}
    }
  }
)

export const getUserRegisters = https.onCall(
  async (data: { userId: string }) => {
    const keys = Object.keys(data)
    if (!['userId'].every((e) => keys.includes(e))) {
      throw new HttpsError('invalid-argument', 'Not enough information')
    }

    const { userId } = data
    const userChecker = await db.collection('users').doc(userId).get()

    if (!userChecker.exists) {
      //404
      throw new HttpsError('not-found', 'User not found')
    }
    const userRegisters = await filterRegisters(userId)
    logger.info(userRegisters)

    try {
      const results = await Promise.all(
        userRegisters.map(async (e) => {
          const tripInfo = await db.collection('trips').doc(e.tripId).get()

          if (tripInfo.exists) {
            return { ...e, tripInfo: tripInfo.data() }
          } else {
            return e
          }
        })
      )

      return results
    } catch {
      return []
    }
  }
)
