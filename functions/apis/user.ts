import { https, logger } from 'firebase-functions'
import type { User } from '../@types'
import { db } from '../auth'
import { HttpsError } from 'firebase-functions/v1/auth'

const ref = db.collection('users')

const checkUserExists = async (info: Pick<User, 'idno' | 'email'>) => {
  try {
    const IdChecker = await ref.where('idno', '==', info.idno)?.get()

    const EmailChecker = await ref.where('email', '==', info.email)?.get()

    return IdChecker.empty && EmailChecker.empty ? false : true
  } catch {
    return false
  }
}

type UserWithId = User & { userId: string }

export const createUser = https.onCall(async (data: UserWithId) => {
  const keys = [
    'idno',
    'email',
    'userId',
    'name',
    'mobile',
    'emergentContactor',
    'emergentContactTel',
    'contactorRelationship',
    'sexual',
    'address',
    'birth',
    'member'
  ]

  const checker = Object.keys(data).filter((e) => !keys.includes(e))

  if (checker.length > 0) {
    throw new HttpsError(
      'invalid-argument',
      `These keys need complemnet : ${checker.join(',')}`
    )
  }

  const { idno, email, userId } = data

  const userIdChecker = await ref.doc(userId)?.get()
  if (!userIdChecker?.exists) {
    throw new HttpsError('already-exists', 'This userId already exist')
  }

  const userChecker = await checkUserExists({ idno, email })
  if (userChecker) {
    throw new HttpsError('already-exists', 'This idno or email already exist')
  }

  try {
    const doc = await ref.doc(userId).set(data)

    return { userId: userId }
  } catch {
    logger.info(`create User failed`)
    throw new HttpsError('unknown', 'Server error')
  }
})

export const getUserInfo = https.onCall(async (data: { userId: string }) => {
  const { userId } = data

  const result = await ref.doc(userId).get()

  if (result.exists) {
    return result.data()
  }

  throw new HttpsError('not-found', "This user doesn't exist")
})
