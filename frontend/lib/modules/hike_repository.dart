import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class GeneralRepository {}

class BackendRepository implements GeneralRepository {
  Future<List<Map<String, dynamic>>> fetchTrip(Map<String, dynamic> args) async {
  var queries = '';
  args.forEach((k, v) => queries += '&${k}=${v}');

  final response = await http
      .get(Uri.parse('http://127.0.0.1:5001/mountain-climb-b03b9/us-central1/searchTrips?${queries}'));

  Map json = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return json['result'].cast<Map<String, dynamic>>() as List<Map<String, dynamic>>;
  } else {
    throw Exception('Failed to load trip');
  }
}
}
