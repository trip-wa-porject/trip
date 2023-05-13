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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Form(
        key: controller.formKey,
        child: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 120,
                        ),
                        Text(
                          '登入',
                          style: MyStyles.kTextStyleH2Bold.copyWith(),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          '帳號（email）',
                          style: MyStyles.kTextStyleH4.copyWith(),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Obx(
                          () => LoginTextField(
                            controller: emailController,
                            hint: '請輸入 E-mail',
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
                        const SizedBox(
                          height: 4,
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
                          height: 12,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: MyFilledButton(
                            label: '登入',
                            style: MyFilledButton.styleGreenWhiteH4(),
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
                        //   height: 28,
                        // ),
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: MyFilledButton(
                        //     label: '加入會員',
                        //     style: MyFilledButton.styleOrangeBorder(),
                        //     onPressed: () {
                        //       controller.signup();
                        //     },
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              '忘記密碼?',
                              style: MyStyles.kTextStyleBody1.copyWith(
                                color: MyStyles.greyScale757575,
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
    );
  }
}
