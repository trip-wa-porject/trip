import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/auth_service.dart';

class SignUpController extends GetxController {
  final FirebaseAuthService _firebaseAuthService =
      Get.find<FirebaseAuthService>();
  final Rx<int> steps = Rx<int>(0);
  final RxBool nextStepsBtnStatus = false.obs;
  final RxList<TermsCheckState> checkedStates = RxList<TermsCheckState>([
    TermsCheckState(0)..isShowed = true,
    TermsCheckState(1),
    TermsCheckState(2),
    TermsCheckState(3)
  ]);

  step1SelectCallback(int tapIndex) {
    for (int i = 0; i < 4; i++) {
      checkedStates[i].isShowed = false;
    }
    checkedStates[tapIndex].isShowed = true;
    checkedStates.refresh();
  }

  step1CheckCallback(int tapIndex) {
    checkedStates[tapIndex].checked = !checkedStates[tapIndex].checked;
    if (tapIndex < 3) {
      step1SelectCallback(tapIndex + 1);
    } else {
      checkedStates.refresh();
    }
    checkAllChecked();
  }

  checkAllChecked() {
    if (checkedStates.every((element) => element.checked == true)) {
      if (steps.value == 0) {
        nextStepsBtnStatus.value = true;
      }
    }
  }

  nextStep() {
    if (steps < 2) {
      steps.value = steps.value + 1;
    }
  }

  preStep() {
    if (steps > 0) {
      steps.value = steps.value - 1;
    }
  }

  signUp(String email, String password) async {
    if (email == null || email.isEmpty) {
      Get.snackbar('Error', 'No email provided for update.');
      return;
    }
    if (password == null || password.isEmpty) {
      Get.snackbar('Error', 'No email provided for update.');
      return;
    }
    // await _firebaseAuthService.updateUserEmail(email); //更新訪客email

    await _firebaseAuthService.signUpWithEmailAndPassword(email, password);
    await _firebaseAuthService.bindUserWithEmailLink(email, password);

    await Get.dialog(
      Material(
        child: Center(
          child: Card(
            child: Text('請去點擊會員驗證信件'),
          ),
        ),
      ),
    );
  }
}

class TermsCheckState {
  final int index;
  bool checked = false;
  bool isShowed = false;
  TermsCheckState(this.index);
}
