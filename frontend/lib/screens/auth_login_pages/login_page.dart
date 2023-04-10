import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Material(
        child: Container(
      child: Column(
        children: [
          //返回
          Row(
            children: [
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.keyboard_backspace)),
              Text('back'),
            ],
          ),
          //
        ],
      ),
    ));
  }
}
