import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/auth_service.dart';
import '../../modules/home_controller.dart';

class LoginController extends GetxController {
  final FirebaseAuthService _firebaseAuthService =
      Get.find<FirebaseAuthService>();
  final formKey = GlobalKey<FormState>();

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
      Get.back(result: user);
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
    Get.toNamed('/signup', arguments: path);
  }

  forgetPassword() {}

  String? path;
  @override
  void onInit() {
    path = Get.arguments;
    super.onInit();
  }
}
