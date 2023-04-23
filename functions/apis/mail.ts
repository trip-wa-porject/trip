import { createTransport } from 'nodemailer'
import * as fs from 'fs'
import * as handlebars from 'handlebars'

const readHTMLFile = function (
  path: string,
  callback: (...params: any) => any
) {
  fs.readFile(path, { encoding: 'utf-8' }, function (err, html) {
    if (err) {
      callback(err)
    } else {
      callback(null, html)
    }
  })
}

const mailSetting = createTransport({
  host: 'smtp.gmail.com',
  port: 465,
  auth: {
    user: 'wa.project.mountain@gmail.com',
    pass: 'ezcecwgjummrscpw',
  },
})

readHTMLFile(__dirname + '/index.html', function (err, html) {
  if (err) {
    console.log('error reading file', err)
    return
  }
  const template = handlebars.compile(html)
  const replacements = {}
  const htmlToSend = template(replacements)
  console.log(htmlToSend)
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
})
