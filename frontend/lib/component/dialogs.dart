import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/component/buttons.dart';
import 'package:tripflutter/consts.dart';

Widget joinMemberDialog() {
  bool check = false;
  return Center(
    child: SizedBox(
      width: 684,
      height: 548,
      child: StatefulBuilder(builder: (context, StateSetter setState) {
        return Material(
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 72,
              right: 72,
              top: 50,
              bottom: 61,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'I 加入VIP會員 I',
                    style: MyStyles.kTextStyleH2Bold.copyWith(
                      color: MyStyles.greyScale212121,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  '以下為加入VIP會員說明條款：',
                  style: MyStyles.kTextStyleH3Bold.copyWith(
                    color: MyStyles.tripPrimary,
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Text(
                  '一般會員要轉VIP會員除需繳納常年會費（新臺幣500元）外尚需加收手續費100元。辦理入會申請時，如為親至協會辦理者須準備有效證件(身分證或駕照或健保卡.......等有照片之證件驗證身份使用（辦理入山申請時專用）)，並於協會制式表單正確填寫申請表：姓名、性別、出生地、血型、出生日期、身分證號、通訊地址、戶籍地址、聯絡電話（家、手機、公司）、緊急聯絡人及電話。',
                  style: MyStyles.kTextStyleSubtitle1.copyWith(
                    color: MyStyles.greyScale000000,
                  ),
                ),
                SizedBox(
                  height: 33,
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: MyStyles.tripTertiary,
                      value: check,
                      onChanged: (value) {
                        setState(() => check = !check);
                      },
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        '同意上述事項，並同意此活動於蒐集目的必要範圍內，蒐集、利用、處理本人的個人資料。',
                        style: MyStyles.kTextStyleSubtitle1Bold.copyWith(
                          color: MyStyles.tripTertiary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 37,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyWebButton(
                      label: '取消',
                      style: MyWebButton.styleMediumFillGrey(),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    MyWebButton(
                      label: '確認',
                      style: check
                          ? MyWebButton.styleMediumFilledGreen()
                          : MyWebButton.styleMediumFillGrey(),
                      onPressed: check
                          ? () {
                              Get.back(result: check);
                            }
                          : () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    ),
  );
}

joinScheduleSuccess() {
  return Center(
    child: SizedBox(
      width: 672,
      height: 578,
      child: StatefulBuilder(
        builder: (context, StateSetter setState) {
          return Material(
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 88,
                right: 88,
                top: 52,
                bottom: 67,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '活動報名成功：',
                    style: MyStyles.kTextStyleH2Bold.copyWith(),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    '恭喜！你已成功報名，請加入活動群組以便即時通知集合資訊！',
                    style: MyStyles.kTextStyleH3.copyWith(),
                    textAlign: TextAlign.center,
                  ),
                  const Flexible(
                    child: Center(
                      child: SizedBox(
                        width: 147,
                        height: 147,
                        child: FittedBox(
                          child: Icon(
                            Icons.check_circle,
                            color: MyStyles.yellow3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 208,
                        height: 65,
                        child: MyFilledButton(
                          label: '追蹤訂單',
                          style: MyFilledButton.styleGreenBigWhite2(),
                          onPressed: () {
                            Get.back(result: '追蹤訂單');
                          },
                        ),
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      SizedBox(
                        width: 208,
                        height: 65,
                        child: MyFilledButton(
                          label: '查看更多活動',
                          style: MyFilledButton.styleGreenBigWhite2(),
                          onPressed: () {
                            Get.back(result: '查看更多活動');
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

cancelSchedule() {
  return Center(
    child: SizedBox(
      width: 451,
      height: 385,
      child: StatefulBuilder(
        builder: (context, StateSetter setState) {
          return Material(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: SizedBox(
                    width: 147,
                    height: 147,
                    child: FittedBox(
                      child: Icon(
                        Icons.check_circle,
                        color: MyStyles.yellow3,
                      ),
                    ),
                  ),
                ),
                Text(
                  '取消報名成功',
                  style: MyStyles.kTextStyleH3.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: MyStyles.greyScale616161,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 208,
                  height: 65,
                  child: MyFilledButton(
                    label: '確認',
                    style: MyFilledButton.styleGreenBigWhite2(),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
