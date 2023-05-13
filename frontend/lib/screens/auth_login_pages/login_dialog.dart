import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/component/buttons.dart';
import 'package:tripflutter/screens/auth_login_pages/login_controller.dart';
import 'package:tripflutter/screens/auth_signup_pages/utils.dart';

import '../../component/textfield.dart';
import '../../consts.dart';

class LoginDialog extends GetView<LoginController> {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController pwdController = TextEditingController();

    Get.put(LoginController());
    return Center(
      child: SizedBox(
        width: 500,
        height: 624,
        child: Form(
          key: controller.formKey,
          child: Card(
            surfaceTintColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '登入',
                                style: MyStyles.kTextStyleH3Bold.copyWith(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.signup();
                                },
                                child: Text(
                                  '註冊',
                                  style: MyStyles.kTextStyleSubtitle1.copyWith(
                                    color: MyStyles.tripTertiary,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            '帳號（email）',
                            style: MyStyles.kTextStyleH4.copyWith(),
                          ),
                          Obx(
                            () => LoginTextField(
                              controller: emailController,
                              hint: '請輸入E-mail帳號',
                              error: controller.emailError.value,
                              validator: (String? value) {
                                return validateEmail(value);
                              },
                            ),
                          ),
                          // Obx(() => Text('${controller.emailError.value}')),
                          Text(
                            '密碼',
                            style: MyStyles.kTextStyleH4.copyWith(),
                          ),
                          Obx(
                            () => LoginTextField(
                              controller: pwdController,
                              hint: '請輸入密碼',
                              error: controller.passwordError.value,
                              validator: (String? value) {
                                return validatePassword(value);
                              },
                              obscureText: true,
                            ),
                          ),
                          // Obx(() => Text('${controller.passwordError.value}')),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: MyWebButton(
                              label: '登入',
                              style: MyWebButton.styleLargeFilled(),
                              onPressed: () {
                                if (controller.isLoading.value) return;
                                controller.loginEvent(
                                  emailController.text,
                                  pwdController.text,
                                );
                              },
                            ),
                          ),
                          // const SizedBox(
                          //   height: 24,
                          // ),
                          // SizedBox(
                          //   width: double.infinity,
                          //   height: 61,
                          //   child: MyFilledButton(
                          //     label: '加入會員',
                          //     style: MyFilledButton.styleOrangeBigBlack(),
                          //     onPressed: () {
                          //       controller.signup();
                          //     },
                          //   ),
                          // ),
                          const SizedBox(
                            height: 14,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Center(
                              child: Text(
                                '忘記密碼?',
                                style: MyStyles.kTextStyleSubtitle1.copyWith(
                                  color: MyStyles.greyScale757575,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
