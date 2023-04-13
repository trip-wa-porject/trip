import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/consts.dart';
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
            '就差一步！\n請前往信箱驗證以完成會員註冊',
            style: MyStyles.kTextStyleH3,
            textAlign: TextAlign.center,
          ),
          Image.asset(
            'assets/images/check.png',
            width: 745,
            height: 655,
          ),
          const SizedBox(
            height: 32,
          ),
          RichText(
            textScaleFactor: MediaQuery.of(context).textScaleFactor,
            text: TextSpan(
              style: MyStyles.kTextStyleH3.copyWith(
                color: Colors.black54,
              ),
              children: [
                TextSpan(text: '若您十分鐘內尚未收到驗證信，請點擊'),
                TextSpan(
                  text: '重新傳送',
                  style: MyStyles.kTextStyleH3.copyWith(
                    color: Colors.black54,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => controller.sendEmail(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
