import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/screens/auth_login_pages/login_controller.dart';

import '../../component/textfield.dart';

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
        height: 600,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('登入'),
                SizedBox(
                  height: 42,
                ),
                Text('帳號'),
                LoginTextField(
                  controller: emailController,
                ),
                Obx(() => Text('${controller.emailError.value}')),
                SizedBox(
                  height: 16,
                ),
                Text('密碼'),
                LoginTextField(
                  controller: pwdController,
                ),
                Obx(() => Text('${controller.passwordError.value}')),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.loginEvent(
                      emailController.text,
                      pwdController.text,
                    );
                  },
                  child: Center(
                    child: Obx(
                      () => controller.isLoading.value
                          ? CircularProgressIndicator()
                          : Text('登入'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.signup();
                  },
                  child: Center(
                    child: Text('加入會員'),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Center(
                    child: Text('忘記密碼'),
                  ), //TODO
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
