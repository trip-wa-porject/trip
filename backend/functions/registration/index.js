const functions = require("firebase-functions");
const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');
const db = getFirestore();
const nodeMailer = require('nodemailer');
const cors = require('cors')({origin: true});
const serviceAccount = require("../../../../wa-project-mountain-5adff5001301.json");

exports.addRegistration = functions.https.onRequest(async(req, res) => {
  functions.logger.info({data: req.body});
  
  let result = await addRegistration(req.body);

  res.json({result: result});
});

exports.addRegistrationOnCall = functions.https.onCall(async (data, context) => {
  return addRegistration(data);
});

exports.getUserAllTrips = functions.https.onRequest(async(req, res) => {
  functions.logger.info({data: req.body});
  
  let result = await getUserAllTrips(req.body.userId);
  
  res.json({result: result});
});

exports.getUserAllTripsOnCall = functions.https.onCall(async (data, context) => {
  return getUserAllTrips(data.userId);
});

exports.updateRegistration = functions.https.onRequest(async(req, res) => {
  functions.logger.info({data: req.body});
  
  try {
    let result = await updateRegistration(req.body);
  
    res.json({result: result});
  } catch(err) {
    functions.logger.error(err.message);
    res.json({result: `failed to update registration ${req.body.id}`});
  }
});

exports.updateRegistrationOnCall = functions.https.onCall(async (data, context) => {
  return updateRegistration(data);
});

async function addRegistration(data) {
  let registration = await getRegistration(data.userId, data.tripId);
  console.log('existed registration', registration.length);
  
  if (registration.length > 0) {
    return null;
  }

  let docRef = db.collection('registrations').doc();
  
  return docRef.set({
      "id": docRef.id,
      "userId": data.userId,
      "tripId": data.tripId,
      "price": data.price,
      "paymentExpireDate": data.paymentExpireDate,
      "paymentInfo": data.paymentInfo,
      "status": 0,
      "createDate": Date.now(),
      "updateDate": Date.now()
    })
    .then(() => {
      notify(docRef.id);
      
      return docRef.id;
    })
    .catch(err => console.error(err));
}

async function getRegistration(userId, tripId) {
  let result = [];
  return db.collection('registrations')
  .where('userId', '=', userId)
  .where('tripId', '=', tripId)
  .get()
  .then(snapshot => snapshot.forEach(doc => result.push(doc.data())))
  .then(() => result)
  .catch(err => console.error(err));
}

async function getUserAllTrips(userId) {
  let result = [];

  return db.collection('registrations')
  .where('userId', '=', userId)
  .orderBy('createDate')
  .get()
  .then(snapshot => snapshot.forEach(doc => result.push(doc.data())))
  .then(() => result)
  .catch(err => console.error(err));
}

async function updateRegistration(data) {
  functions.logger.info({data: data});
  
  return db.collection('registrations')
  .doc(data.id).update(data);
}

async function notify(registrationId) {
  let registration = await db.collection('registrations')
  .doc(registrationId)
  .get()
  .then(snapshot => snapshot.data());
  
  let trip = await db.collection('trips')
  .doc(registration.tripId)
  .get()
  .then(snapshot => snapshot.data());
  
  let user = await db.collection('users')
  .doc(registration.userId)
  .get()
  .then(snapshot => snapshot.data());
  
  let content = genContent(registration, trip, user);

  let transporter = nodeMailer.createTransport({
      service: 'gmail',
      auth: {
          user: serviceAccount.mail,
          pass: serviceAccount.mail_password
      }
  });
  
  let mailOptions = {
      from: serviceAccount.mail,
      to: user.email,
      subject: '行程報名資訊',
      html: content,
      attachments: [{
          filename: 'qrcode.jpg',
          path: 'qrcode.jpg',
          cid: 'qrcode'
      }]
  };

  transporter.sendMail(mailOptions, (err, res) => {
      if (err) {
          console.error(err);
      }
      
      console.log(`registration ${registrationId} notified`, res);
  });
}

function formatDate(date) {
  let day = new Date(Date.parse(date));
  
  return `${day.getFullYear()} / ${day.getMonth() + 1} / ${day.getDate()}`;
}

function getWeekday(date) {
  let weekdays = ['日', '一', '二', '三', '四', '五', '六'];
  
  let weekday = new Date(Date.parse(date)).getDay();
  
  return weekdays[weekday];
}

function getTime(date) {
  let time = new Date(Date.parse(date)).toTimeString();
  return time.substr(0, 5);
}

function getLevel(level) {
  let levels = {'A': '大眾路線（入門）', 'B': '健腳山友（中級）', 'C': '艱難路線（進階）'};
  
  return levels[level];
}

