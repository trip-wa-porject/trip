import { mailSetting } from './auth'
import { readFile } from 'fs'
import { compile } from 'handlebars'
import { join } from 'path'

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
  join(__dirname, '../email-template-maker/build_production/index.html'),
  function (err, html) {
    if (err) {
      console.log('error reading file', err)
      return
    }
    console.log('************')
    console.log(process.env.APP_PASSWORD)
    console.log('************')

    const template = compile(html)
    const replacements = {}
    const htmlToSend = template(replacements)

    const mailOptions = {
      from: 'wa.project.mountain@gmail.com',
      to: 'asdfg09487@gmail.com',
      subject: '謝謝您的預定行程！',
      html: htmlToSend
    }

    mailSetting.sendMail(mailOptions, function (error, response) {
      if (error) {
        console.log(error)
      }
    })
  }
)
