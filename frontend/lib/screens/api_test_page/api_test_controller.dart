import 'package:get/get.dart';
import 'package:tripflutter/modules/hike_repository.dart';

class ApiTestController extends GetxController {
  RxString response = ''.obs;
  final BackendRepository repository = BackendRepository();

  testSearchTrips1() async {
    // List<Map<String, dynamic>> result = await repository.fetchTrip({});
  }

  testSearchTrips2() async {}

  testSearchTrip() async {}

  testCreateUser() async {}
}
