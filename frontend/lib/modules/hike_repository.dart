import 'dart:async';
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
}
