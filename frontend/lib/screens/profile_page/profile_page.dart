import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/models/user_model.dart';
import 'package:tripflutter/modules/auth_service.dart';
import 'package:tripflutter/screens/profile_page/profile_page_controller.dart';

import '../../component/buttons.dart';
import '../../consts.dart';

class ProfilePage extends GetView<ProfilePageController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfilePageController());
    return Scaffold(
      body: Obx(
        () => FutureBuilder<UserModel?>(
            future: controller
                .getUserData(Get.find<FirebaseAuthService>().user.value),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const ColoredBox(
                  color: MyStyles.tripTertiary,
                  child: SafeArea(
                    child: ColoredBox(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                );
              }
              UserModel? userModel = snapshot.data;
              if (userModel == null) {
                return const Center(
                  child: Text('資料異常'),
                );
              }
              return Column(
                children: [
                  Container(
                    color: MyStyles.tripTertiary,
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 8,
                      bottom: 24,
                    ),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            height: 8,
                          ),
                          Text(
                            '${userModel.name}',
                            style: MyStyles.kTextStyleH2Normal.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '帳號：${userModel.email}',
                            style: MyStyles.kTextStyleSubtitle1.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '會籍：${userModel.membership == 1 ? "VIP會員" : "一般會員"}',
                                style: MyStyles.kTextStyleSubtitle1.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: FittedBox(
                                  child: Text(
                                    '${"(會籍到期將於 2024/5/16 到期)"}',
                                    style: MyStyles.kTextStyleBody1.copyWith(
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        child: Column(
                          children: [
                            DataContainer(
                              iconData: Icons.emergency,
                              title: '保險用資料',
                              data: {
                                "出生年月日": "${userModel.birth ?? "1995/05/16"}",
                                '身分證字號': "${userModel.idno}",
                                "性別": "${userModel.sexual == 0 ? "男" : "女"}",
                                '電話': '${userModel.mobile}',
                                "地址": "${userModel.address}",
                              },
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            DataContainer(
                              iconData: Icons.crisis_alert,
                              title: '緊急聯絡資訊',
                              data: {
                                "聯絡人": "${userModel.emergentContactor}",
                                "關係":
                                    "${userModel.contactorRelationship ?? "母"}",
                                '電話': "${userModel.emergentContactTel}",
                              },
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            MyFilledButton(
                              label: '登出',
                              style: MyFilledButton.styleOrangeBorder(),
                              onPressed: () {
                                controller.signOut();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}

class DataContainer extends StatelessWidget {
  const DataContainer({
    Key? key,
    required this.iconData,
    required this.title,
    required this.data,
  }) : super(key: key);

  final IconData iconData;
  final String title;
  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(iconData),
              Text(
                title,
                style: MyStyles.kTextStyleH4,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: MyStyles.tripTertiary)),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: data.entries
                .map((e) => Row(
                      children: [
                        Text(
                          e.key,
                          style: MyStyles.kTextStyleSubtitle1Bold,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          e.value,
                          style: MyStyles.kTextStyleBody1,
                        ),
                      ],
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
