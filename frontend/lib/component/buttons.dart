import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts.dart';

//
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
        vertical: 20,
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
        vertical: 20,
        horizontal: 24,
      ),
    );
  }

  //淺綠色/綠邊框/綠字
  static ButtonStyle style3() {
    return OutlinedButton.styleFrom(
      backgroundColor: MyStyles.green4,
      foregroundColor: MyStyles.tripTertiary,
      textStyle: MyStyles.kTextStyleBody1,
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: MyStyles.tripTertiary),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 24,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 40,
      child: OutlinedButton(
        style: style,
        onPressed: onPressed,
        child: Text(label),
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
        vertical: 20,
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

  //綠色 白字
  static ButtonStyle styleGreenWhiteH4() {
    return FilledButton.styleFrom(
      backgroundColor: MyStyles.tripTertiary,
      foregroundColor: Colors.white,
      textStyle: MyStyles.kTextStyleH4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.symmetric(
        vertical: 12.5,
      ),
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
        vertical: 20,
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

  //橘色 白字 大的
  static ButtonStyle style3() {
    return FilledButton.styleFrom(
      backgroundColor: MyStyles.primary,
      foregroundColor: MyStyles.white,
      textStyle: MyStyles.kTextStyleH4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
    );
  }

  //橘色
  static ButtonStyle styleOrangeBorder() {
    return FilledButton.styleFrom(
      backgroundColor: const Color(0xfffff9ee),
      foregroundColor: MyStyles.tripPrimary,
      textStyle: MyStyles.kTextStyleH4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      side: const BorderSide(width: 1.0, color: MyStyles.primary),
      padding: const EdgeInsets.symmetric(vertical: 12.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: style,
      onPressed: onPressed,
      child: Center(
        child: Text(label),
      ),
    );
  }
}

class MyWebButton extends StatelessWidget {
  MyWebButton({
    Key? key,
    required this.label,
    this.icon,
    this.iconData,
    this.style,
    this.onPressed,
    this.futureFunction,
  }) : super(key: key);

  final String label;
  final Widget? icon;
  final IconData? iconData;
  final ButtonStyle? style;
  final void Function()? onPressed;
  final Future Function()? futureFunction;
  final RxBool isLoading = false.obs;

  static ButtonStyle styleSmallFilled() {
    return FilledButton.styleFrom(
        backgroundColor: MyStyles.tripTertiary,
        foregroundColor: MyStyles.white,
        textStyle: MyStyles.kTextStyleButtonS,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        side: const BorderSide(width: 1.0, color: MyStyles.tripTertiary),
        padding: const EdgeInsets.symmetric(vertical: 10),
        fixedSize: const Size(77, 40));
  }

  static ButtonStyle styleSmallFilledForShare() {
    return FilledButton.styleFrom(
        backgroundColor: MyStyles.tripTertiary,
        foregroundColor: MyStyles.white,
        textStyle: MyStyles.kTextStyleButtonS,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        side: const BorderSide(width: 1.0, color: MyStyles.tripTertiary),
        padding: const EdgeInsets.symmetric(vertical: 10),
        fixedSize: const Size(70, 40));
  }

  static ButtonStyle styleSmallFilledForLogin() {
    return FilledButton.styleFrom(
        backgroundColor: const Color(0xfff8fdef),
        foregroundColor: Color(0xff417619),
        textStyle:
            MyStyles.kTextStyleButtonS.copyWith(fontWeight: FontWeight.w500),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.symmetric(vertical: 10),
        fixedSize: const Size(77, 40));
  }

  static ButtonStyle styleSmallFilledForSignUp() {
    return FilledButton.styleFrom(
        backgroundColor: MyStyles.tripTertiary,
        foregroundColor: Colors.white,
        textStyle: MyStyles.kTextStyleButtonS,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        side: const BorderSide(width: 1.0, color: Color(0xffa9b19c)),
        padding: const EdgeInsets.symmetric(vertical: 10),
        fixedSize: const Size(77, 40));
  }

  static ButtonStyle styleSmallOutlined() {
    return FilledButton.styleFrom(
        backgroundColor: const Color(0xfff8fdef),
        foregroundColor: MyStyles.tripTertiary,
        textStyle: MyStyles.kTextStyleButtonS,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        side: const BorderSide(width: 1.0, color: MyStyles.tripTertiary),
        padding: const EdgeInsets.symmetric(vertical: 10),
        fixedSize: const Size(77, 40));
  }

  static ButtonStyle styleMediumFilledGreen() {
    return FilledButton.styleFrom(
        backgroundColor: MyStyles.tripTertiary,
        foregroundColor: MyStyles.white,
        textStyle: MyStyles.kTextStyleButtonM,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        side: const BorderSide(width: 1.0, color: MyStyles.tripTertiary),
        padding: const EdgeInsets.symmetric(vertical: 10),
        fixedSize: const Size(113, 40));
  }

  static ButtonStyle styleMediumFilledOrange() {
    return FilledButton.styleFrom(
        backgroundColor: MyStyles.primary,
        foregroundColor: MyStyles.white,
        textStyle: MyStyles.kTextStyleSubtitle1Bold,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        side: const BorderSide(width: 1.0, color: MyStyles.primary),
        padding: const EdgeInsets.symmetric(vertical: 10),
        fixedSize: const Size(113, 40));
  }

  static ButtonStyle styleMediumOutlinedGreen() {
    return FilledButton.styleFrom(
        backgroundColor: const Color(0xfff8fdef),
        foregroundColor: MyStyles.tripTertiary,
        textStyle: MyStyles.kTextStyleButtonM,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        side: const BorderSide(width: 1.0, color: MyStyles.tripTertiary),
        padding: const EdgeInsets.symmetric(vertical: 10),
        fixedSize: const Size(113, 40));
  }

  static ButtonStyle styleMediumOutlinedOrange() {
    return FilledButton.styleFrom(
        backgroundColor: const Color(0xfffff9ee),
        foregroundColor: MyStyles.primary,
        textStyle: MyStyles.kTextStyleButtonM,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        side: const BorderSide(width: 1.0, color: MyStyles.primary),
        padding: const EdgeInsets.symmetric(vertical: 10),
        fixedSize: const Size(113, 40));
  }

  static ButtonStyle styleMediumFillGrey() {
    return FilledButton.styleFrom(
        backgroundColor: const Color(0xffe5e5e5),
        foregroundColor: const Color(0xff767676),
        textStyle: MyStyles.kTextStyleButtonM,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.symmetric(vertical: 10),
        fixedSize: const Size(113, 40));
  }

  static ButtonStyle styleLargeFillGrey() {
    return FilledButton.styleFrom(
        backgroundColor: const Color(0xffe5e5e5),
        foregroundColor: const Color(0xff767676),
        textStyle: MyStyles.kTextStyleH4M,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.symmetric(vertical: 10),
        fixedSize: const Size(208, 48));
  }

  static ButtonStyle styleLargeFilled() {
    return FilledButton.styleFrom(
        backgroundColor: MyStyles.tripTertiary,
        foregroundColor: MyStyles.white,
        textStyle: MyStyles.kTextStyleH4M,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        side: const BorderSide(width: 1.0, color: MyStyles.tripTertiary),
        padding: const EdgeInsets.symmetric(vertical: 10),
        fixedSize: const Size(208, 48));
  }

  static ButtonStyle styleLargeFilledOrange() {
    return FilledButton.styleFrom(
        backgroundColor: MyStyles.primary,
        foregroundColor: MyStyles.white,
        textStyle: MyStyles.kTextStyleH4M,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.symmetric(vertical: 10),
        fixedSize: const Size(208, 48));
  }

  static ButtonStyle styleLargeOutlined() {
    return FilledButton.styleFrom(
        backgroundColor: const Color(0xfff8fdef),
        foregroundColor: MyStyles.tripTertiary,
        textStyle: MyStyles.kTextStyleH4M,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        side: const BorderSide(width: 1.0, color: MyStyles.tripTertiary),
        padding: const EdgeInsets.symmetric(vertical: 10),
        fixedSize: const Size(208, 48));
  }

  static ButtonStyle styleLargeOutlinedOrange() {
    return FilledButton.styleFrom(
        backgroundColor: const Color(0xfffff9ee),
        foregroundColor: MyStyles.primary,
        textStyle: MyStyles.kTextStyleH4M,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        side: const BorderSide(width: 1.0, color: MyStyles.primary),
        padding: const EdgeInsets.symmetric(vertical: 10),
        fixedSize: const Size(208, 48));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FilledButton(
        style: style,
        onPressed: futureFunction != null
            ? isLoading.value
                ? () {}
                : () async {
                    if (isLoading.value) return;
                    try {
                      isLoading.value = true;
                      await futureFunction!();
                    } catch (e) {
                      //todo
                    } finally {
                      isLoading.value = false;
                    }
                  }
            : onPressed,
        child: Center(
          child: isLoading.value
              ? const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: CupertinoActivityIndicator(),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) icon!,
                    if (icon == null && iconData != null)
                      Icon(
                        iconData,
                        size: 16,
                      ),
                    Text(label),
                  ],
                ),
        ),
      ),
    );
  }
}

