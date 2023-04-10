import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/screens/schedule_manager/pay_controller.dart';

import '../../models/schedule_model.dart';

class Pay extends GetView<PayController> {
  const Pay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Card(
          child: Container(
            child: Obx(
              () => Column(
                children: [
                  Text('行程名稱：${controller.model.value?.title} '),
                  Text('金額: ${controller.model.value?.price}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
