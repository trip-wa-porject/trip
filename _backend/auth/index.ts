import * as admin from 'firebase-admin'
import { config } from 'dotenv'
import { hostname } from 'os'

const site = hostname()

config()

const _needToConnectToEmulator = process.env.NODE_ENV === 'development'

if (_needToConnectToEmulator) {
  process.env['FIRESTORE_EMULATOR_HOST'] = 'localhost:8080'
}

const app = admin.initializeApp(
  _needToConnectToEmulator
    ? {
        projectId: 'wa-project-mountain-dev'
      }
    : {
        credential: admin.credential.applicationDefault()
      }
)

const db = app.firestore()

export { db }
