import 'package:get/get.dart';
import 'package:tripflutter/component/dialogs.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/screens/schedule_manager/pay_table.dart';

import '../../models/schedule_model.dart';
import '../../modules/hike_repository.dart';

class PayController extends GetxController {
  Rxn<ScheduleModel> model = Rxn<ScheduleModel>();
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
      wantJoinMember.value = true;
    }
  }

  //確認送出，付款資訊
  confirm() async {
    final result = await Get.dialog(
      joinScheduleSuccess(),
    );
    if (result == '查看更多活動') {
      Get.to('${AppLinks.SCHEDUL}');
    }
  }

  //取消報名
  cancel() {}

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
        ScheduleModel _model = model.value!;
        OrderData orderData = OrderData(
          id: _model.id,
          detail: _model.title,
          price: _model.price.toString(),
        );
        orders.add(orderData);
      }
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
