import * as firebase from 'firebase-admin'
import { createTransport } from 'nodemailer'
import { config } from 'dotenv'

config()

const cert = {
  type: 'service_account',
  project_id: 'wa-project-mountain',
  private_key_id: '76e7fa0b741b91c63e2e718b68bdfeba8129b776',
  private_key: process.env.SERVICE_ACCOUNT_KEY?.replace(/\\n/g, '\n') ?? '',
  client_email: 'wa-project-mountain@appspot.gserviceaccount.com',
  client_id: '116064397620620067301',
  auth_uri: 'https://accounts.google.com/o/oauth2/auth',
  token_uri: 'https://oauth2.googleapis.com/token',
  auth_provider_x509_cert_url: 'https://www.googleapis.com/oauth2/v1/certs',
  client_x509_cert_url:
    'https://www.googleapis.com/robot/v1/metadata/x509/wa-project-mountain%40appspot.gserviceaccount.com',
}

const dev = process.env['NODE_ENV'] === 'development'
const useEmulators = !process.env.SERVICE_ACCOUNT_KEY

if (dev) {
  process.env['FIRESTORE_EMULATOR_HOST'] = 'localhost:8080'
}

const app = firebase.initializeApp(
  dev || useEmulators
    ? {
        projectId: 'wa-project-mountain',
      }
    : {
        // for typescript hint
        credential: firebase.credential.cert(JSON.parse(JSON.stringify(cert))),
      }
)

const db = app.firestore()

const mailSetting = createTransport({
  host: 'smtp.gmail.com',
  port: 465,
  auth: {
    user: 'wa.project.mountain@gmail.com',
    pass: process.env.APP_PASSWORD,
  },
})

export { db, mailSetting }
