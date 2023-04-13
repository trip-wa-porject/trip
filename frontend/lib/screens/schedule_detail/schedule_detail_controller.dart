import 'package:get/get.dart';

import '../../models/registration.dart';
import '../../models/schedule_model.dart';
import '../../modules/auth_service.dart';
import '../../modules/hike_repository.dart';
import '../schedule_manager/schedule_manager_controller.dart';

class ScheduleDetailController extends GetxController {
  Rxn<ScheduleModel> model = Rxn<ScheduleModel>();
  RxList<Registration> userJoinedModel = RxList<Registration>([]);
  ScheduleManagerController scheduleManagerController =
      Get.put(ScheduleManagerController());
  final BackendRepository repository = BackendRepository();

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
    }
  }

  bool userAlreadyJoin() {
    bool isJoined =
        userJoinedModel.any((element) => element.tripId == model.value?.id);
    return isJoined;
  }

  join() {
    Get.find<ScheduleManagerController>()
        .joinNewEvent(model.value!.id, model.value!);
  }

  @override
  void onInit() {
    getData();
    ever(scheduleManagerController.userJoinedModel,
        (items) => userJoinedModel.assignAll(items));
    super.onInit();
  }
}
