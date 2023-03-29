const admin = require('firebase-admin');
const functions = require("firebase-functions");
const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');

const serviceAccount = require("../wa-project-mountain-firebase-adminsdk-wi067-561cb1a027.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = getFirestore();

exports.searchTrips = functions.https.onRequest(async (req, res) => {
  const query = req.query;
  let result = [];
  functions.logger.info("query", {structuredData: true, request: query});
  
  db.collection('trips')
  .where('area', 'array-contains-any', ['新竹縣尖石鄉','苗栗縣泰安鄉'])
  .where('start_date', '>', '2023-03-26')
  .where('price', '==', 5200)
  .where('type', 'in', ['百岳'])
  .where('level', 'in', ['BK'])
  .get()
  .then(res => res.forEach(doc => {
    functions.logger.info(`${query.id}-${doc.id}`, doc.data());
    result.push({[doc.id]: doc.data()});
  }))
  .then(() => {
    functions.logger.info('result: ', result);
    res.json({result: result});
  })
  .catch(err => console.error(err));
});
