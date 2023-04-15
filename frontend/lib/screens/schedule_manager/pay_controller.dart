import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tripflutter/component/dialogs.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/screens/schedule_manager/pay_table.dart';
import 'package:tripflutter/screens/schedule_manager/schedule_manager_controller.dart';

import '../../models/registration.dart';
import '../../models/schedule_model.dart';
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
    if (_account != '') {
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
      _orders = _orders.map((e) {
        e.lastNumbers = _account;
        e.payMethod = payMethod;
        e.date = DateFormat('yyyy-MM-dd').format(DateTime.now());
        return e;
      }).toList();
      orders.assignAll(_orders);
    }

    final result = await Get.dialog(
      joinScheduleSuccess(),
    );
    if (result == '查看更多活動') {
      Get.toNamed('${AppLinks.SCHEDUL}');
    }
  }

  //取消報名
  cancel() async {
    final result = await Get.dialog(
      cancelSchedule(),
    );
    //TODO cancel schedule
    // Get.back();
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
    super.onInit();
  }
}