class MyAppIconButton extends StatelessWidget {
  const MyAppIconButton({
    Key? key,
    required this.label,
    required this.iconData,
    this.style,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final IconData iconData;
  final ButtonStyle? style;
  final void Function()? onPressed;

  //橘色 淺橘色底色，border
  static ButtonStyle styleOrangeBorder() {
    return OutlinedButton.styleFrom(
      backgroundColor: const Color(0xfffff9ee),
      foregroundColor: MyStyles.tripPrimary,
      textStyle: MyStyles.kTextStyleBody1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      side: const BorderSide(width: 1.0, color: MyStyles.primary),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    );
  }

  //橘色 黑字
  static ButtonStyle styleOrangeFill() {
    return FilledButton.styleFrom(
      backgroundColor: MyStyles.primary,
      foregroundColor: MyStyles.greyScale000000,
      textStyle: MyStyles.kTextStyleBody1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // side: const BorderSide(width: 1.0, color: MyStyles.primary),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    );
  }

  //綠色 白字
  static ButtonStyle styleGreenFill() {
    return FilledButton.styleFrom(
      backgroundColor: MyStyles.tripTertiary,
      foregroundColor: Colors.white,
      textStyle: MyStyles.kTextStyleBody1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // side: const BorderSide(width: 1.0, color: MyStyles.primary),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 40,
      child: FilledButton(
        style: style,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 20,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
