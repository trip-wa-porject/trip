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
          .httpsCallable('searchTrips')
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

  //addUserOnCall
  //curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/addUser -d '{"id":"123456","email":"amew@gmail.com","name":"陳阿喵","mobile":"0987654321","idno":"A123456789","emergentContactor":"陳旺旺","emergentContactTel":"0987654321","sexual":0,"address":"台北市中山區中山北路","birth":"2006-07-23","contactorRelationship":"pet","member":0}'
  Future<String> addUser(Map<String, dynamic> args) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('addUserOnCall')
          .call(args);
      String data = result.data;
      return data;
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      rethrow;
    }
  }

  //getUserOnCall
  //curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/getUser -d '{"id":"123456"}'
  Future<List<Map<String, dynamic>>> getUser(Map<String, dynamic> args) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('getUserOnCall')
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

  //updateUser
  //curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/updateUser -d '{"id":"m2ogLuNPJd12t8BgzV0b","status":"done"}'
  Future<List<Map<String, dynamic>>> updateUser(
      Map<String, dynamic> args) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('updateUserOnCall')
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

  //addRegistration
  //curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/addRegistration -d '{"tripId":"110001","price":5200,"paymentExpireDate":"2023-04-10","paymentInfo":{},"emergentContactor":"陳旺旺","emergentContactTel":"0987654321","sexual":0,"address":"台北市中山區中山北路","birth":"2006-07-23","contactorRelationship":"pet","member":0}'
  Future<String> addRegistration(Map<String, dynamic> args) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('addRegistrationOnCall')
          .call({
        "userId": args['userId'],
        "tripId": args['tripId'],
        "price": args['price'],
        "paymentExpireDate": args['paymentExpireDate'],
        "paymentInfo": args['paymentInfo'],
      });
      return result.data;
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      rethrow;
    }
  }

  //getUserAllTrips
  //查詢單一會員所有行程：
  //curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/trip-b6ddf/us-central1/getUserAllTrips -d '{"userId":"123456"}'
  Future<List<Map<String, dynamic>>> getUserAllTrips(String userId) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('getUserAllTripsOnCall')
          .call({'userId': userId});
      List data = result.data;
      return List<Map<String, dynamic>>.from(data);
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      rethrow;
    }
  }

  //updateRegistration
  Future<List<Map<String, dynamic>>> updateRegistration(
      Map<String, dynamic> args) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('updateRegistrationOnCall')
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

  //getOneTrip
  //取得單一行程detail
  //curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/getOneTrip -d '{"id":"m2ogLuNPJd12t8BgzV0b"}'
  Future<Map<String, dynamic>?> getOneTrip(String id) async {
    try {
      final result =
          await FirebaseFirestore.instance.collection('trips').doc(id).get();
      if (result.data() == null) return null;
      Map<String, dynamic> map = result.data()!;
      map['id'] = result.id;
      return map;
      //TODO error handle
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      rethrow;
    }
  }

  // Future<void> attendTrip(String uid, String eventId) async {
  //   try {
  //     final result = await FirebaseFirestore.instance
  //         .collection('users/${uid}/attendTrip')
  //         .doc(eventId)
  //         .set({
  //       'eventId': eventId,
  //     });
  //   } on FirebaseFunctionsException catch (error) {
  //     print(error.code);
  //     print(error.details);
  //     print(error.message);
  //     rethrow;
  //   }
  // }

  // Future<Map<String, dynamic>?> getUserDocument(String uid) async {
  //   try {
  //     final result = await FirebaseFirestore.instance.doc('users/${uid}').get();
  //     return result.data();
  //   } on FirebaseFunctionsException catch (error) {
  //     print(error.code);
  //     print(error.details);
  //     print(error.message);
  //     rethrow;
  //   }
  // }

  // Future<Map<String, dynamic>?> updateUserDocument(
  //     String uid, Map<String, dynamic> data) async {
  //   try {
  //     Map<String, dynamic>? doc = await getUserDocument(uid);
  //     if (doc == null) {
  //       final result = await FirebaseFirestore.instance
  //           .doc('users/$uid')
  //           .set({'created': FieldValue.serverTimestamp(), ...data});
  //     } else {
  //       final result =
  //           await FirebaseFirestore.instance.doc('users/$uid').update(data);
  //     }
  //   } on FirebaseFunctionsException catch (error) {
  //     print(error.code);
  //     print(error.details);
  //     print(error.message);
  //     rethrow;
  //   }
  // }
}
