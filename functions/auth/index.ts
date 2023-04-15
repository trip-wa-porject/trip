import * as firebase from 'firebase-admin'

const _needToConnectToEmulator = process.env.NODE_ENV === 'development'

if (_needToConnectToEmulator) {
  process.env['FIRESTORE_EMULATOR_HOST'] = 'localhost:8080'
}

const app = firebase.initializeApp(
  _needToConnectToEmulator
    ? {
        projectId: 'wa-project-mountain'
      }
    : {
        credential: firebase.credential.applicationDefault()
      }
)

const db = app.firestore()

export { db }
