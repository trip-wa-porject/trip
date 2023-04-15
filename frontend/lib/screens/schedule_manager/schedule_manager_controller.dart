import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/models/registration.dart';
import 'package:tripflutter/modules/hike_repository.dart';
import 'package:tripflutter/screens/auth_login_pages/login_dialog.dart';
import '../../models/schedule_model.dart';
import '../../modules/auth_service.dart';
import '../../modules/home_controller.dart';

class ScheduleManagerController extends GetxController {
  final FirebaseAuthService _firebaseAuthService =
      Get.find<FirebaseAuthService>(); //TODO 思考一下需要放嗎
  final BackendRepository repository = BackendRepository();

  RxList<Registration> userJoinedModel = RxList<Registration>([]);

  goToPayPage(String eventId) {
    Get.toNamed(
        '${AppLinks.SCHEDUL}${AppLinks.DETAIL}${AppLinks.PAY}?id=$eventId');
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
    String? userId = user?.uid;
    if (userId == null) {
      userJoinedModel.assignAll([]);
    } else {
      List<Map<String, dynamic>> data =
          await repository.getUserAllTrips(userId);
      List<Registration> models =
          data.map((e) => Registration.fromJson(e)).toList();
      userJoinedModel.assignAll(models);
      print(models);
    }
  }

  checkEachItem() {}

  @override
  void onInit() {
    debounce(_firebaseAuthService.user, getDataUserJoined, time: 3.seconds);
    super.onInit();
  }
}