function genContent(registration, trip, user) {
  let name = user.sexual ? `${user.name.substr(0, 1)}先生` : `${user.name.substr(0, 1)}小姐`;
  let paymentId = registration.id;
  let tripTitle = `${trip.title}、正式會員`;
  let payDate = registration.payDate ? formatDate(registration.payDate) : '';
  let price = registration.price;
  let status = registration.status ? '已繳費' : '未繳費';
  let tripDate = `${formatDate(trip.startDate)} (${getWeekday(trip.startDate)}) - ${formatDate(trip.endDate)}(${getWeekday(trip.endDate)}）`;
  let type = trip.type;
  let level = getLevel(trip.level);
  let gatherPlace = trip.information.gatherPlace;
  let gatherTime = `${formatDate(trip.information.gatherTime)}（${getWeekday(trip.information.gatherTime)}）${getTime(trip.information.gatherTime)}`;
  let transportation = trip.information.transportationWay;
  let leader = trip.information.leader;
  let guides = trip.information.guides.join('、');

  return `<table style="text-align: center; table-layout: fixed; border-collapse: collapse; width: 100%; margin-left: auto; margin-right: auto;"><tr style="text-align: center;"><td style="vertical-align: middle;font-family: \'Noto Sans TC\';color: #FFFFFF;font-weight: 400;font-size: 34px;line-height: 49px;letter-spacing: 0.0025em;background: #778C67;height: 129px;">登山網站</td></tr><tr><td style="height: 60px">&nbsp;</td></tr><tr><td style="height: 42px;"><h1 style="font-family: \'Roboto\';font-weight: 900;font-size: 35.7436px;line-height: 42px;color: #000000;">${name}，謝謝！您在登山網站的訂單已匯款成功。</h1></td></tr><tr><td style="height: 40px">&nbsp;</td></tr><tr><td><table style="padding: 10px 140px 0px 40px;width: 70%; justify-content: center;margin-left: auto; margin-right: auto;"><tr><td><h3 style="text-align: left;font-family: \'Noto Sans TC\';font-weight: 700;font-size: 24px;letter-spacing: 0.105em;color: #424242;">訂單詳細資訊</h3></td></tr></table></td></tr><tr><td><table style="padding: 10px 140px 10px 40px;gap: 10px;justify-content: center; margin-left: auto; margin-right: auto; width: 70%; border-width: 1px; border-style: solid; border-color: grey; border-radius: 10px"><tr><td style="width: 165px;font-family: \'Noto Sans TC\';font-weight: 700;font-size: 16px;line-height: 23px;letter-spacing: 0.0015em;color: #424242;">繳費編號</td><td style="text-align: left;width: 94px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #191D23;">${paymentId}</td></tr><tr><td style="width: 165px;font-family: \'Noto Sans TC\';font-weight: 700;font-size: 16px;line-height: 23px;letter-spacing: 0.0015em;color: #424242;">商品明細</td><td style="text-align: left;width: 535px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #191D23;">${tripTitle}</td></tr><tr><td style="width: 165px;font-family: \'Noto Sans TC\';font-weight: 700;font-size: 16px;line-height: 23px;letter-spacing: 0.0015em;color: #424242;">繳費日期</td><td style="text-align: left;width: 79px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #191D23;">${payDate}</td></tr><tr><td style="width: 165px;font-family: \'Noto Sans TC\';font-weight: 700;font-size: 16px;line-height: 23px;letter-spacing: 0.0015em;color: #424242;">付款金額</td><td style="text-align: left;width: 72px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #191D23;">TWD ${price}</td></tr><tr><td style="width: 165px;font-family: \'Noto Sans TC\';font-weight: 700;font-size: 16px;line-height: 23px;letter-spacing: 0.0015em;color: #424242;">繳費狀態</td><td style="text-align: left;width: 43px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #191D23;">${status}</td></tr></table></td></tr><tr><td style="height: 60px">&nbsp;</td></tr><tr><td><table style="padding: 10px 140px 0px 40px;width: 70%; justify-content: center;margin-left: auto; margin-right: auto;"><tr><td><h3 style="text-align: left;font-family: \'Noto Sans TC\';font-weight: 700;font-size: 24px;line-height: 35px;align-items: center;letter-spacing: 0.105em;color: #424242;">行程明細</h3></td></tr></table></td></tr><tr><td><table style="padding: 10px 87px 10px 40px;gap: 10px; margin-left: auto; margin-right: auto; width: 70%; border: 1px solid #778C67; border-radius: 10px"><tr><td style="width: 165px;font-family: \'Noto Sans TC\';font-weight: 700;font-size: 16px;line-height: 23px;letter-spacing: 0.0015em;color: #424242;">活動名稱</td><td style="text-align: left;width: 584px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #191D23;">${tripTitle}</td></tr><tr><td style="width: 165px;font-family: \'Noto Sans TC\';font-weight: 700;font-size: 16px;line-height: 23px;letter-spacing: 0.0015em;color: #424242;">活動日期</td><td style="text-align: left;width: 584px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #191D23;">${tripDate}</td></tr><tr><td style="width: 165px;font-family: \'Noto Sans TC\';font-weight: 700;font-size: 16px;line-height: 23px;text-align: justify;letter-spacing: 0.0015em;color: #424242;">類 型</td><td style="text-align: left;width: 112px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #191D23;">${type}</td></tr><tr><td style="width: 165px;font-family: \'Noto Sans TC\';font-weight: 700;font-size: 16px;line-height: 23px;text-align: justify;letter-spacing: 0.0015em;color: #424242;">等 級</td><td style="text-align: left;width: 584px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #191D23;">${level}</td></tr><tr><td style="width: 165px;font-family: \'Noto Sans TC\';font-weight: 700;font-size: 16px;line-height: 23px;letter-spacing: 0.0015em;color: #424242;">集合地點</td><td style="text-align: left;width: 121px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #191D23;">${gatherPlace}</td></tr><tr><td style="width: 165px;font-family: \'Noto Sans TC\';font-weight: 700;font-size: 16px;line-height: 23px;letter-spacing: 0.0015em;color: #424242;">集合時間</td><td style="text-align: left;width: 105px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #191D23;">${gatherTime}</td></tr><tr><td style="width: 165px;font-family: \'Noto Sans TC\';font-weight: 700;font-size: 16px;line-height: 23px;letter-spacing: 0.0015em;color: #424242;">交通方式</td><td style="text-align: left;width: 29px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #191D23;">${transportation}</td></tr><tr><td style="width: 165px;font-family: \'Noto Sans TC\';font-weight: 700;font-size: 16px;line-height: 23px;letter-spacing: 0.0015em;color: #424242;">領 隊</td><td style="text-align: left;width: 43px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #191D23;">${leader}</td></tr><tr><td style="width: 165px;font-family: \'Noto Sans TC\';font-weight: 700;font-size: 16px;line-height: 23px;letter-spacing: 0.0015em;color: #424242;">嚮 導</td><td style="text-align: left;width: 155px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #191D23;">${guides}</td></tr><tr><td colspan="2"><table style="padding: 5px; margin-left: auto; margin-right: auto; width: 80%;"><tr><td style="width: 65px">&nbsp;</td><td style="width: 98px;"><img src="cid:qrcode" style="width: 98px;height: 98px;"/></td><td style="padding-left: 30px;width: 470px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 24px;line-height: 35px;letter-spacing: 0.03em;color: #000000;text-align: left;">恭喜！你已成功報名，請掃左側QR code 或<a href="#" style="color: #778C67">點此</a>加入活動群組，以便即時通知集合資訊！</td></tr></table></td></tr></table></td></tr></table><table style="padding: 30px; margin-left: auto; margin-right: auto; width: 100%; background: #998167"><tr><td><table style="width: 70%;margin-left: auto; margin-right: auto;"><tr><td><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" style="width: 11px;height: 20px;background: #FFFFFF;border-radius: 5px;border: 2px solid #998167;align-items: center;padding: 5px 10px;gap: 10px;"><path fill="#998167" d="M279.14 288l14.22-92.66h-88.91v-60.13c0-25.35 12.42-50.06 52.24-50.06h40.42V6.26S260.43 0 225.36 0c-73.22 0-121.08 44.38-121.08 124.72v70.62H22.89V288h81.39v224h100.17V288z"/></svg></td></tr><tr><td style="width: 141px;font-family: \'Roboto\';font-weight: 400;font-size: 20px;line-height: 23px;letter-spacing: 0.0015em;color: #FFFFFF;">新北市山岳協會</td></tr><tr><td><hr style="color: white"></td></tr><tr><td style="width: 445px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #FFFFFF;">辦公時間｜每星期二、四晚上7:00-9:00</td></tr><tr><td style="width: 445px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #FFFFFF;">郵政信箱｜22099 新北市板橋郵政52號信箱</td></tr><tr><td style="width: 445px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #FFFFFF;">地址｜22049 新北市板橋區陽明街76號5樓（離捷運新埔站 5 分鐘路程）</td></tr><tr><td>&nbsp;</td></tr><tr><td style="width: 445px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #FFFFFF;">Email｜services@thma.org.tw</td></tr><tr><td style="width: 445px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #FFFFFF;"></td></tr><tr><td style="width: 445px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #FFFFFF;">電話｜02-22500059、22501129、22501126</td></tr><tr><td style="width: 445px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #FFFFFF;">留守專機｜0919-309020、0919-309039</td></tr><tr><td style="width: 445px;font-family: \'Noto Sans TC\';font-weight: 400;font-size: 14px;line-height: 20px;letter-spacing: 0.0025em;color: #FFFFFF;">傳真｜02-22502159</td></tr></table></td></tr></table>`;
}
