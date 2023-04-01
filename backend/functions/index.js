const admin = require('firebase-admin');
const functions = require("firebase-functions");
const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');

const serviceAccount = require("../wa-project-mountain-firebase-adminsdk-wi067-561cb1a027.json");
//mountain-climb-b03b9-firebase-adminsdk-v7hwp-381a4156a3.json

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const data = require('../final_output.json');

const db = getFirestore();

exports.searchTrips = functions.https.onRequest(async (req, res) => {
  let result = [];
  
  functions.logger.info({structuredData: true, request: req.query, body: req.body});
  
  let startDateFrom = new Date(Date.now()).toJSON().substring(0, 10);
  let startDateTo = new Date(Date.now() + 365 * 24 * 60 * 60 * 1000).toJSON().substring(0, 10);
  let type = ['百岳', '郊山', '中級山', '海外', '健行'];
  //['郊山', '中級山', '百岳', '海外', '健行', '攀岩/攀樹', '溯溪', '攝影', '其他'];
  let level = ['A', 'B', 'C'];
  let area = ['台北市', '新北市'];
  //['台北市', '基隆市', '新北市', '宜蘭縣', '新竹市', '新竹縣', '桃園市', '苗栗縣', '台中市', '彰化縣', '南投縣', '嘉義市', '嘉義縣', '雲林縣', '台南市', '高雄市', '澎湖縣', '屏東縣', '台東縣', '花蓮縣', '金門縣', '連江縣', '南海諸島', '釣魚台列嶼'];
  
  if (req.body.startDateFrom) {
    startDateFrom = req.body.startDateFrom;
  }
  
  if (req.body.startDateTo) {
    startDateTo = req.body.startDateTo;
  }
  
  if (req.body.type) {
    type = req.body.type;
  }
  
  if (req.body.level) {
    level = req.body.level;
  }
  
  if (req.body.area) {
    area = req.body.area;
  }
  
  functions.logger.info(`startDatefrom: ${startDateFrom}`);
  functions.logger.info(`startDateTo: ${startDateTo}`);
  
  db.collection('trips')
  .where('startDate', '>=', startDateFrom)
  .where('startDate', '<=', startDateTo)
  .where('type', 'in', type)
  .where('level', 'in', level)
  .where('area', 'array-contains-any', area)
  .orderBy('startDate')
  .get()
  .then(res => res.forEach(doc => {
    let rec = doc.data();
    
    if (filter(req.body, rec)) {
      functions.logger.info(`document id: ${doc.id}`);
      result.push({[doc.id]: doc.data()});
    }
  }))
  .then(() => {
    functions.logger.info('result: ', result);
    res.json({result: result});
  })
  .catch(err => console.error(err));
});

function filter(query, rec) {
  
    functions.logger.info(rec);
    
    if (query.endDateFrom && rec['endDate'] < query.endDateFrom) {
      return false;
    }
    
    if (query.endDateTo && rec['endDate'] > query.endDateTo) {
      return false;
    }
    
    if (query.priceFrom && rec['price'] < query.priceFrom) {
      return false;
    }
    
    if (query.priceTo && rec['price'] > query.priceTo) {
      return false;
    }
    
    if (query.keyword && !keywordFound(query.keyword, [rec['title'], rec['information'].leader, rec['information'].guides])) {
      return false;
    }
    
    return true;
}

function keywordFound(keyword, fields) {
  let result = false;
  
  if (fields[0].indexOf(keyword) !== -1) {
    result = true;
  }
  
  if (fields[1].indexOf(keyword) !== -1) {
    result = true;
  }
  
  if (fields[2].indexOf(keyword) !== -1) {
    result = true;
  }
  
  return result;
}

exports.batchAddTrips = functions.https.onRequest(async (req, res) => {
  data.forEach(v => {
    const docRef = admin.firestore().collection('trips').doc(v.id.toString());
  
    docRef.set({
      "title": v.title,
      "startDate": new Date(v.startDate * 1000).toJSON().substring(0, 10),
      "endDate": new Date(v.endDate * 1000).toJSON().substring(0, 10),
      "area": v.area,
      "type": v.type,
      "level": v.level,
      "breif": "秀霸線包含池有山、品田山、布秀蘭山、巴紗拉雲山、大霸尖山、小霸尖山、伊澤山和加利山。有別於傳統路線，來趟秀霸連走讚嘆這巍峨神聖的稜線。",
      "roadImage": v.roadImage,
      "price": v.price,
      "memberPrice": v.memberPrice,
      "url": v.url,
      "applicants": v.applicants,
      "limitation": v.limitation,
      "images": v.images,
      "information": {
        "applyStart": new Date(v.information.applyStart * 1000).toJSON().substring(0, 10),
        "applyEnd": new Date(v.information.applyEnd * 1000).toJSON().substring(0, 10),
        "applyWay": v.information.applyWay,
        "gatherPlace": v.information.gatherPlace,
        "gatherTime": new Date(v.information.gatherTime * 1000).toJSON().substring(0, 16),
        "transportationWay": v.information.transportationWay,
        "transportationInfo": v.information.transportationInfo,
        "preDepartureMeetingDate": new Date(v.information.preDepartureMeetingDate * 1000).toJSON().substring(0, 16),
        "preDepartureMeetingPlace": v.information.preDepartureMeetingPlace,
        "memo": v.information.memo,
        "leader": v.information.leader,
        "guides": v.information.guides,
        "note": v.information.note,
        "arriveSite": v.information.arriveSite
      },
      "status": v.status
    })
    .then(res => console.log('response', res))
    .catch(err => console.error(err));
  });
});
