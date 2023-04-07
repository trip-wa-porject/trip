const functions = require("firebase-functions");
const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');
const db = getFirestore();

const data = require('../../final_output.json');

exports.searchTrips = functions.https.onRequest(async(req, res) => {
  let result = await searchTrips(req.body);

  res.json({result: result});
});

exports.searchTripsOnCall = functions.https.onCall(async (data, context) => {
  return searchTrips(data);
});

exports.getOneTrip = functions.https.onRequest(async(req, res) => {
  let result = await getOneTrip(req.body.id);

  res.json({result: result});
});

exports.getOneTripOnCall = functions.https.onCall(async (data, context) => {
  return getOneTrip(data);
});

async function searchTrips(data) {
  let result = [];
  
  functions.logger.info({structuredData: true, data: data});
  
  let startDateFrom = new Date(Date.now()).toJSON().substring(0, 10);
  let startDateTo = new Date(Date.now() + 365 * 24 * 60 * 60 * 1000).toJSON().substring(0, 10);
  let level = ['A', 'B', 'C'];
  
  if (data.startDateFrom) {
    startDateFrom = data.startDateFrom;
  }
  
  if (data.startDateTo) {
    startDateTo = data.startDateTo;
  }
  
  if (data.level) {
    level = data.level;
  }
  
  return db.collection('trips')
  .where('startDate', '>=', startDateFrom)
  .where('startDate', '<=', startDateTo)
  .where('level', 'in', level)
  .orderBy('startDate')
  .get()
  .then(snapshot => snapshot.forEach(doc => {
    let rec = doc.data();
    
    functions.logger.info(`filtering document id: ${doc.id}`);
    
    if (filter(data, rec)) {
      result.push({id: doc.id, ...doc.data()});
    }
  }))
  .then(() => result)
  .catch(err => console.error(err));
}

function filter(query, rec) {
    if (rec['information']['applyEnd'] < new Date(Date.now()).toJSON().substring(0, 10)) {
      return false;
    }
    
    if (query.endDateFrom && rec['endDate'] < query.endDateFrom) {
      return false;
    }
    
    if (query.endDateTo && rec['endDate'] > query.endDateTo) {
      return false;
    }
    
    if (query.type && query.type.indexOf(rec['type']) == -1) {
      return false;
    }
    
    if (query.price && !priceFound(query.price, rec['price'])) {
      return false;
    }
    
    if (query.days && !daysFound(query.days, rec['startDate'], rec['endDate'])) {
      return false;
    }
    
    if (query.keyword && !keywordFound(query.keyword, [rec['title'], rec['information'].leader, rec['information'].guides])) {
      return false;
    }
    
    if (query.area && !(areaFound(query.area, rec['area']))) {
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

function areaFound(areas, cities) {
  let result = [];

  for (area of areas) {
    if (result.length > 0) {
      break;
    }
    
    for (v of cities) {      
      if (v.city == area) {
        result.push(v);
        break;
      }
    }
  }

  return result.length > 0;
}

function priceFound(prices, recPrice) {
  let result = [];
  
  for(price of prices) {
    if (result.length > 0) {
      break;
    }
    
    if (recPrice >= price[0] && recPrice <= price[1]) {
      result.push(recPrice);
      break;
    }
  }
  
  return result.length > 0;
}

function daysFound(days, startDate, endDate) {
  let tripDays = new Date(endDate).getDate() - new Date(startDate).getDate();
  
  if (days == 4) {
    if (tripDays >= days) {
      return true;
    }
  } else {
    if (tripDays == days) {
      return true;
    }
  }
  
  return false;
}

exports.batchAddTrips = functions.https.onRequest(async (req, res) => {
  data.forEach(v => {
    let docRef = db.collection('trips').doc(v.id.toString());
    let areas = v.area.map(v => {
      return {"city": v.substring(0, 3), "county": v.substring(3, 6)};
    });
  
    docRef.set({
      "title": v.title,
      "startDate": new Date(v.startDate * 1000).toJSON().substring(0, 10),
      "endDate": new Date(v.endDate * 1000).toJSON().substring(0, 10),
      "area": areas,
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

async function getOneTrip(id) {
  return db.collection('registrations')
  .doc(id)
  .get()
  .then(snapshot => snapshot.data())
  .catch(err => console.error(err));
}
