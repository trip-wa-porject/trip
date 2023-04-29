import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/models/registration.dart';
import 'package:tripflutter/modules/hike_repository.dart';
import 'package:tripflutter/screens/auth_login_pages/login_dialog.dart';
import '../../models/gpx_model.dart';
import '../../models/schedule_model.dart';
import '../../modules/auth_service.dart';
import '../../modules/home_controller.dart';

class ScheduleManagerController extends GetxController
    with GetTickerProviderStateMixin {
  final FirebaseAuthService _firebaseAuthService =
      Get.find<FirebaseAuthService>(); //TODO 思考一下需要放嗎
  final BackendRepository repository = BackendRepository();
  final box = GetStorage();

  RxList<ScheduleModel> scheduleList = <ScheduleModel>[].obs; //推薦行程
  RxBool isLoading = false.obs;
  RxList<Registration> userJoinedModel = RxList<Registration>([]);
  RxList<GPXModel> downloadedGpx = RxList<GPXModel>();
  RxList<ScheduleModel> downloadedTrips = RxList<ScheduleModel>();

  RxInt selectedIndex = 0.obs;
  late TabController tabController;
  int? tabLength;

  //取消報名
  Future<void> cancelRegister(Registration? registration) async {
    try {
      isLoading.value = true;
      if (registration == null) {
        throw Exception('no input');
      }
      String? userId = registration.userId;
      String? tripId = registration.tripId;
      if (userId == null || tripId == null) {
        throw Exception('no input');
      }
      await repository.updateRegistrationUseInstance(userId, tripId, {
        'status': 3,
        'paymentInfo': {}, //Map
      });
      await .5.delay();
      await getDataUserJoined(_firebaseAuthService.user.value);
    } catch (e) {
      //Todo
      print(e);
    }
  }

  //重新報名
  retryRegister(Registration? registration) async {
    try {
      isLoading.value = true;
      if (registration == null) {
        throw Exception('no input');
      }
      String? userId = registration.userId;
      String? tripId = registration.tripId;
      if (userId == null || tripId == null) {
        throw Exception('no input');
      }
      await repository.updateRegistrationUseInstance(userId, tripId, {
        'status': 0,
        'paymentInfo': {}, //Map
      });
      await .5.delay();
      await getDataUserJoined(_firebaseAuthService.user.value);
    } catch (e) {
      //Todo
      print(e);
    }
  }

  //繼續付款
  goToPayPage(String eventId) {
    Get.toNamed(
        '${AppLinks.SCHEDUL}${AppLinks.DETAIL}${AppLinks.PAY}?id=$eventId');
  }

  //查看行程
  goToDetailPage(String eventId) {
    Get.toNamed('${AppLinks.SCHEDUL}${AppLinks.DETAIL}?id=$eventId');
  }

  confirmPay(
      Registration? registration, Map<String, dynamic> paymentInfo) async {
    try {
      if (registration == null) {
        throw Exception('no input');
      }
      String? userId = registration.userId;
      String? tripId = registration.tripId;
      if (userId == null || tripId == null) {
        throw Exception('no input');
      }
      await repository.updateRegistrationUseInstance(userId, tripId, {
        'status': 1,
        'paymentInfo': paymentInfo, //Map
      });
      await .5.delay();
      await getDataUserJoined(_firebaseAuthService.user.value);
    } catch (e) {
      //Todo
      print(e);
    }
  }

  Future joinNewEvent(String eventId, ScheduleModel model) async {
    print(_firebaseAuthService.user.value);
    User? user = _firebaseAuthService.user.value;
    if (user == null || user.isAnonymous) {
      //未登入的user
      final result = await Get.dialog(const LoginDialog(), arguments: eventId);
      if (result is User) {
        User? user = _firebaseAuthService.user.value;
        if (user == null || user.isAnonymous) return;
        await _joinNewEvent(user, eventId, model);
      }
    } else {
      await _joinNewEvent(user, eventId, model);
    }
  }

  _joinNewEvent(User user, String eventId, ScheduleModel model) async {
    Map<String, dynamic> data = {
      "userId": user.uid,
      "tripId": eventId,
      "price": model.price,
      "paymentExpireDate":
          DateTime.now().add(Duration(days: 3)).millisecondsSinceEpoch,
      "paymentInfo": {},
    };

    await repository.addRegistration(data); //TODO
    //加入活動成功
    getDataUserJoined(user);

    await Get.toNamed(
        '${AppLinks.SCHEDUL}${AppLinks.DETAIL}${AppLinks.PAY}?id=$eventId');
  }

  getDataUserJoined(User? user) async {
    try {
      isLoading.value = true;
      String? userId = user?.uid;
      if (userId == null) {
        userJoinedModel.assignAll([]);
      } else {
        List<Map<String, dynamic>> data =
            await repository.getUserAllTrips(userId);
        List<Registration> models =
            data.map((e) => Registration.fromJson(e)).toList();
        await Future.wait(models.map((e) => getTripData(e)));
        userJoinedModel.assignAll(models.toList());
      }
    } catch (e) {
      print('getDataUserJoined error :$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTripData(Registration registration) async {
    registration.scheduleModel = await getOneTripData(registration.tripId);
  }

  Future<ScheduleModel?> getOneTripData(String? tripId) async {
    if (tripId == null || tripId == '') return null;
    List<ScheduleModel> trips = await getAllTripDataFromLocal();
    ScheduleModel? trip =
        trips.firstWhereOrNull((element) => element.id == tripId);
    if (trip != null) {
      return trip;
    }
    Map<String, dynamic>? data = await repository.getOneTrip(tripId);
    if (data != null) {
      return ScheduleModel.fromJson(data);
    }
    return null;
  }

  checkEachItem() {}

  _handleTabSelection() {
    if (tabController.indexIsChanging) {
      final index = tabController.index;
      selectedIndex.value = index;
    }
  }

  downloadGPX(ScheduleModel model) async {
    String gpxData =
        await DefaultAssetBundle.of(Get.context!).loadString('assets/gpx.txt');
    final GPXModel gpxModel = GPXModel(
      model.id,
      gpxData,
    );
    List<ScheduleModel> trips = await getAllTripDataFromLocal();
    if (!trips.any((element) => element.id == model.id)) {
      trips.add(model);
      await box.write(
          'trips', trips.map((e) => jsonEncode(e.toJson())).toList());
    }
    List<GPXModel> gpxs = await getAllGPXDataFromLocal();
    if (!gpxs.any((element) => element.tripId == gpxModel.tripId)) {
      gpxs.add(gpxModel);
      await box.write(
          'gpxModels', gpxs.map((e) => jsonEncode(e.toJson())).toList());
    }
    downloadedGpx.assignAll(gpxs.toList());
  }

  Future<List<ScheduleModel>> getAllTripDataFromLocal() async {
    List<ScheduleModel> trips = List<String>.from((box.read('trips') ?? []))
        .map((e) => ScheduleModel.fromJson(jsonDecode(e)))
        .toList();
    return trips;
  }

  Future<List<GPXModel>> getAllGPXDataFromLocal() async {
    List<GPXModel> gpxModels = List<String>.from(box.read('gpxModels') ?? [])
        .map((e) => GPXModel.fromJson(jsonDecode(e)))
        .toList();
    return gpxModels;
  }

  init() async {
    List<GPXModel> gpxModels = await getAllGPXDataFromLocal();
    downloadedGpx.assignAll(gpxModels);
    List<ScheduleModel> trips = await getAllTripDataFromLocal();
    downloadedTrips.assignAll(trips);

    try {
      Map<String, dynamic> result = await repository.fetchTrip({});

      List<dynamic> schduleData = result['results'];
      List<ScheduleModel> list =
          schduleData.map((e) => ScheduleModel.fromJson(e)).toList();
      list = list
          .where((model) => (model.limitation - model.applicants.length) > 0)
          .toList();
      if (list.length > 3) {
        scheduleList.assignAll(list.sublist(0, 3));
      } else {
        scheduleList.assignAll(list);
      }
    } catch (e) {
      //todo
    }
  }

  setTabController(int length) {
    if (tabLength == null || tabLength != length) {
      tabLength = length;
      tabController = TabController(length: length, vsync: this);
      tabController.addListener(_handleTabSelection);
    }
  }

  @override
  void onInit() {
    debounce(_firebaseAuthService.user, getDataUserJoined, time: 3.seconds);
    ever(userJoinedModel, (callback) {
      print('userJoinedModel change: callback:$callback');
    });
    init();
    super.onInit();
  }
}
