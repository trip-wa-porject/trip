import 'package:flutter/material.dart';

import '../consts.dart';

class MyOutlinedButton extends StatelessWidget {
  const MyOutlinedButton(
      {Key? key, required this.label, this.style, this.onPressed})
      : super(key: key);

  final String label;
  final ButtonStyle? style;
  final void Function()? onPressed;

  //白底
  static ButtonStyle style1() {
    return OutlinedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: MyStyles.greyScale424242,
      textStyle: MyStyles.kTextStyleBody1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      side: const BorderSide(width: 1.0, color: MyStyles.tripPrimary),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 24,
      ),
    );
  }

  //米色
  static ButtonStyle style2() {
    return OutlinedButton.styleFrom(
      backgroundColor: MyStyles.tripNeutral,
      foregroundColor: MyStyles.greyScale000000,
      textStyle: MyStyles.kTextStyleBody1,
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: MyStyles.tripTertiary),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 24,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: OutlinedButton(
        style: style,
        onPressed: onPressed,
        child: Center(
          child: Text(label),
        ),
      ),
    );
  }
}

class MyFilledButton extends StatelessWidget {
  const MyFilledButton(
      {Key? key, required this.label, this.style, this.onPressed})
      : super(key: key);

  final String label;
  final ButtonStyle? style;
  final void Function()? onPressed;

  //綠色 白字 搜尋
  static ButtonStyle styleWhiteSmallGreen() {
    return FilledButton.styleFrom(
      backgroundColor: MyStyles.tripNeutral,
      foregroundColor: MyStyles.greyScale757575,
      textStyle: MyStyles.kTextStyleBody1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }

  //綠色 白字 搜尋
  static ButtonStyle style1() {
    return FilledButton.styleFrom(
      backgroundColor: MyStyles.tripTertiary,
      foregroundColor: Colors.white,
      textStyle: MyStyles.kTextStyleBody1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 24,
      ),
    );
  }

  //綠色 白字
  static ButtonStyle styleGreenBigWhite() {
    return FilledButton.styleFrom(
      backgroundColor: MyStyles.tripTertiary,
      foregroundColor: Colors.white,
      textStyle: MyStyles.kTextStyleH3,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // padding: const EdgeInsets.symmetric(
      //   vertical: 15,
      //   horizontal: 79.5,
      // ),
    );
  }

  static ButtonStyle styleGreenBigWhite2() {
    return FilledButton.styleFrom(
      backgroundColor: MyStyles.tripTertiary,
      foregroundColor: Colors.white,
      textStyle: MyStyles.kTextStyleH3,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // padding: const EdgeInsets.symmetric(
      //   vertical: 15,
      //   horizontal: 54.5,
      // ),
    );
  }

  //橘色 黑字
  static ButtonStyle style2() {
    return FilledButton.styleFrom(
      backgroundColor: MyStyles.primary,
      foregroundColor: MyStyles.greyScale000000,
      textStyle: MyStyles.kTextStyleBody1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // side: const BorderSide(width: 1.0, color: MyStyles.primary),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 24,
      ),
    );
  }

  //橘色 黑字
  static ButtonStyle styleOrangeBigBlack() {
    return FilledButton.styleFrom(
      backgroundColor: MyStyles.primary,
      foregroundColor: MyStyles.greyScale000000,
      textStyle: MyStyles.kTextStyleH3Bold,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }

  //橘色 黑字
  static ButtonStyle styleOrangeSmallBlack() {
    return FilledButton.styleFrom(
      backgroundColor: MyStyles.primary,
      foregroundColor: MyStyles.greyScale000000,
      textStyle: MyStyles.kTextStyleBody1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // side: const BorderSide(width: 1.0, color: MyStyles.primary),
      padding: const EdgeInsets.symmetric(
        vertical: 9,
        horizontal: 14,
      ),
    );
  }

  //紅底 白字
  static ButtonStyle styleRedSmallWhite() {
    return FilledButton.styleFrom(
      backgroundColor: MyStyles.redC80000,
      foregroundColor: Colors.white,
      textStyle: MyStyles.kTextStyleBody1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // side: const BorderSide(width: 1.0, color: MyStyles.primary),
      padding: const EdgeInsets.symmetric(
        vertical: 9,
        horizontal: 14,
      ),
    );
  }

  //紅底 白字
  static ButtonStyle styleRedBigWhite() {
    return FilledButton.styleFrom(
      backgroundColor: MyStyles.redC80000,
      foregroundColor: Colors.white,
      textStyle: MyStyles.kTextStyleH3,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // padding: const EdgeInsets.symmetric(
      //   vertical: 15,
      //   horizontal: 79.5,
      // ),
    );
  }

  //橘色 黑字 大的
  static ButtonStyle style3() {
    return FilledButton.styleFrom(
      backgroundColor: MyStyles.primary,
      foregroundColor: MyStyles.greyScale000000,
      textStyle: MyStyles.kTextStyleH3,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // side: const BorderSide(width: 1.0, color: MyStyles.primary),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 24,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: FilledButton(
        style: style,
        onPressed: onPressed,
        child: Center(
          child: Text(label),
        ),
      ),
    );
  }
}
