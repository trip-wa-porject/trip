import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:tripflutter/models/registration.dart';

abstract class GeneralRepository {}

class BackendRepository implements GeneralRepository {
  //http://127.0.0.1:5001/wa-project-mountain/us-central1/searchTrips
  //POST https://us-central1-wa-project-mountain.cloudfunctions.net/searchTrips
  Future<Map<String, dynamic>> fetchTrip(Map<String, dynamic> args) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('searchTrips')
          .call(args);
      Map<String, dynamic> data = result.data;
      return data;
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      rethrow;
    }
  }

  Future<bool> checkUserAlreadyExist(String idno, String email) async {
    final int idnoCount = (await FirebaseFirestore.instance
            .collection('users')
            .where('idno', isEqualTo: idno)
            .count()
            .get())
        .count;
    if (idnoCount != 0) return true;
    final int emailCount = (await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .count()
            .get())
        .count;
    if (emailCount != 0) return true;
    return false;
  }

  //addUserOnCall
  //curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/addUser -d '{"id":"123456","email":"amew@gmail.com","name":"陳阿喵","mobile":"0987654321","idno":"A123456789","emergentContactor":"陳旺旺","emergentContactTel":"0987654321","sexual":0,"address":"台北市中山區中山北路","birth":"2006-07-23","contactorRelationship":"pet","member":0}'
  Future<Map<String, dynamic>> addUser(Map<String, dynamic> args) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('createUser')
          .call(args);
      Map<String, dynamic> data = result.data;
      return data;
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      rethrow;
    }
  }

  //TODO
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

  Future<Map<String, dynamic>> getUserUseInstance(String userId) async {
    Map<String, dynamic>? data =
        (await FirebaseFirestore.instance.collection('users').doc(userId).get())
            .data();
    if (data == null) {
      throw Exception('not found');
    }
    return data;
  }

  Future updateUserUseInstance(String userId, Map<String, dynamic> args) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update(args);
  }

  //TODO
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
  Future<Map> addRegistration(Map<String, dynamic> args) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('createRegister')
          .call({
        "userId": args['userId'],
        "tripId": args['tripId'],
        "status": 0,
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
          .httpsCallable('getUserRegisters')
          .call({'userId': userId});
      return List<Map<String, dynamic>>.from(
          jsonDecode(jsonEncode(result.data)));
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      rethrow;
    }
  }

  //使用Firebase firestore
  Future<List<Registration>> getRegistrations(
      {String? userId, String? tripId}) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('register')
          .where(
            'userId',
            isEqualTo: userId,
          )
          .where(
            'tripId',
            isEqualTo: tripId,
          )
          .get();
      return List<Map<String, dynamic>>.from(
              result.docs.map((e) => e.data()).toList())
          .map((e) => Registration.fromJson(e))
          .toList();
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      rethrow;
    }
  }

  //TODO today
  //updateRegistration
  /*
  {
    userId: string,
    status: number,
    paymentInfo: Payment
}
   */
  Future<List<Map<String, dynamic>>> updateRegistration(
      Map<String, dynamic> args) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('updateRegister')
          .call({
        'registerId': args['registerId'],
        'status': args['status'],
        'paymentInfo': args['paymentInfo'], //Map
      });
      List data = result.data;
      return List<Map<String, dynamic>>.from(data);
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      rethrow;
    }
  }

  Future confirmPayUseAPI(String userId, String tripId, int? status) async {
    try {
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
          (await FirebaseFirestore.instance
                  .collection('register')
                  .where(
                    'userId',
                    isEqualTo: userId,
                  )
                  .where(
                    'tripId',
                    isEqualTo: tripId,
                  )
                  .limit(1)
                  .get())
              .docs;

      if (docs.isEmpty) {
        throw Exception('no document exist');
      }
      String docId = docs[0].id;
      final newData = {
        'registerId': docId,
        'status': status,
        'paymentInfo': docs[0].data()['paymentInfo'],
      };
      await updateRegistration(newData);
    } on FirebaseException catch (error) {
      print(error.code);
      print(error.message);
      rethrow;
    }
  }

  Future confirmPayUseInstance(
      String userId, String tripId, int? status) async {
    try {
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
          (await FirebaseFirestore.instance
                  .collection('register')
                  .where(
                    'userId',
                    isEqualTo: userId,
                  )
                  .where(
                    'tripId',
                    isEqualTo: tripId,
                  )
                  .limit(1)
                  .get())
              .docs;

      if (docs.isEmpty) {
        throw Exception('no document exist');
      }
      await docs[0].reference.update({
        'status': status,
      });
    } on FirebaseException catch (error) {
      print(error.code);
      print(error.message);
      rethrow;
    }
  }

  Future updateRegistrationUseInstance(
      String userId, String tripId, Map<String, dynamic> args) async {
    try {
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
          (await FirebaseFirestore.instance
                  .collection('register')
                  .where(
                    'userId',
                    isEqualTo: userId,
                  )
                  .where(
                    'tripId',
                    isEqualTo: tripId,
                  )
                  .limit(1)
                  .get())
              .docs;

      if (docs.isEmpty) {
        throw Exception('no document exist');
      }
      await docs[0].reference.update({
        'status': args['status'],
        'paymentInfo': args['paymentInfo'],
      });
    } on FirebaseException catch (error) {
      print(error.code);
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
      map['tripId'] = result.id;
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
