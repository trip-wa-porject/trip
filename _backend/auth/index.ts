import { getDatabase } from 'firebase-admin/database'
import * as admin from 'firebase-admin'
import { config } from 'dotenv'

config()

const app = admin.initializeApp({
  credential: admin.credential.applicationDefault()
})

// console.log(app.firestore)

const db = app.firestore()

export { db }
