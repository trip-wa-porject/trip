import 'package:get/get.dart';

import '../../models/schedule_model.dart';

class PayController extends GetxController {
  Rxn<ScheduleModel> model = Rxn<ScheduleModel>();

  RxInt selectedMethod = 0.obs;

  void selectMethod(int? method) {
    if (method == null) {
      selectedMethod.value = 0;
    } else {
      selectedMethod.value = method;
    }
  }

  //即刻加入會員
  joinMember() {}

  //確認送出，付款資訊
  confirm() {}

  //取消報名
  cancel() {}

  getData() async {
    try {
      model.value = ScheduleModel.fromJson(Get.arguments);
    } catch (e) {
      Future.delayed(Duration(seconds: 3), () {
        //TODO get data from api
        model.value = ScheduleModel.sampleFromJson();
      });
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
