import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'auth_service.dart';
import 'hike_repository.dart';

class HomeController extends GetxController {
  final FirebaseAuthService _firebaseAuthService =
      Get.find<FirebaseAuthService>();
  final BackendRepository repository = BackendRepository();

  Future<void> handleEmailAndPasswordSignIn(
      String email, String password) async {
    await _firebaseAuthService.signInWithEmailAndPassword(email, password);
  }

  Future<void> handleEmailAndPasswordSignUp(
      String email, String password) async {
    await _firebaseAuthService.signUpWithEmailAndPassword(email, password);
  }

  Future<void> handleAnonymousSignIn() async {
    await _firebaseAuthService.signInAnonymously();
    final User? user = _firebaseAuthService.user.value;
    if (user != null) {
      //todo update data
      await repository.updateUserDocument(user.uid, {});
    }

    Get.snackbar('Success signInAnonymously',
        ' user: ${_firebaseAuthService.user.value?.uid}. email: ${_firebaseAuthService.user.value?.email}');
  }

  Future<void> updateUserData(String email) async {
    //TODO send email link
    if (email == null || email.isEmpty) {
      Get.snackbar('Error', 'No email provided for update.');
      return;
    }
    await _firebaseAuthService.updateUserEmail(email);
    Get.snackbar('update email',
        ' user: ${_firebaseAuthService.user.value?.uid}. email: ${_firebaseAuthService.user.value?.email}');

    await _firebaseAuthService.signUpWithEmailLink(email);
    Get.snackbar('Success', 'Sign-up link sent to $email.');
  }

  //TODO delete
  Future<void> handleLinkSignUp(String? email) async {
    final User? user = _firebaseAuthService.user.value;

    if (user == null) {
      if (email == null || email.isEmpty) {
        Get.snackbar('Error', 'No email provided for sign-up with email link.');
        return;
      }

      await _firebaseAuthService.signUpWithEmailLink(email);
      Get.snackbar('Success', 'Sign-up link sent to $email.');
    } else {
      Get.snackbar('Error', 'You are already signed in with ${user.email}.');
    }
  }

  Future<void> handleLinkSignIn(Uri link) async {
    final String? email = link.queryParameters['email'];

    if (email != null && email.isNotEmpty) {
      await _firebaseAuthService.signInWithEmailLink(email, link.toString());
      Get.offNamed('/home');
    } else {
      Get.snackbar('Error', 'Invalid sign-in link.');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuthService.signOut();
  }
}
