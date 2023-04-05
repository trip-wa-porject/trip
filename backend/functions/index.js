const admin = require('firebase-admin');

const serviceAccount = require("../../../wa-project-mountain-5adff5001301.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const trip = require('./trip');

exports.searchTrips = trip.searchTrips;

exports.searchTripsOnCall = trip.searchTripsOnCall;

exports.batchAddTrips = trip.batchAddTrips;
