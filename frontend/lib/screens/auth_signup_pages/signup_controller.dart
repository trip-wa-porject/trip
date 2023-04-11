import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/auth_service.dart';

class SignUpController extends GetxController {
  final FirebaseAuthService _firebaseAuthService =
      Get.find<FirebaseAuthService>();
  final Rx<int> steps = Rx<int>(0);
  final RxBool nextStepsBtnStatus = false.obs;

  //檢查下一步是否可以按
  checkNextStepStatus() {
    if (steps.value == 0) {
      if (step0CheckedStates.every((element) => element.checked == true)) {
        nextStepsBtnStatus.value = true;
      } else {
        nextStepsBtnStatus.value = false;
      }
    } else if (steps.value == 1) {
      if (step1CheckedStates.every((element) => element.checked == true)) {
        nextStepsBtnStatus.value = true;
      } else {
        nextStepsBtnStatus.value = false;
      }
    }
  }

  nextStep() {
    if (steps.value == 1) {
      bool validate = formKey.currentState?.validate() ?? false;
      print(validate);
      if (!validate) {
        return;
      }
      formKey.currentState?.save();
      print(formData);
      signUp(formData.email!, formData.password!);
    }
    if (steps.value < 2) {
      steps.value = steps.value + 1;
    }
    checkNextStepStatus();
  }

  preStep() {
    if (steps.value > 0) {
      steps.value = steps.value - 1;
    }
    checkNextStepStatus();
  }

  //step 0
  final RxList<TermsCheckState> step0CheckedStates = RxList<TermsCheckState>([
    TermsCheckState(0)..isShowed = true,
    TermsCheckState(1)..checked,
    TermsCheckState(2)..checked,
    TermsCheckState(3)..checked,
  ]);

  step1SelectCallback(int tapIndex) {
    for (int i = 0; i < 4; i++) {
      step0CheckedStates[i].isShowed = false;
    }
    step0CheckedStates[tapIndex].isShowed = true;
    step0CheckedStates.refresh();
  }

  step0CheckCallback(int tapIndex) {
    step0CheckedStates[tapIndex].checked =
        !step0CheckedStates[tapIndex].checked;
    if (tapIndex < 3) {
      step1SelectCallback(tapIndex + 1);
    } else {
      step0CheckedStates.refresh();
    }
    checkNextStepStatus();
  }

  //step1
  final formKey = GlobalKey<FormState>();
  FormData formData = FormData();

  final RxList<TermsCheckState> step1CheckedStates = RxList<TermsCheckState>([
    TermsCheckState(0),
    TermsCheckState(1),
    TermsCheckState(2),
    TermsCheckState(3)
  ]);

  step1CheckCallback(int tapIndex) {
    step1CheckedStates[tapIndex].checked =
        !step1CheckedStates[tapIndex].checked;
    step1CheckedStates.refresh();
    checkNextStepStatus();
  }

  //註冊
  signUp(String email, String password) async {
    if (email == null || email.isEmpty) {
      Get.snackbar('Error', 'No email provided for update.');
      return;
    }
    if (password == null || password.isEmpty) {
      Get.snackbar('Error', 'No email provided for update.');
      return;
    }
    await _firebaseAuthService.signUpWithEmailAndPassword(email, password);
    await _firebaseAuthService.bindUserWithEmailLink(email, password);
    await _firebaseAuthService.sendEmailVerification();
  }

  sendEmail() async {
    await _firebaseAuthService.sendEmailVerification();
  }
}

class TermsCheckState {
  final int index;
  bool checked = false;
  bool isShowed = false;
  TermsCheckState(this.index);
}

class FormData {
  String? email;
  String? password;

  @override
  String toString() {
    return '$email, $password';
  }
}
