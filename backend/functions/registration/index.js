const functions = require("firebase-functions");
const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');
const db = getFirestore();

exports.addRegistration = functions.https.onRequest(async(req, res) => {
  functions.logger.info({structuredData: true, data: req.body});
  
  let result = await addRegistration(req.body);
  
  functions.logger.info({result: result});

  res.json({result: result});
});

exports.addRegistrationOnCall = functions.https.onCall(async (data, context) => {
  return addRegistration(data);
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
