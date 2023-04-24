import { readFile } from 'fs'
import { compile } from 'handlebars'
import { join } from 'path'

import { mailSetting } from '../auth'
import { https, logger } from 'firebase-functions'
import type { Register, Payment, User, Trip } from '../@types'
import { db } from '../auth'
import { HttpsError } from 'firebase-functions/v1/auth'

const readHTMLFile = function (
  path: string,
  callback: (...params: any) => any
) {
  readFile(path, { encoding: 'utf-8' }, function (err, html) {
    if (err) {
      callback(err)
    } else {
      callback(null, html)
    }
  })
}

readHTMLFile(
  join(__dirname, '../../email-template-maker/build_production/index.html'),
  function (err, html) {
    if (err) {
      console.log('error reading file', err)
      return
    }
    const template = compile(html)
    const replacements = {}
    const htmlToSend = template(replacements)

    const mailOptions = {
      from: 'my@email.com',
      to: 'asdfg09487@gmail.com',
      subject: 'test subject',
      html: htmlToSend,
    }

    mailSetting.sendMail(mailOptions, function (error, response) {
      if (error) {
        console.log(error)
      }
    })
  }
)

export const sendEmail = https.onCall(
  async (data: { tripId: string; userId: string }) => {
    const keys = Object.keys(data)
    if (!['tripId', 'userId'].every((e) => keys.includes(e))) {
      throw new HttpsError(
        'invalid-argument',
        'must contains tripId and userId'
      )
    }

    if (typeof data?.tripId !== 'string' || typeof data?.userId !== 'string') {
      throw new HttpsError(
        'invalid-argument',
        'type of tripId or userId illegal'
      )
    }

    try {
      return
    } catch {
      throw new HttpsError('not-found', "This trip doesn't exist")
    }
  }
)
