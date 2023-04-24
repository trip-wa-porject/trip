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
