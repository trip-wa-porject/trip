import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/models/user_model.dart';
import 'package:tripflutter/modules/hike_repository.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../models/zipcode_model.dart';
import '../../modules/auth_service.dart';

import 'package:flutter/services.dart'; // is required

class SignUpController extends GetxController {
  final FirebaseAuthService _firebaseAuthService =
      Get.find<FirebaseAuthService>();
  final Rx<int> steps = Rx<int>(0);
  final RxBool nextStepsBtnStatus = false.obs;

  //身分證字號
  final RxString idNoSexual = '生理性別'.obs;

  //縣市區郵遞區號 Data
  List<ZipCodeModel> zipCodeList = [];
  int cityIndex = 0;

  //縣市選項
  List<ZipCodeModel> cityOptions = <ZipCodeModel>[];
  RxList<String> citySelectOptions = <String>[].obs;

  //區選項
  RxList<District> districtOptions = <District>[].obs;
  RxList<String> districtSelectOptions = <String>[].obs;

  //郵遞區號選項
  RxString zipOptions = '郵遞區號'.obs;

  Rxn<DateTime> birthdayDateTime = Rxn<DateTime>();
  RxList<RelationOption> relationOptions = <RelationOption>[].obs;
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

  saveIdNoSexual(String idNumber) {
    idNoSexual.value = idNumber[1] == '1' ? '生理男' : '生理女';
    idNoSexual.refresh();
  }

  selectCityOption(List<String> options) {
    //取得 City Index
    List<String> cityOptionList =
        cityOptions.map((entry) => entry.name).toList();
    cityIndex = cityOptionList.indexOf(options[0]);

    //更新 District 選項
    districtOptions.clear();
    for (var district in zipCodeList[cityIndex].districts) {
      districtOptions.add(district);
    }
    districtOptions.refresh();

    //顯示取得的城市選項
    citySelectOptions.assignAll(options);
    citySelectOptions.refresh();
  }

  selectDistrictOption(List<String> options) {
    //取得 City Index
    List<String> districtOptionList =
    districtOptions.map((entry) => entry.name).toList();
    int districtIndex = districtOptionList.indexOf(options[0]);

    //顯示郵遞區號
    zipOptions.value = cityOptions[cityIndex].districts[districtIndex].zip;
    zipOptions.refresh();

    //顯示取得的區選項
    districtSelectOptions.assignAll(options);
    districtSelectOptions.refresh();
  }

  selectRelationOption(List<RelationOption> options) {
    relationOptions.assignAll(options);
    relationOptions.refresh();
  }

  selectBirthdayDate(DateTime dateTime) {
    birthdayDateTime.value = dateTime;
  }

  retrieveZipCode() async {
    print('retrieveZipCode');
    final String response = await rootBundle.loadString('/zip_code.json');
    print('retrieveZipCode: ${response}');
    var zipcode = json.decode(response);
    print('zipcode: ${zipcode}');
    zipCodeList = ZipCodeModelResponse.fromJson(zipcode).list;

    for (var zip in zipcode) {
      ZipCodeModel zipCodeModel = ZipCodeModel.fromJson(zip);
      cityOptions.add(zipCodeModel);
    }

    for (var district in zipCodeList[0].districts) {
      districtOptions.add(district);
    }
  }

  String? eventId;

  @override
  void onInit() {
    retrieveZipCode();
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
  DateTime? birth; //	出生日期
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
        'sexual': idno![1] == '1' ? 0 : 1,
        'address': address,
        'birth': birth,
        'member': membership,
        'agreements': agreements,
      };
}

//聯絡人關係
enum RelationOption {
  Father('父親'),
  Couple('夫妻'),
  Mother('母親'),
  Brother('兄弟'),
  Sister('姐妹'),
  Friend('朋友'),
  Relative('親戚'),
  Else('其他');

  const RelationOption(this.showedString);

  final String showedString;

  @override
  String toString() => showedString;
}
