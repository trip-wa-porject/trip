import { https, logger } from 'firebase-functions'
import type { Register, Payment, User, Trip } from '../@types'
import { db } from '../auth'
import { HttpsError } from 'firebase-functions/v1/auth'

const ref = db.collection('register')

const removeData = async (params: {
  collection: string
  docId: string
  removeKey: string
  removeId: string
}) => {
  const { collection, docId, removeKey, removeId } = params

  const doc = await db.collection(collection).doc(docId).get()
  if (!doc.exists) return Promise.reject(`${collection} ${docId} is not exist`)

  const data = doc.data() ?? { [removeKey]: [] }

  const targetArray = Array.isArray(data[removeKey]) ? [...data[removeKey]] : []

  await db
    .collection(collection)
    .doc(docId)
    .update({ [removeKey]: targetArray.filter((e) => e !== removeId) })

  return Promise.resolve('ok')
}

const collectionAddId = async (data: {
  appendId: string
  targetId: string
  collection: string
  appendKey: string
}) => {
  const { appendId, targetId, collection, appendKey } = data

  const ref = db.collection(collection)

  const target = await ref.doc(targetId).get()
  if (!target.exists) {
    return Promise.reject(`${collection}: ${targetId} is not exist`)
  }

  const collection_data = target.data()

  if (
    Array.isArray(collection_data?.[appendKey]) &&
    collection_data?.[appendKey]?.includes(appendId)
  ) {
    return Promise.reject(`${collection}: ${targetId} is already register`)
  }

  const oldData = Array.isArray(collection_data?.[appendKey])
    ? [...collection_data?.[appendKey]]
    : []

  await ref.doc(targetId).update({ [appendKey]: [...oldData, appendId] })

  return Promise.resolve('ok')
}

const checkUserAndTripExists = async (info: {
  tripId: string
  userId: string
}) => {
  const { tripId, userId } = info
  try {
    const tripChecker = await db.collection('trips').doc(tripId).get()
    const userChecker = await db.collection('users').doc(userId).get()

    if (tripChecker.exists && userChecker.exists) {
      const userInfo = userChecker.data() as User
      const tripInfo = tripChecker.data() as Trip

      return {
        price: userInfo.member === 0 ? tripInfo.price : tripInfo.memberPrice,
      }
    } else {
      return false
    }
  } catch {
    return false
  }
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
  if (!['tripId', 'userId'].every((e) => keys.includes(e))) {
    throw new HttpsError('invalid-argument', 'Not enough information')
  }

  const { tripId, userId } = data

  const checker = await checkUserAndTripExists({ tripId, userId })
  if (!checker) {
    throw new HttpsError('not-found', "Trip or User doesn't exist")
  }

  try {
    const promiseHandler: (() => Promise<string>)[] = []

    const arr = [
      {
        appendId: userId,
        targetId: tripId,
        collection: 'trips',
        appendKey: 'applicants',
      },
      {
        appendId: tripId,
        targetId: userId,
        collection: 'users',
        appendKey: 'registerTrips',
      },
    ]

    await Promise.all(
      arr.map((e) =>
        collectionAddId(e).then(() => {
          promiseHandler.push(() =>
            removeData({
              collection: e.collection,
              docId: e.targetId,
              removeKey: e.appendKey,
              removeId: e.appendId,
            })
          )
        })
      )
    )

    if (promiseHandler.length !== arr.length) {
      for (let i = 0; i < arr.length; i++) {
        await promiseHandler[i]()
      }
      throw new HttpsError('not-found', 'tripId or userId not found')
    }

    const now = new Date()

    try {
      const addRegister = await ref.add({
        ...data,
        status: 0,
        paymentExpireDate: now.getTime() + 432000000,
        price: checker.price,
        createDate: now.getTime(),
        updateDate: now.getTime(),
        paymentInfo: {},
        sendMail: 0,
        sendMailTime: null,
      })
      return { registerId: addRegister?.id }
    } catch {
      if (promiseHandler.length !== arr.length) {
        for (let i = 0; i < arr.length; i++) {
          await promiseHandler[i]()
        }
      }
      throw new HttpsError('unknown', 'Server error')
    }
  } catch (e) {
    logger.info(`create register failed`, e)
    throw new HttpsError('unknown', 'Server error')
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

    if (status !== 1) {
      throw new HttpsError('invalid-argument', 'status not allowed')
    }

    const checker = await ref.doc(registerId).get()
    if (!checker.exists) {
      throw new HttpsError('not-found', "Register doesn't exist")
    }

    const may_update_register = checker.data()
    if (may_update_register && may_update_register.status !== 0) {
      throw new HttpsError(
        'invalid-argument',
        'register status not allowed to change'
      )
    }

    checker.ref.update({ status, paymentInfo })
    try {
      const _ = await checker.ref.update({ status, paymentInfo })

      return 'ok'
    } catch {
      return {}
    }
  }
)

// export const cancelRegister = https.onCall(
//   async (data: { registerId: string }) => {
//     const keys = Object.keys(data)
//     if (keys.length > 1 && !keys.includes('registerId')) {
//       throw new HttpsError('invalid-argument', 'argument too much or not include enougn information')
//     }

//     const { registerId } = data

//     const checker = await ref.doc(registerId).get()
//     if (!checker.exists) {
//       throw new HttpsError('not-found', "Register doesn't exist")
//     }

//     const may_update_register = checker.data()
//     if (may_update_register && may_update_register.status !== ) {
//       throw new HttpsError(
//         'invalid-argument',
//         'register status not allowed to change'
//       )
//     }

//     checker.ref.update({ status, paymentInfo })
//     try {
//       const _ = await checker.ref.update({ status, paymentInfo })

//       return 'ok'
//     } catch {
//       return {}
//     }
//   }
// )

export const getUserRegisters = https.onCall(
  async (data: { userId: string }) => {
    const keys = Object.keys(data)
    if (!['userId'].every((e) => keys.includes(e))) {
      throw new HttpsError('invalid-argument', 'Not enough information')
    }

    const { userId } = data
    const userChecker = await db.collection('users').doc(userId).get()

    if (!userChecker.exists) {
      throw new HttpsError('not-found', 'User not found')
    }

    const userRegisters = await filterRegisters(userId)

    try {
      const results = await Promise.all(
        userRegisters.map(async (e) => {
          const tripInfo = await db.collection('trips').doc(e.tripId).get()

          if (tripInfo.exists) {
            return { ...e, tripInfo: tripInfo.data() }
          }
        })
      )

      return results.filter((e) => e?.tripInfo !== undefined)
    } catch {
      return []
    }
  }
)
