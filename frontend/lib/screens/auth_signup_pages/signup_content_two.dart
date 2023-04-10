import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'signup_controller.dart';

class SignUpContentTwo extends GetView<SignUpController> {
  const SignUpContentTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return Container(
      child: Text(
        'SignUpContentTwo',
      ),
    );
  }
}
