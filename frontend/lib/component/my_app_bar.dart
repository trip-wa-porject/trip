import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/component/buttons.dart';
import 'package:tripflutter/modules/auth_service.dart';

import '../consts.dart';
import '../screens/auth_login_pages/login_dialog.dart';
import 'widgets.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService authService = Get.put(FirebaseAuthService());
    TextStyle appBarTextStyle =
        MyStyles.kTextStyleButtonS.copyWith(color: Colors.white);
    SizedBox appBarSpacer = const SizedBox(width: 24.0);

    return AppBar(
      leading: null,
      automaticallyImplyLeading: false,
      backgroundColor: MyStyles.tripTertiary,
      title: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1160,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (MediaQuery.of(context).size.width > 700) const Logo(),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed('${AppLinks.SCHEDUL}');
                    },
                    child: Text(
                      '登山行程',
                      style: appBarTextStyle,
                    ),
                  ),
                  Obx(
                    () => authService.user.value == null
                        ? const SizedBox()
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              appBarSpacer,
                              InkWell(
                                onTap: () {
                                  Get.toNamed(
                                      '${AppLinks.SCHEDUL}${AppLinks.MANAGEMENT}');
                                },
                                child: Text(
                                  '我的行程',
                                  style: appBarTextStyle,
                                ),
                              ),
                            ],
                          ),
                  ),
                  Obx(
                    () => authService.user.value == null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              appBarSpacer,
                              MyWebButton(
                                label: '註冊',
                                style: MyWebButton.styleSmallFilledForSignUp(),
                                onPressed: () {
                                  Get.toNamed('${AppLinks.SIGNUP}');
                                },
                              ),
                            ],
                          )
                        : SizedBox(),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Obx(
                    () => authService.user.value == null
                        ? MyWebButton(
                            label: '登入',
                            onPressed: () async {
                              final result =
                                  await Get.dialog(const LoginDialog());
                            },
                            style: MyWebButton.styleSmallFilledForLogin(),
                          )
                        : SizedBox(
                            width: 30,
                            height: 30,
                            child: GestureDetector(
                              onTap: () {
                                Get.dialog(
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        top: 60,
                                      ),
                                      constraints: BoxConstraints(
                                        maxWidth: 1240,
                                      ),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: SizedBox(
                                          width: 70,
                                          height: 50,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Material(
                                                child: InkWell(
                                                  onTap: () {
                                                    authService.signOut();
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    '登出',
                                                    style: MyStyles.kTextStyleH4
                                                        .copyWith(
                                                      color: MyStyles
                                                          .greyScale616161,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  barrierColor: Colors.transparent,
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: MyStyles.greyScale9E9E9E,
                                radius: 15,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                    // : FilledButton(
                    //     onPressed: () {
                    //       authService.signOut();
                    //     },
                    //     child: Text('${authService.user.value!.email} 登出'),
                    //     style: FilledButton.styleFrom(
                    //       backgroundColor: MyStyles.tripNeutral,
                    //       foregroundColor: MyStyles.tripTertiary,
                    //     ),
                    //   ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: null,
      toolbarHeight: 60,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60); //60
}
