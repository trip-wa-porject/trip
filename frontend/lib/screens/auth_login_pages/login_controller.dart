import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../modules/auth_service.dart';
import '../../modules/home_controller.dart';

class LoginController extends GetxController {
  final FirebaseAuthService _firebaseAuthService =
      Get.find<FirebaseAuthService>();
  final HomeController _homeController = Get.find<HomeController>();

  final RxBool isLoading = false.obs;
  final RxString email = ''.obs;
  final RxString emailError = ''.obs;

  final RxString password = ''.obs;
  final RxString passwordError = ''.obs;

  loginEvent(String email, String password) async {
    this.email.value = email;
    this.password.value = password;
    emailError.value = '';
    passwordError.value = '';
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
        emailError.value = 'invalid email';
      } else if (e is PasswordExceptions) {
        passwordError.value = 'wrong password';
      } else if (e is UserNotFoundException) {
        emailError.value = 'user not found';
      } else if (e is UserDisabledException) {
        emailError.value = 'user disabled';
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
