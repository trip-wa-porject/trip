const admin = require('firebase-admin');

const serviceAccount = require("../../../wa-project-mountain-5adff5001301.json");

const app = admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const trip = require('./trip');
const user = require('./user');
const registration = require('./registration');

exports.searchTrips = trip.searchTrips;

exports.searchTripsOnCall = trip.searchTripsOnCall;

exports.batchAddTrips = trip.batchAddTrips;

exports.addUser = user.addUser;

exports.addUserOnCall = user.addUserOnCall;

exports.getUser = user.getUser;

exports.getUserOnCall = user.getUserOnCall;

exports.updateUser = user.updateUser;

exports.updateUserOnCall = user.updateUserOnCall;

exports.addRegistration = registration.addRegistration;

exports.addRegistrationOnCall = registration.addRegistrationOnCall;

exports.getUserAllTrips = registration.getUserAllTrips;

exports.getUserAllTripsOnCall = registration.getUserAllTripsOnCall;

exports.updateRegistration = registration.updateRegistration;

exports.updateRegistrationOnCall = registration.updateRegistrationOnCall;

exports.getOneTrip = trip.getOneTrip;

exports.getOneTripOnCall = trip.getOneTripOnCall;
