const functions = require("firebase-functions");
const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');
const db = getFirestore();

exports.addUser = functions.https.onRequest(async(req, res) => {
  functions.logger.info({data: req.body});
  
  let result = await addUser(req.body);
  
  functions.logger.info({result: result});

  res.json({result: result});
});

exports.addUserOnCall = functions.https.onCall(async (data, context) => {
  return addUser(data);
});

exports.getUser = functions.https.onRequest(async(req, res) => {
  let result = await getUser(req.body.id);
  
  res.json({result: result});
});

exports.getUserOnCall = functions.https.onCall(async (data, context) => {
  return getUser(data.id);
});

exports.updateUser = functions.https.onRequest(async(req, res) => {
  let result = await updateUser(req.body);
  
  res.json({result: result});
});

exports.updateUserOnCall = functions.https.onCall(async (data, context) => {
  return updateUser(data);
});

async function addUser(data) {
  let docRef = db.collection('users').doc(data.id);
  
  return docRef.set({
      "id": data.id,
      "email": data.email,
      "name": data.name,
      "mobile": data.mobile,
      "idno": data.idno,
      "emergentContactor": data.emergentContactor,
      "emergentContactTel": data.emergentContactTel,
      "sexual": data.sexual,
      "address": data.address,
      "birth": data.birth,
      "contactorRelationship": data.contactorRelationship,
      "membership": 0,
      "agreements": data.agreements,
      "createDate": Date.now(),
      "updateDate": Date.now()
    })
    .then(res => docRef.id)
    .catch(err => console.error(err));
}

async function getUser(id) {
  return db.collection('users')
  .doc(id)
  .get()
  .then(snapshot => snapshot.data())
  .catch(err => console.error(err));
}

async function updateUser(data) {
  return db.collection('users')
  .doc(data.id).update(data);
}
