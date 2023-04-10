import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

abstract class GeneralRepository {}

class BackendRepository implements GeneralRepository {
  //http://127.0.0.1:5001/wa-project-mountain/us-central1/searchTrips
  Future<List<Map<String, dynamic>>> fetchTrip(
      Map<String, dynamic> args) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('searchTripsOnCall')
          .call(args);
      List data = result.data;
      return List<Map<String, dynamic>>.from(data);
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      rethrow;
    }
  }

  Future<void> attendTrip(String uid, String eventId) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('users/${uid}/attendTrip')
          .doc(eventId)
          .set({
        'eventId': eventId,
      });
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getUserDocument(String uid) async {
    try {
      final result = await FirebaseFirestore.instance.doc('users/${uid}').get();
      return result.data();
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> updateUserDocument(
      String uid, Map<String, dynamic> data) async {
    try {
      Map<String, dynamic>? doc = await getUserDocument(uid);
      if (doc == null) {
        final result = await FirebaseFirestore.instance
            .doc('users/$uid')
            .set({'created': FieldValue.serverTimestamp(), ...data});
      } else {
        final result =
            await FirebaseFirestore.instance.doc('users/$uid').update(data);
      }
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      rethrow;
    }
  }
}
