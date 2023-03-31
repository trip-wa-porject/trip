import 'package:flutter/material.dart';

///使用方法例子
///MyStyles.tripPrimary
///MyStyles.kTextStyleH1
///MyStyles.kTextStyleH1.copyWith(color: MyStyles.tripPrimary)
class MyStyles {
  //Colors

  /// 橘色
  static const Color tripPrimary = Color(0xffEA9F49);

  ///棕色
  static const Color tripSecondary = Color(0xff998167);

  ///綠色
  static const Color tripTertiary = Color(0xff778C67);

  ///淺色
  static const Color tripNeutral = Color(0xffF6F2EA);

  ///灰色們
  static const Color greyScale000000 = Color(0xff000000);
  static const Color greyScale212121 = Color(0xff212121);
  static const Color greyScale424242 = Color(0xff424242);
  static const Color greyScale616161 = Color(0xff616161);
  static const Color greyScale757575 = Color(0xff757575);
  static const Color greyScale9E9E9E = Color(0xff9E9E9E);
  static const Color greyScaleD9D9D9 = Color(0xffD9D9D9);

  ///其他
  static const Color greyScaleE7EAEE = Color(0xffE7EAEE);
  static const Color greyScaleCFCFCE = Color(0xffCFCFCE);
  static const Color greyScale6037392F = Color(0x6037392F);
  static const Color greyScale8037392F = Color(0x8037392F);

//TextStyles
  static const TextStyle kTextStyleH1 = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.25,
  );

  static const TextStyle kTextStyleH2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
  );
  static const TextStyle kTextStyleH3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.15,
  );
  static const TextStyle kTextStyleNormal = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
  );
  static const TextStyle kTextStyleSubtitle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.15,
  );
  static const TextStyle kTextStyleBody1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.25,
  );
}

double kSearchBarHeight = 60.0;
double kCardHeight = 230;
double kEmptyImageHeight = 500;
