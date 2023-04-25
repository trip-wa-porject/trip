import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../component/buttons.dart';
import '../../component/textfield.dart';
import '../../consts.dart';
import '../auth_signup_pages/utils.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController pwdController = TextEditingController();

    Get.put(LoginController());
    return Form(
      key: controller.formKey,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Obx(
            () => controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : FractionallySizedBox(
                    widthFactor: .8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '登入',
                          style: MyStyles.kTextStyleH2Bold.copyWith(),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Text(
                          '帳號（email）',
                          style: MyStyles.kTextStyleH3.copyWith(),
                        ),
                        Obx(
                          () => LoginTextField(
                            controller: emailController,
                            hint: 'jijijijjijijijiji@gmail.com',
                            error: controller.emailError.value,
                            validator: (String? value) {
                              return validateEmail(value);
                            },
                          ),
                        ),
                        // Obx(() => Text('${controller.emailError.value}')),
                        Text(
                          '密碼',
                          style: MyStyles.kTextStyleH3.copyWith(),
                        ),
                        Obx(
                          () => LoginTextField(
                            controller: pwdController,
                            hint: 'xxxxxxxxxxxxx',
                            error: controller.passwordError.value,
                            validator: (String? value) {
                              return validatePassword(value);
                            },
                          ),
                        ),
                        // Obx(() => Text('${controller.passwordError.value}')),
                        SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 61,
                          child: MyFilledButton(
                            label: '登入',
                            style: MyFilledButton.styleGreenBigWhite(),
                            onPressed: () {
                              if (controller.isLoading.value) return;
                              controller.loginEvent(
                                emailController.text,
                                pwdController.text,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 61,
                          child: MyFilledButton(
                            label: '加入會員',
                            style: MyFilledButton.styleOrangeBigBlack(),
                            onPressed: () {
                              controller.signup();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              '忘記密碼?',
                              style: MyStyles.kTextStyleH4.copyWith(
                                color: MyStyles.redC80000,
                                fontWeight: FontWeight.bold,
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
    );
  }
}
