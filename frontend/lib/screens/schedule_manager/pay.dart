import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/component/buttons.dart';
import 'package:tripflutter/screens/schedule_manager/pay_controller.dart';
import 'package:tripflutter/screens/schedule_selector/schedule_card.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../component/footer.dart';
import '../../component/my_app_bar.dart';
import '../../component/textfield.dart';
import '../../component/widgets.dart';
import '../../consts.dart';
import '../../utils/amount_format_utils.dart';
import 'pay_table.dart';

class Pay extends GetView<PayController> {
  const Pay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PayController());
    controller.getData();
    return Scaffold(
      backgroundColor: Color(0xff686868),
      appBar: MyAppBar(),
      body: Material(
        child: Center(
          child: Stack(
            children: [
              ListView(
                children: [
                  Center(
                    child: LayoutBuilder(builder: (context, constrains) {
                      TextStyle payMethodStyle = MyStyles.kTextStyleSubtitle1;
                      return Container(
                        constraints: const BoxConstraints(
                            maxHeight: double.infinity, maxWidth: 1160),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 81,
                            ),
                            const MyBackButton(),
                            const SizedBox(
                              height: 52,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '登山行程訂單繳費',
                                style: MyStyles.kTextStyleH2Bold
                                    .copyWith(color: MyStyles.tripTertiary),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Obx(
                              () => controller.model.value != null
                                  ? SizedBox(
                                      height: 173,
                                      child: ScheduleCard(
                                        model: controller.model.value!,
                                        index: 0,
                                        isShowOnly: true,
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 173,
                                      child: ScheduleCardSkeleton(),
                                    ),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            //付款狀態
                            Align(
                              alignment: Alignment.centerLeft,
                              child: EasyRichText(
                                '● 付款狀態（一般會員）',
                                defaultStyle: MyStyles.kTextStyleH4,
                                patternList: [
                                  EasyRichTextPattern(
                                    targetString: '（一般會員）',
                                    style: MyStyles.kTextStyleH4.copyWith(
                                      color: MyStyles.tripTertiary,
                                    ),
                                  ),
                                  EasyRichTextPattern(
                                    targetString: '●',
                                    style: MyStyles.kTextStyleBody1.copyWith(
                                      color: MyStyles.tripTertiary,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //表格
                            Obx(
                              () => PayTable(
                                orderData: [
                                  ...controller.orders,
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            Obx(
                              () => EasyRichText(
                                '倒數繳費截止：*${getCountdown(controller.registrationModel.value?.paymentExpireDate)}* ',
                                patternList: [
                                  EasyRichTextPattern(
                                    targetString: '(\\*)(.*?)(\\*)',
                                    matchBuilder: (BuildContext context,
                                        RegExpMatch? match) {
                                      return TextSpan(
                                        text: match?[0]?.replaceAll('*', ''),
                                        style: MyStyles.kTextStyleH4M.copyWith(
                                          color: MyStyles.redC80000,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                                defaultStyle: MyStyles.kTextStyleH4M,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const Divider(),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: EasyRichText(
                                '付款方式選擇 三天内繳納全額費用始完成正式報名，逾期未繳費者則自動取消資格。',
                                patternList: [
                                  EasyRichTextPattern(
                                    targetString:
                                        '三天内繳納全額費用始完成正式報名，逾期未繳費者則自動取消資格。',
                                    style: MyStyles.kTextStyleBody1.copyWith(
                                      color: MyStyles.redC80000,
                                    ),
                                  ),
                                  EasyRichTextPattern(
                                    targetString: '●',
                                    style: MyStyles.kTextStyleBody1.copyWith(
                                      color: MyStyles.tripTertiary,
                                    ),
                                  )
                                ],
                                defaultStyle: MyStyles.kTextStyleH4,
                              ),
                            ),
                            Obx(
                              () => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      children: [
                                        //付款方式
                                        Row(
                                          children: [
                                            Text(
                                              '付款方式：',
                                              style: payMethodStyle,
                                            ),
                                            Radio<int>(
                                                value: 0,
                                                groupValue: controller
                                                    .selectedMethod.value,
                                                onChanged:
                                                    controller.selectMethod),
                                            Text(
                                              'ATM繳款',
                                              style: payMethodStyle,
                                            ),
                                            Radio<int>(
                                                value: 1,
                                                groupValue: controller
                                                    .selectedMethod.value,
                                                onChanged:
                                                    controller.selectMethod),
                                            Text(
                                              '匯款或無存摺存款',
                                              style: payMethodStyle,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 23,
                                        ),
                                        //輸入後五碼
                                        Obx(
                                          () => controller
                                                      .selectedMethod.value ==
                                                  2
                                              ? const SizedBox()
                                              : Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '帳號後五碼：',
                                                      style: payMethodStyle,
                                                    ),
                                                    SizedBox(
                                                      width: 232,
                                                      child: PayTextField(
                                                        controller:
                                                            controller.account,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        //輸入付款金額
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '    付款金額：',
                                              style: payMethodStyle,
                                            ),
                                            Text(
                                              'NT\$ ${amountFormat(controller.getTotalPrice())}',
                                              style: payMethodStyle,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 34,
                                        ),
                                        Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: 86,
                                                height: 38,
                                                child: MyWebButton(
                                                  label: '取消報名',
                                                  style: MyWebButton
                                                      .styleMediumFillGrey(),
                                                  onPressed: () {
                                                    controller.cancel();
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: 86,
                                                height: 38,
                                                child: MyWebButton(
                                                  label: '確認送出',
                                                  style: MyWebButton
                                                      .styleMediumFilledGreen(),
                                                  onPressed: () {
                                                    controller.confirm();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //右側
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 38,
                                          vertical: 18.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "匯款資訊",
                                              style: MyStyles.kTextStyleH3Bold
                                                  .copyWith(
                                                color: MyStyles.tripTertiary,
                                              ),
                                            ),
                                            const Text(
                                              "銀行：第一銀行 敦南分行",
                                              style: MyStyles.kTextStyleH4,
                                            ),
                                            Text(
                                              "匯款帳號：09090909090",
                                              style: MyStyles.kTextStyleH4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              launchUrlString(
                                                  'https://www.apple.com/tw/app-store/');
                                            },
                                            child: Image.asset(
                                              'assets/images/app_store.png',
                                              height: 46,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              launchUrlString(
                                                  'https://play.google.com/store/apps');
                                            },
                                            child: Image.asset(
                                              'assets/images/play_store.png',
                                              height: 46,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      SizedBox(
                                        width: 302,
                                        child: MyWebButton(
                                          label: '下載App',
                                          style: MyWebButton.styleLargeFilled(),
                                          onPressed: () {
                                            Get.dialog(
                                              Center(
                                                child: Card(
                                                  color: MyStyles.green3,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/link_qrcode.png',
                                                          width: 200,
                                                          height: 200,
                                                        ),
                                                        const SizedBox(
                                                          height: 16.0,
                                                        ),
                                                        Text(
                                                          '掃描 QRcode,馬上體驗',
                                                          style: MyStyles
                                                              .kTextStyleH4
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14.0),
                                        child: Text(
                                          '使用 GPX 離線導覽地圖，確保旅途平安',
                                          style: MyStyles.kTextStyleBody1
                                              .copyWith(
                                                  color: MyStyles.tripTertiary),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 120.0),
                    child: Footer(),
                  ),
                ],
              ),
              //VIP
              Positioned(
                left: 16.0,
                bottom: 16.0,
                child: Obx(
                  () => controller.orders
                              .any((element) => element.detail == '正式會員') ||
                          controller.isMember.value
                      ? const SizedBox()
                      : Card(
                          elevation: 10,
                          surfaceTintColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/vip2.png',
                                  width: 46.69,
                                  height: 33.5,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'VIP會員',
                                  style: MyStyles.kTextStyleH3Bold
                                      .copyWith(color: MyStyles.tripPrimary),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'NT\$500 立刻加入VIP\n享有無限次數折扣金',
                                  style: MyStyles.kTextStyleSubtitle1,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MyWebButton(
                                  label: '立即開通',
                                  style: MyWebButton.styleMediumFilledOrange(),
                                  onPressed: () {
                                    controller.joinMember();
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getCountdown(DateTime? dateTime) {
  if (dateTime == null) {
    return '320小時40分鐘';
  }
  Duration duration = dateTime.difference(DateTime.now());

  return "${duration.inHours}小時${duration.inMinutes % 60}分鐘";
}
