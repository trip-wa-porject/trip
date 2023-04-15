import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/component/buttons.dart';
import 'package:tripflutter/screens/schedule_manager/pay_controller.dart';
import 'package:tripflutter/screens/schedule_selector/schedule_card.dart';

import '../../component/footer.dart';
import '../../component/my_app_bar.dart';
import '../../component/textfield.dart';
import '../../component/widgets.dart';
import '../../consts.dart';
import '../../models/schedule_model.dart';
import 'pay_table.dart';

class Pay extends GetView<PayController> {
  const Pay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PayController());
    return Scaffold(
      backgroundColor: Color(0xff686868),
      appBar: MyAppBar(),
      body: Material(
        child: Center(
          child: ListView(
            children: [
              Center(
                child: LayoutBuilder(builder: (context, constrains) {
                  TextStyle payMethodStyle = MyStyles.kTextStyleH4;
                  return Container(
                    constraints: BoxConstraints(
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
                            '活動訂單繳費',
                            style: MyStyles.kTextStyleH2Bold
                                .copyWith(color: MyStyles.tripTertiary),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Obx(
                          () => controller.model.value != null
                              ? SizedBox(
                                  height: 173,
                                  child: IgnorePointer(
                                    child: ScheduleCard(
                                      model: controller.model.value!,
                                      index: 0,
                                      isShowOnly: true,
                                    ),
                                  ),
                                )
                              : Container(
                                  color:
                                      MyStyles.greyScale9E9E9E.withOpacity(.3),
                                  width: 1160,
                                  height: 180,
                                ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Obx(
                          () => EasyRichText(
                            '倒數繳費截止：*${getCountdown(controller.registrationModel.value?.paymentExpireDate)}* ',
                            patternList: [
                              EasyRichTextPattern(
                                targetString: '(\\*)(.*?)(\\*)',
                                matchBuilder:
                                    (BuildContext context, RegExpMatch? match) {
                                  return TextSpan(
                                    text: match?[0]?.replaceAll('*', ''),
                                    style: MyStyles.kTextStyleH2Bold.copyWith(
                                      color: MyStyles.redC80000,
                                    ),
                                  );
                                },
                              ),
                            ],
                            defaultStyle: MyStyles.kTextStyleH2Bold,
                          ),
                        ),
                        Divider(),
                        EasyRichText(
                          '付款方式選挥(可分多次付款)「收费活動報名後三天内繳納全額費用始完成正式報名手,三天未用者列為候補名單。」',
                          patternList: [
                            EasyRichTextPattern(
                              targetString:
                                  '「收费活動報名後三天内繳納全額費用始完成正式報名手,三天未用者列為候補名單。」',
                              style: MyStyles.kTextStyleH3Bold.copyWith(
                                color: MyStyles.redC80000,
                              ),
                            ),
                          ],
                          defaultStyle: MyStyles.kTextStyleH3Bold,
                        ),
                        Obx(
                          () => Row(
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
                                            groupValue:
                                                controller.selectedMethod.value,
                                            onChanged: controller.selectMethod),
                                        Text(
                                          'ATM繳款',
                                          style: payMethodStyle,
                                        ),
                                        Radio<int>(
                                            value: 1,
                                            groupValue:
                                                controller.selectedMethod.value,
                                            onChanged: controller.selectMethod),
                                        Text(
                                          '匯款或無存摺存款',
                                          style: payMethodStyle,
                                        ),
                                        Radio<int>(
                                            value: 2,
                                            groupValue:
                                                controller.selectedMethod.value,
                                            onChanged: controller.selectMethod),
                                        Text(
                                          '信用卡',
                                          style: payMethodStyle,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 23,
                                    ),
                                    //輸入後五碼
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '帳號後五碼：',
                                          style: payMethodStyle,
                                        ),
                                        SizedBox(
                                          width: 232,
                                          child: PayTextField(),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
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
                                        SizedBox(
                                          width: 232,
                                          child: PayTextField(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              //右側
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 38,
                                  vertical: 18.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "匯款資訊",
                                      style: MyStyles.kTextStyleH3Bold.copyWith(
                                        color: MyStyles.tripTertiary,
                                      ),
                                    ),
                                    Text(
                                      "銀行：第一銀行 敦南分行",
                                      style: MyStyles.kTextStyleH4,
                                    ),
                                    Text(
                                      "匯款帳號：09090909090",
                                      style: MyStyles.kTextStyleH4,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 86,
                                height: 38,
                                child: MyFilledButton(
                                  label: '確認送出',
                                  style: MyFilledButton.styleOrangeSmallBlack(),
                                  onPressed: () {
                                    controller.confirm();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 86,
                                height: 38,
                                child: MyFilledButton(
                                  label: '取消報名',
                                  style: MyFilledButton.styleRedSmallWhite(),
                                  onPressed: () {
                                    controller.cancel();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        //VIP
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/vip.png',
                                width: 46.69,
                                height: 33.5,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(3.6),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 10,
                                  ),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        width: 15,
                                        color: MyStyles.tripPrimary,
                                      ),
                                      top: BorderSide(
                                        width: 2,
                                        color: MyStyles.tripPrimary,
                                      ),
                                      right: BorderSide(
                                        width: 2,
                                        color: MyStyles.tripPrimary,
                                      ),
                                      bottom: BorderSide(
                                        width: 2,
                                        color: MyStyles.tripPrimary,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '加入VIP會員即可有優惠',
                                            style: MyStyles.kTextStyleH3Bold
                                                .copyWith(
                                              color: MyStyles.redC80000,
                                            ),
                                          ),
                                          Text(
                                            '點擊了解VIP會員',
                                            style: MyStyles
                                                .kTextStyleSubtitle1Bold
                                                .copyWith(
                                              color: MyStyles.greyScale616161,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 14,
                                      ),
                                      SizedBox(
                                        width: 90,
                                        height: 59,
                                        child: MyFilledButton(
                                          label: '即刻加入',
                                          style: MyFilledButton
                                              .styleRedSmallWhite(),
                                          onPressed: () {
                                            controller.joinMember();
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: Divider(),
                        ),
                        //付款狀態
                        Align(
                          alignment: Alignment.centerLeft,
                          child: EasyRichText(
                            '● 付款狀態（臨時會員）',
                            defaultStyle: MyStyles.kTextStyleH3Bold,
                            patternList: [
                              EasyRichTextPattern(
                                targetString: '（臨時會員）',
                                style: MyStyles.kTextStyleH3Bold.copyWith(
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
                              OrderData.sample(),
                              ...controller.orders,
                              if (controller.wantJoinMember.value)
                                OrderData.sampleVIP(),
                            ],
                          ),
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
        ),
      ),
    );
  }
}

String getCountdown(DateTime? dateTime) {
  if (dateTime == null) {
    return '320小時40分鐘';
  }
  Duration duration = DateTime.now().difference(dateTime);

  return "${duration.inHours}小時${duration.inMinutes % 60}分鐘";
}
