import { getDatabase } from 'firebase-admin/database'
import * as admin from 'firebase-admin'
import { config } from 'dotenv'

config()

const _needToConnectToEmulator = true

if (_needToConnectToEmulator) {
  process.env['FIRESTORE_EMULATOR_HOST'] = 'localhost:8080'
}

console.log(process.env['FIRESTORE_EMULATOR_HOST'])

const app = admin.initializeApp(
  _needToConnectToEmulator
    ? {}
    : {
        // credential: admin.credential.applicationDefault()
      }
)

// console.log(app.firestore)

const db = app.firestore()

export { db }
