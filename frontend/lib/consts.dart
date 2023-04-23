import 'package:flutter/material.dart';

///使用方法例子
///MyStyles.tripPrimary
///MyStyles.kTextStyleH1
///MyStyles.kTextStyleH1.copyWith(color: MyStyles.tripPrimary)
class MyStyles {
  //Colors

  /// 橘色
  static const Color tripPrimary = Color(0xffEA9F49);
  static const Color tripPrimary50 = Color(0x50EA9F49);

  ///淺橘色
  static const Color primary = Color(0xFFF6BD79);

  ///棕色
  static const Color tripSecondary = Color(0xff998167);

  ///綠色
  static const Color tripTertiary = Color(0xff778C67);

  ///淺色
  static const Color tripNeutral = Color(0xffF6F2EA);

  ///紅色
  static const Color redC80000 = Color(0xffC80000);

  ///次要色
  ///
  static const Color secondaryE1D5C9 = Color(0xffE1D5C9);
  static const Color green1 = Color(0xffDDE1DA);
  static const Color green2 = Color(0xffC8CABE);
  static const Color green3 = Color(0xffA9B19C);
  static const Color yellow1 = Color(0xffF4F1D5);
  static const Color yellow2 = Color(0xffF0EEC9);
  static const Color yellow3 = Color(0xffEDD9A1);

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
  static const Color greyScaleF4F4F4 = Color(0xffF4F4F4);

//TextStyles
  static const TextStyle kTextStyleH1 = TextStyle(
    fontSize: 44,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.25,
  );

  static const TextStyle kTextStyleH2Bold = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.25,
  );

  static const TextStyle kTextStyleH2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
  );
  static const TextStyle kTextStyleH2Normal = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
  );
  static const TextStyle kTextStyleH3Bold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.15,
  );

  static const TextStyle kTextStyleH3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.15,
  );

  static const TextStyle kTextStyleH4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.15,
  );

  @Deprecated('棄用')
  static const TextStyle kTextStyleNormal = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
  );
  //sub bold
  static const TextStyle kTextStyleSubtitle1Bold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.15,
  );

  //sub regular
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
double kSearchBarTopPadding = 20;
double kSearchBarBottomPadding = 124;
double kScheduleOptionsHeight = 180;
double kCardHeight = 174;
double kCardWidth = 1160;
double kEmptyImageHeight = 493;
double kEmptyImageWidth = 551;
double kFooterHeight = 389;

class AppLinks {
  static const String MAIN = '';
  static const String LOGIN = "/login";
  static const String SIGNUP = "/signup";
  static const String PAY = '/pay';
  static const String SCHEDUL = '/schedule';
  static const String DETAIL = '/detail';
  static const String TEST = "/test";
  static const String MANAGEMENT = '/management';
  static const String HOME = '/home';
  static const String GPX = '/gpx';
}
