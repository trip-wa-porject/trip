import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GpxController extends GetxController {
  //地圖圖層類別
  final Rxn<MapType> mapType = Rxn<MapType>(MapType.normal);

  final RxString distance = '0.0'.obs;
  final RxString totalTime = '0:00'.obs;
  final RxString speed = '0.0'.obs;

  //定位目前位置
  late void Function()? locationCallback;
  //量測起點終點距離
  late void Function()? routeDistanceCallback;

  changeMapType(MapType type) {
    mapType.value = type;
    mapType.refresh();
  }

  saveDistance(String value) {
    distance.value = value;
    distance.refresh();
  }

  saveTotalTime(String value) {
    totalTime.value = value;
    totalTime.refresh();
  }

  saveSpeed(String value) {
    speed.value = value;
    speed.refresh();
  }
}

enum MapWindowType { info, mapLayer, tools }
