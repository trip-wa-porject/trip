import * as firebase from 'firebase-admin'
import cert from './credential.json'

// const _needToConnectToEmulator = process.env.NODE_ENV === 'development'

// if (true) {
//   process.env['FIRESTORE_EMULATOR_HOST'] = 'localhost:8080'
// }

const app = firebase.initializeApp(
  false
    ? {
        projectId: 'wa-project-mountain'
      }
    : {
        credential: firebase.credential.cert(JSON.parse(JSON.stringify(cert)))
      }
)

const db = app.firestore()

export { db }
