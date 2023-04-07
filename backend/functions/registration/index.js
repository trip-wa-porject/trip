const functions = require("firebase-functions");
const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');
const db = getFirestore();

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
    .then(res => docRef.id)
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
