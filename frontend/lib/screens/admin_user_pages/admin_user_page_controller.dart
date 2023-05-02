import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/models/user_model.dart';
import 'package:tripflutter/modules/hike_repository.dart';

import '../../modules/auth_service.dart';

class AdminUserPageController extends GetxController {
  final FirebaseAuthService _firebaseAuthService =
      Get.find<FirebaseAuthService>();
  final BackendRepository repository = BackendRepository();
  final Rx<UserModel?> userModel = Rx<UserModel?>(null);

  checkIsAdminUser(User? user) async {
    try {
      if (user != null) {
        Map<String, dynamic> data =
            await repository.getUserUseInstance(user.uid);
        UserModel _userModel = UserModel.fromJson(data);
        if (_userModel.isAdminUser) {
          userModel.value = _userModel;
          Get.offAllNamed(AppLinks.ADMIN);
        }
      } else {
        userModel.value = null;
      }
    } catch (e) {
      userModel.value = null;
    }
  }

  signOutAdmin() async {
    final result = await Get.defaultDialog(
      title: '退出',
      middleText: '確認要退出管理模式？',
      onConfirm: () => Get.back(result: true),
      onCancel: () => Get.back(result: false),
    );
    if (result == true) {
      await _firebaseAuthService.signOut();
      Get.toNamed('${AppLinks.SCHEDUL}');
    }
  }

  Future confirmPayment(String userId, String tripId) async {
    final result = await Get.defaultDialog(
      title: '付款確認',
      middleText: '已確認這筆資料付款資訊',
      onConfirm: () => Get.back(result: true),
      onCancel: () => Get.back(result: false),
    );
    if (result) {
      await repository.confirmPayUseInstance(userId, tripId, 1);
    }
  }

  @override
  void onInit() {
    debounce(_firebaseAuthService.user, checkIsAdminUser,
        time: const Duration(milliseconds: 200));

    super.onInit();
  }
}
