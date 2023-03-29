const admin = require('firebase-admin');
const functions = require("firebase-functions");
const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');

const serviceAccount = require("../mountain-climb-b03b9-firebase-adminsdk-v7hwp-381a4156a3.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = getFirestore();

// Take the text parameter passed to this HTTP endpoint and insert it into 
// Firestore under the path /messages/:documentId/original
/*exports.addMessage = functions.https.onRequest(async (req, res) => {
  // Grab the text parameter.
  const original = req.query.text;
  console.log('request', req.query)
  
  // Push the new message into Firestore using the Firebase Admin SDK.
  const writeResult = await admin.firestore().collection('trips').add(req.query);
  // Send back a message that we've successfully written the message
  res.json({result: `Message with ID: ${writeResult.id} added.`});
});

exports.addTrip = functions.https.onRequest(async (req, res) => {
  // Grab the text parameter.
  const original = req.query.text;
  const docRef = admin.firestore().collection('trips').doc('keelong');

  result = await docRef.set({
    start_date: '2023-03-31',
    end_date: '2023-04-05',
    location: 'simple',
    difficulty: 5,
    type: 3,
    price: 16000,
    image_url: '/tmp/taipei.jpg',
    description: '行程敘述',
    available: 1,
    application: 20,
    limitation: 50
  });
  res.json({result: result});
});*/

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
    //result.push(Object.assign({id: doc.id}, doc.data()));
  }))
  .then(() => {
    console.log('result: ', result);
    res.json({result: result});
  })
  .catch(err => console.error(err));
});

// Listens for new messages added to /messages/:documentId/original and creates an
// uppercase version of the message to /messages/:documentId/uppercase
/*exports.makeUppercase = functions.firestore.document('/messages/{documentId}')
    .onCreate((snap, context) => {
      // Grab the current value of what was written to Firestore.
      const original = snap.data().original;

      // Access the parameter `{documentId}` with `context.params`
      functions.logger.log('Uppercasing', context.params.documentId, original);
      
      const uppercase = original.toUpperCase();
      
      // You must return a Promise when performing asynchronous tasks inside a Functions such as
      // writing to Firestore.
      // Setting an 'uppercase' field in Firestore document returns a Promise.
      return snap.ref.set({uppercase}, {merge: true});
    });*/
