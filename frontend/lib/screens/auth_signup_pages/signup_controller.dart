import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/models/user_model.dart';
import 'package:tripflutter/modules/hike_repository.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../modules/auth_service.dart';

class SignUpController extends GetxController {
  final FirebaseAuthService _firebaseAuthService =
      Get.find<FirebaseAuthService>();
  final Rx<int> steps = Rx<int>(0);
  final RxBool nextStepsBtnStatus = false.obs;
  final BackendRepository repository = BackendRepository();
  final ScrollController scrollController = ScrollController();

  init() {
    print('SignUp Page init');
    steps.value = 0;
    step0CheckedStates.assignAll([
      TermsCheckState(0)..isShowed = true,
      TermsCheckState(1)..checked,
      TermsCheckState(2)..checked,
      TermsCheckState(3)..checked,
    ]);

    step1CheckedStates.assignAll([
      TermsCheckState(0),
      TermsCheckState(1),
      TermsCheckState(2),
    ]);
  }

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
      signUp(formData.email!, formData.password!, formData);
    }
    if (steps.value < 2) {
      steps.value = steps.value + 1;
      scrollController.jumpTo(140);
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
  ]);

  step1CheckCallback(int tapIndex) {
    step1CheckedStates[tapIndex].checked =
        !step1CheckedStates[tapIndex].checked;
    step1CheckedStates.refresh();
    checkNextStepStatus();
  }

  step1SelectCallback(int tapIndex) {
    for (int i = 0; i < 3; i++) {
      step0CheckedStates[i].isShowed = false;
    }
    step0CheckedStates[tapIndex].isShowed = true;
    step0CheckedStates.refresh();
  }

  //step2
  goToMailer() async {
    try {
      await launchUrlString('https://mail.google.com/mail');
    } catch (e) {
      print(e);
    }
  }

  //註冊
  signUp(String? email, String? password, FormData formData) async {
    if (email == null || email.isEmpty) {
      Get.snackbar('Error', 'No email provided for update.');
      return;
    }
    if (password == null || password.isEmpty) {
      Get.snackbar('Error', 'No email provided for update.');
      return;
    }
    await _firebaseAuthService.signUpWithEmailAndPassword(email, password);
    String url = "${AppLinks.SCHEDUL}${AppLinks.DETAIL}?id=$eventId";
    await _firebaseAuthService.sendEmailVerification(url); //TODO change later

    await newUserData(formData);
  }

  newUserData(FormData formData) async {
    Map<String, dynamic> args = {};
    Map<String, dynamic> data = formData.toUserJson();
    final user = UserModel.fromJson(data);
    user.userId = _firebaseAuthService.user.value?.uid;
    user.membership = 0;
    args = user.toJson();
    await repository.addUser(args);
  }

  sendEmail() async {
    await _firebaseAuthService.sendEmailVerification(
        "${AppLinks.SCHEDUL}${AppLinks.DETAIL}?id=$eventId"); //TODO change later
  }

  String? eventId;

  @override
  void onInit() {
    dynamic arg = Get.arguments;
    eventId = arg;
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

class TermsCheckState {
  final int index;
  bool checked = false;
  bool isShowed = false;
  TermsCheckState(this.index);
}

class FormData {
  String? email; //	信箱帳號
  String? password;
  String? idno; //	身份證號	base64
  String? userId; //	使用者 ID
  String? name; //	使用者姓名	base64
  String? mobile; //	手機號碼
  String? emergentContactor; //	緊急聯絡人姓名	base64
  String? emergentContactTel; //	緊急聯絡人電話
  String? contactorRelationship; //	緊急聯絡人關係
  int? sexual; //	性別
  String? address; //	地址
  String? birth; //	出生日期
  int? membership; //	會員狀態	分成 訪客 ＆ 正式會員
  String? createDate; //	註冊日期
  String? updateDate; //	更新日期
  Map? agreements; //	閱讀條款統一狀態	Map{}

  @override
  String toString() {
    return '$email, $password';
  }

  Map<String, dynamic> toUserJson() => <String, dynamic>{
        'idno': idno,
        'userId': userId,
        'email': email,
        'name': name,
        'mobile': mobile,
        'emergentContactor': emergentContactor,
        'emergentContactTel': emergentContactTel,
        'contactorRelationship': contactorRelationship,
        'sexual': idno![1] == '0' ? 0 : 1,
        'address': address,
        'birth': birth,
        'member': membership,
        'agreements': agreements,
      };
}
