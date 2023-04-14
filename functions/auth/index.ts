import * as firebase from 'firebase-admin'
// import { config } from 'dotenv'

// config();

const _needToConnectToEmulator = process.env.NODE_ENV === 'development'

if (true) {
  process.env['FIRESTORE_EMULATOR_HOST'] = 'localhost:8080'
}

const app = firebase.initializeApp(
  true
    ? {
        projectId: 'wa-project-mountain-dev',
      }
    : {
        credential: firebase.credential.applicationDefault(),
      }
)

const db = app.firestore()

export { db }
