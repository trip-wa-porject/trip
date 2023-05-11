import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripflutter/component/dialogs.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/screens/schedule_manager/pay_table.dart';
import 'package:tripflutter/screens/schedule_manager/schedule_manager_controller.dart';

import '../../models/registration.dart';
import '../../models/schedule_model.dart';
import '../../models/user_model.dart';
import '../../modules/auth_service.dart';
import '../../modules/hike_repository.dart';

class PayController extends GetxController {
  Rxn<ScheduleModel> model = Rxn<ScheduleModel>();
  Rxn<Registration> registrationModel = Rxn<Registration>();
  final FirebaseAuthService _firebaseAuthService =
      Get.find<FirebaseAuthService>();
  TextEditingController account = TextEditingController();
  TextEditingController price = TextEditingController();

  RxList<OrderData> orders = RxList([]);
  final BackendRepository repository = BackendRepository();

  RxInt selectedMethod = 0.obs;
  RxBool wantJoinMember = false.obs;
  RxBool isMember = false.obs;

  getUser() async {
    if (_firebaseAuthService.user.value?.uid != null) {
      Map<String, dynamic> data = await repository
          .getUserUseInstance(_firebaseAuthService.user.value!.uid);
      UserModel userModel = UserModel.fromJson(data);
      if (userModel.membership == 1) {
        isMember.value = true;
      }
    }
  }

  int getTotalPrice() {
    List<OrderData> orderData = orders.toList();
    int totalPrice = 0;
    for (var o in orderData) {
      if (o.price != null) {
        int price = int.tryParse(o.price!) ?? 0;
        totalPrice += price;
      }
    }

    return totalPrice;
  }

  bool checkRemitAccount(String remitAccount) {
    if (remitAccount.isEmpty) {
      return false;
    } else {
      if (RegExp(r'(?=.*?[0-9])\w+').hasMatch(remitAccount) &&
          remitAccount.length == 5) {
        return true;
      }
    }
    return false;
  }

  void selectMethod(int? method) {
    if (method == null) {
      selectedMethod.value = 0;
    } else {
      selectedMethod.value = method;
    }
  }

  //即刻加入會員
  joinMember() async {
    final result = await Get.dialog(
      joinMemberDialog(),
    );
    if (result == true) {
      orders.add(OrderData.sampleVIP());
      wantJoinMember.value = true;
    }
  }

  //確認送出，付款資訊
  confirm() async {
    final String _account = account.text;
    final String _price = price.text;
    if (checkRemitAccount(_account)) {
      List<OrderData> _orders = orders.toList();
      String payMethod = "";
      switch (selectedMethod.value) {
        case 0:
          payMethod = 'ATM繳款';
          break;
        case 1:
          payMethod = '匯款或無存摺存款';
          break;
        case 2:
          payMethod = '信用卡';
          break;
      }

      bool isMember = false;
      if (_orders.any((element) => element.detail == '正式會員')) {
        isMember = true;
        if (_firebaseAuthService.user.value?.uid != null) {
          try {
            repository.updateUserUseInstance(
                _firebaseAuthService.user.value!.uid, {'member': 1});
          } catch (e) {
            Get.snackbar('升級會員失敗', '請聯絡客服');
            print(e);
          }
        }
      } else {
        if (_firebaseAuthService.user.value?.uid != null) {
          Map<String, dynamic> data = await repository
              .getUserUseInstance(_firebaseAuthService.user.value!.uid);
          UserModel userModel = UserModel.fromJson(data);
          if (userModel.membership == 1) {
            isMember = true;
          }
        }
      }

      Get.find<ScheduleManagerController>()
          .confirmPay(registrationModel.value, {
        'method': selectedMethod.value,
        'info': _account,
        'isMember': isMember,
      });

      _orders = _orders.map((e) {
        e.lastNumbers = _account;
        e.payMethod = payMethod;
        e.date = DateFormat('yyyy-MM-dd').format(DateTime.now());
        return e;
      }).toList();
      orders.assignAll(_orders);
    } else {
      Get.snackbar('請提供付款資訊', '');
      return;
    }

    final result = await Get.dialog(
      joinScheduleSuccess(),
    );
    if (result == '查看更多活動') {
      Get.offAndToNamed('${AppLinks.SCHEDUL}');
    }
    if (result == '追蹤訂單') {
      Get.offAndToNamed('${AppLinks.SCHEDUL}${AppLinks.MANAGEMENT}');
    }
  }

  //取消報名
  cancel() async {
    final result = await Get.dialog(
      cancelSchedule(),
    );
    //TODO cancel schedule
    Get.find<ScheduleManagerController>()
        .cancelRegister(registrationModel.value);
    Get.back();
  }

  getData() async {
    try {
      model.value = ScheduleModel.fromJson(Get.arguments);
    } catch (e) {
      Map<String, dynamic> parameters = Get.parameters;
      Map<String, dynamic>? data =
          await repository.getOneTrip(parameters['id']);
      if (data != null) {
        model.value = ScheduleModel.fromJson(data);
      }
    } finally {
      if (model.value != null) {
        String? userId = _firebaseAuthService.user.value?.uid;
        if (userId != null) {
          ScheduleModel _model = model.value!;

          List<Map<String, dynamic>> data =
              await repository.getUserAllTrips(userId);
          List<Registration> registers =
              data.map((e) => Registration.fromJson(e)).toList();
          Registration? r = registers
              .firstWhereOrNull((element) => element.tripId == model.value!.id);
          registrationModel.value = r;
          if (r != null) {
            OrderData orderData = OrderData(
              id: r.tripId,
              detail: _model.title,
              price: _model.price.toString(),
            );
            orders.add(orderData);
          }
        }
      }
      // if (model.value != null) {
      //   ScheduleModel _model = model.value!;
      //   OrderData orderData = OrderData(
      //     id: _model.id,
      //     detail: _model.title,
      //     price: _model.price.toString(),
      //   );
      //   orders.add(orderData);
      // }
    }
  }

  @override
  void onInit() {
    getData();
    getUser();
    super.onInit();
  }
}
