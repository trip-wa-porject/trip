import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/screens/auth_signup_pages/signup_controller.dart';

import '../../modules/auth_service.dart';
import '../../modules/home_controller.dart';

class LoginController extends GetxController {
  final FirebaseAuthService _firebaseAuthService =
      Get.find<FirebaseAuthService>();
  final formKey = GlobalKey<FormState>();
  final box = GetStorage();

  final RxBool isLoading = false.obs;
  final RxString email = ''.obs;
  final Rxn<String> emailError = Rxn<String>();

  final RxString password = ''.obs;
  final Rxn<String> passwordError = Rxn<String>();

  loginEvent(String email, String password) async {
    bool validate = formKey.currentState?.validate() ?? false;
    print(validate);
    if (!validate) {
      return null;
    }
    this.email.value = email;
    this.password.value = password;
    emailError.value = null;
    passwordError.value = null;
    //loading status
    isLoading.value = true;
    User? user = await login();
    isLoading.value = false;
    if (user != null) {
      await box.write('user', user.uid);
      if (kIsWeb) {
        Get.back(result: user);
      } else {
        Get.offAndToNamed(AppLinks.HOME);
      }
    }
  }

  Future<User?> login() async {
    try {
      String _email = email.value;
      String _password = password.value;
      if (_email.isEmpty) {
        emailError.value = 'invalid email';
        return null;
      }
      if (_password.isEmpty) {
        passwordError.value = '請輸入密碼';
        return null;
      }

      await _firebaseAuthService.signInWithEmailAndPassword(_email, _password);
      return _firebaseAuthService.user.value;
    } on AuthenticationException catch (e) {
      if (e is InvalidEmailException) {
        emailError.value = 'email 格式錯誤';
      } else if (e is PasswordExceptions) {
        passwordError.value = '密碼錯誤';
      } else if (e is UserNotFoundException) {
        emailError.value = '此email未註冊';
      } else if (e is UserDisabledException) {
        emailError.value = '此email已停用';
      } else if (e is UnknownAuthException) {
        emailError.value = 'Unknown error';
      }
    }
  }

  signup() async {
    if (_firebaseAuthService.user.value == null) {
      // await _firebaseAuthService.signInAnonymously();
    }

    Get.toNamed('${AppLinks.SIGNUP}', arguments: path);
  }

  forgetPassword() {}

  checkLogin() {
    try {
      isLoading.value = true;
      dynamic user = box.read('user');
      if (user != null) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Get.offAndToNamed(AppLinks.HOME);
        });
      }
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  String? path;
  @override
  void onInit() {
    path = Get.arguments;
    if (!kIsWeb) {
      checkLogin(); // mobile
    }
    super.onInit();
  }
}
