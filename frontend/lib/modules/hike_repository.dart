import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class TripException implements Exception {}

class InvalidSearchKeysException extends TripException {}

class UserException implements Exception {}

class InvalidUserArgumentsException extends UserException {}

class UserExistedException extends UserException {}

class CreateUserUnknownException extends UserException {}

class UserNotExistException extends UserException {}

class GetUserRegisterInvalidArgumentsException extends UserException {}

class UserNotFoundException extends UserException {}

class RegistrationException implements Exception {}

class InvalidRegisterArgumentsException extends RegistrationException {}

class TripOrUserNotExistException extends RegistrationException {}

class TripOrUserNotFoundException extends RegistrationException {}

class CreateRegisterUnknownException extends RegistrationException {}

class UpdateRegisterInvalidArgumentsException extends RegistrationException {}

class StatusNotAllowedException extends RegistrationException {}

class RegisterNotExistException extends RegistrationException {}

class RegisterStatusNotAllowedToChangeException extends RegistrationException {}

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
      if (error.message == 'invalid search keys') {
        throw InvalidSearchKeysException();
      }
      rethrow;
    }
  }

  //addUserOnCall
  //curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/addUser -d '{"id":"123456","email":"amew@gmail.com","name":"陳阿喵","mobile":"0987654321","idno":"A123456789","emergentContactor":"陳旺旺","emergentContactTel":"0987654321","sexual":0,"address":"台北市中山區中山北路","birth":"2006-07-23","contactorRelationship":"pet","member":0}'
  Future<Map<String, dynamic>> addUser(Map<String, dynamic> args) async {
    try {
      // print(args); // 嘗試用flutter cloud-firestore
      // CollectionReference users = FirebaseFirestore.instance.collection('users');
      // final result = await users.add(args)
      //     .then((value) => print("User Added: ${args['userId']}"))
      //     .catchError((error) => print("Failed to add user: $error"));

      final result = await FirebaseFunctions.instance
          .httpsCallable('createUser')
          .call(args);
      Map<String, dynamic> data = result.data;
      return data;
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      if (error.message == 'These keys need complemnet') {
        throw InvalidUserArgumentsException();
      } else if (error.message == 'This idno or email already exist') {
        throw UserExistedException();
      } else if (error.message == 'Server error') {
        throw CreateUserUnknownException();
      }
      rethrow;
    }
  }

  //TODO
  //getUserOnCall
  //curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/getUser -d '{"id":"123456"}'
  Future<List<Map<String, dynamic>>> getUser(Map<String, dynamic> args) async {
    try {
      // 嘗試用flutter cloud-firestore
      // CollectionReference users = FirebaseFirestore.instance.collection('users');
      // final result = await users.doc(args['userId']).get()
      //     .then((snapshot) => snapshot.data())
      //     .catchError((error) => print("Failed to find user: $error"));

      final result = await FirebaseFunctions.instance
          .httpsCallable('getUserOnCall')
          .call(args);
      List data = result.data;
      return List<Map<String, dynamic>>.from(data);
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      if (error.message == 'This user doesn\'t exist') {
        throw UserNotExistException();
      }
      rethrow;
    }
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
      // 嘗試用flutter cloud-firestore
      // CollectionReference registers = FirebaseFirestore.instance.collection('registers');
      // final result = await registers.add({
      //         "userId": args['userId'],
      //         "tripId": args['tripId'],
      //         "status": 0,
      //         "price": args['price'],
      //         "paymentExpireDate": args['paymentExpireDate'],
      //         "paymentInfo": args['paymentInfo'],
      //       })
      //     .then((value) => print("Register Added: ${args['userId']}"))
      //     .catchError((error) => print("Failed to add register: $error"));
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
      if (error.message == 'Not enough information') {
        throw InvalidRegisterArgumentsException();
      } else if (error.message == 'Trip or User doesn\'t exist') {
        throw TripOrUserNotExistException();
      } else if (error.message == 'tripId or userId not found') {
        throw TripOrUserNotFoundException();
      } else if (error.message == 'Server error') {
        throw CreateRegisterUnknownException();
      }
      rethrow;
    }
  }

  //getUserAllTrips
  //查詢單一會員所有行程：
  //curl -k -H "Content-Type:application/json" http://127.0.0.1:5001/trip-b6ddf/us-central1/getUserAllTrips -d '{"userId":"123456"}'
  Future<List<Map<String, dynamic>>> getUserAllTrips(String userId) async {
    try {
      // 測試改用flutter cloud-firestore
      // final userAdded = await users.doc(args['userId']).get()
      //     .then((snapshot) => snapshot.data())
      //     .catchError((error) => print("Failed to find user: $error"));
      final result = await FirebaseFunctions.instance
          .httpsCallable('getUserRegisters')
          .call({'userId': userId});
      return List<Map<String, dynamic>>.from(
          jsonDecode(jsonEncode(result.data)));
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      if (error.message == 'Not enough information') {
        throw GetUserRegisterInvalidArgumentsException();
      } else if (error.message == 'User not found') {
        throw UserNotFoundException();
      }
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
        'userId': args['userId'],
        'status': args['status'],
        'paymentInfo': args['paymentInfo'], //Map
      });
      List data = result.data;
      return List<Map<String, dynamic>>.from(data);
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      if (error.message == 'Not enough information') {
        throw UpdateRegisterInvalidArgumentsException();
      } else if (error.message == 'status not allowed') {
        throw StatusNotAllowedException();
      } else if (error.message == 'Register doesn\'t exist') {
        throw RegisterNotExistException();
      } else if (error.message == 'register status not allowed to change') {
        throw RegisterStatusNotAllowedToChangeException();
      }
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
