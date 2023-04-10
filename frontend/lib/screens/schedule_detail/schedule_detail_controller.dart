import 'package:get/get.dart';

import '../../models/schedule_model.dart';
import '../schedule_manager/schedule_manager_controller.dart';

class ScheduleDetailController extends GetxController {
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

  join() {
    Get.find<ScheduleManagerController>().joinNewEvent(model.value!.id);
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
