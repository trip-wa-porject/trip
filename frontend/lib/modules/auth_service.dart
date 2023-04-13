import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthenticationException implements Exception {}

//sign in error
//
class InvalidEmailException extends AuthenticationException {}

class PasswordExceptions extends AuthenticationException {}

class UserNotFoundException extends AuthenticationException {}

class UserDisabledException extends AuthenticationException {}

class UnknownAuthException extends AuthenticationException {}

//sign up error
class WeakPasswordException extends AuthenticationException {}

//sign in Anonymously
class OperationNotAllowedException extends AuthenticationException {}

//update email
class EmailAlreadyInUseException extends AuthenticationException {}

class RequiresRecentLoginException extends AuthenticationException {}

//ToDo 拋出錯誤
class FirebaseAuthService extends GetxService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_firebaseAuth.userChanges());
  }

  bool get isLogin =>
      _firebaseAuth.currentUser != null &&
      !_firebaseAuth.currentUser!.isAnonymous;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // **invalid-email**:
      // **user-disabled**:
      // **user-not-found**:
      // **wrong-password**:
      authErrorHandel(e);
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while trying to sign in.');
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      //weak-password
      //email-already-in-use
      authErrorHandel(e);
    } catch (e) {
      Get.snackbar(
          'Error', 'An error occurred while trying to create an account.');
    }
  }

  Future<void> signInAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      //**operation-not-allowed**
      authErrorHandel(e);
    }
  }

  Future<void> signInWithEmailLink(String email, String link) async {
    try {
      await _firebaseAuth.signInWithEmailLink(email: email, emailLink: link);
    } on FirebaseAuthException catch (e) {
      //**expired-action-code**
      //**invalid-email**:
      //**user-disabled**:
      // TODO
      authErrorHandel(e);
      Get.snackbar('Error',
          'An error occurred while trying to sign in with email link.');
    }
  }

  Future<void> signUpWithEmailLink(String email,
      [Map<String, String>? other]) async {
    try {
      String url = 'http://localhost:55088/login?email=$email';
      if (other != null) {
        other.entries.forEach((element) {});
      }
      await _firebaseAuth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          //TODO change here when deploy
          url: 'http://localhost:55088/login?email=$email',
          handleCodeInApp: true,
          // iOSBundleId: 'com.example.ios',
          // androidPackageName: 'com.example.android',
          // androidInstallApp: true,
          // androidMinimumVersion: '21',
        ),
      );
    } on FirebaseAuthException catch (e) {
      authErrorHandel(e);
    }
  }

  Future<void> bindUserWithEmailLink(String email, String link) async {
    try {
      AuthCredential credential = await EmailAuthProvider.credentialWithLink(
          email: email, emailLink: link);

      final User? _user = user.value;
      if (_user?.email != email) {
        print('bindUserWithEmailLink same email');
        //TODO error not same email
        throw UnknownAuthException();
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error',
          'An error occurred while trying to sign in with email link.');
    }
  }

  Future<void> bindUserWithEmailPassword(String email, String pwd) async {
    try {
      AuthCredential credential =
          await EmailAuthProvider.credential(email: email, password: pwd);

      final User? _user = user.value;
      if (_user == null) {
        throw UnknownAuthException();
      }
      if (_user?.email == email) {
        print('bindUserWithEmailLink same email');
        //TODO error not same email
        throw UnknownAuthException();
      }

      await _user.linkWithCredential(credential);
    } catch (e) {
      print(e);
      Get.snackbar('Error',
          'An error occurred while trying to sign in with email link.');
    }
  }

  //例如
  //
  sendEmailVerification(String? redirectPath) async {
    if (_firebaseAuth.currentUser == null) {
      return;
    }
    String baseUrl = '';
    if (kDebugMode) {
      baseUrl = 'http://localhost:55088';
    } else {
      baseUrl = 'https://wa-project-mountain.web.app/#/';
    }
    ActionCodeSettings? settings;
    try {
      if (redirectPath != null) {
        settings = ActionCodeSettings(url: '$baseUrl$redirectPath');
      }
      await _firebaseAuth.currentUser!.sendEmailVerification(settings);
    } on FirebaseAuthException catch (e) {
      authErrorHandel(e);
    }
  }

  updateUserEmail(String email) async {
    if (_firebaseAuth.currentUser == null) {
      return;
    }
    try {
      await _firebaseAuth.currentUser!.updateEmail(email);
    } on FirebaseAuthException catch (e) {
      authErrorHandel(e);
    }
  }

  authErrorHandel(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-email":
        //Thrown if the email address is not valid.
        throw InvalidEmailException();
      case "user-disabled":
        //Thrown if the user corresponding to the given email has been disabled.
        throw UserDisabledException();
      case "user-not-found":
        //Thrown if there is no user corresponding to the given email.
        throw UserNotFoundException();
      case "wrong-password":
        throw PasswordExceptions();
      //Thrown if the password is invalid for the given email, or the account corresponding to the email does not have a password set.
      case "operation-not-allowed":
        throw OperationNotAllowedException();
      //Thrown if anonymous accounts are not enabled. Enable anonymous accounts in the Firebase Console, under the Auth tab.
      case "email-already-in-use":
        throw EmailAlreadyInUseException();
      //Thrown if the email is already used by another user.
      case "requires-recent-login":
        throw RequiresRecentLoginException();
      //Thrown if the user's last sign-in time does not meet the security threshold. Use User.reauthenticateWithCredential to resolve. This does not apply if the user is anonymous.
      case "weak-password":
        throw WeakPasswordException();
      default:
        throw UnknownAuthException();
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
