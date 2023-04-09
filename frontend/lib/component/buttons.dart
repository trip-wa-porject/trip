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

  //橘色 黑字
  static ButtonStyle style2() {
    return FilledButton.styleFrom(
      backgroundColor: MyStyles.tripPrimary,
      foregroundColor: MyStyles.greyScale000000,
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
