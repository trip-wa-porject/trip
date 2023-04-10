import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/modules/hike_repository.dart';
import 'package:tripflutter/screens/auth_login_pages/login_dialog.dart';
import '../../modules/auth_service.dart';
import '../../modules/home_controller.dart';

class ScheduleManagerController extends GetxController {
  final FirebaseAuthService _firebaseAuthService =
      Get.find<FirebaseAuthService>(); //TODO 思考一下需要放嗎
  final BackendRepository repository = BackendRepository();

  final HomeController _homeController = Get.find<HomeController>();

  joinNewEvent(String eventId) async {
    print(_firebaseAuthService.user.value);
    User? user = _firebaseAuthService.user.value;
    if (user == null || user.isAnonymous) {
      //未登入的user
      await Get.dialog(const LoginDialog());
    } else {
      await repository.attendTrip(user.uid, eventId);
      // Get.snackbar('user：${user.email} ${user.uid} 加入行程', ' ${eventId}！');
      //加入活動成功
      Get.defaultDialog(
        title: '活動報名成功！',
        content: Text(
          'user：${user.email} ${user.uid} 加入行程 ${eventId},\n請在三日內繳款',
        ),
        custom: Text('custom'),
      );
    }
  }

  checkEachItem() {}
}
