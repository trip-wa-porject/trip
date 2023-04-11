import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/component/buttons.dart';

import 'signup_controller.dart';
import 'signup_page.dart';

class SignUpContentOne extends GetView<SignUpController> {
  const SignUpContentOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    SizedBox spacer = SizedBox(
      height: 24,
    );
    return Obx(
      () => Container(
        child: Column(
          children: controller.step0CheckedStates
              .map((element) => Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: DropdownTerm(checkState: element),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
