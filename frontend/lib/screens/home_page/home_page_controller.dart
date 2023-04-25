import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/models/user_model.dart';

import '../../modules/auth_service.dart';

class HomePageController extends GetxController {
  final box = GetStorage();

  signOut() async {
    await box.remove('user');
    Get.find<FirebaseAuthService>().signOut();
    Get.offAndToNamed(AppLinks.LOGIN);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
