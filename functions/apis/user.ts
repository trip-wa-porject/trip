import { https, logger } from 'firebase-functions';
import type { User } from '../@types';
import { db } from '../auth';

const ref = db.collection('users');

export const createUser = https.onCall(async (data: Omit<User, 'id'>) => {
  try {
    const doc = await ref.add(data);
    return { id: doc.id };
  } catch {
    logger.info(`create User failed`);
    return {};
  }
});

export const getUserInfo = https.onCall(async (data: { id: string }) => {
  const { id } = data;

  const result = await ref.doc(id).get();

  if (result.exists) {
    return result.data();
  }

  return Promise.reject(Error(`No such user ID ${id}`));
});
