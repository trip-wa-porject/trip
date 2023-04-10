import 'package:get/get.dart';

import '../../models/schedule_model.dart';

class PayController extends GetxController {
  Rxn<ScheduleModel> model = Rxn<ScheduleModel>();

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
