import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/modules/auth_service.dart';

import 'signup_controller.dart';

class SignUpContentThree extends GetView<SignUpController> {
  const SignUpContentThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return Container(
      child: Column(
        children: [
          Text(
            'SignUpContentThree\n訪客：${Get.find<FirebaseAuthService>().user.value?.uid} \n email: aaabbbccc@gmail.com \n password: Aa12345678',
          ),
          ElevatedButton(
              onPressed: () async {
                await controller.signUp("aaabbbccc@gmail.com", 'Aa12345678');
              },
              child: Text('註冊會員'))
        ],
      ),
    );
  }
}
