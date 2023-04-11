import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tripflutter/consts.dart';

import 'modules/auth_service.dart';

class PayMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    FirebaseAuthService authService = Get.find<FirebaseAuthService>();
    if (!authService.isLogin) {
      Future.delayed(Duration(seconds: 1), () {
        Get.back();
        Get.snackbar("提示", "请先登录APP${Get.arguments}");
      });
      return RouteSettings(
          name: "${AppLinks.SCHEDUL}${AppLinks.DETAIL}",
          arguments: Get.arguments); //TODO 想pop回去
    } else {
      print('!authService.isLogin');
      Get.dialog(Center(
        child: Text(
          '你已經登入了： ${authService.user.value}',
        ),
      ));
      return super.redirect(route);
    }
  }
}

class ScheduleMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    FirebaseAuthService authService = Get.find<FirebaseAuthService>();
    if (!authService.isLogin) {
      Future.delayed(Duration(seconds: 1), () {
        Get.back();
        Get.snackbar("提示", "请先登录APP${Get.arguments}");
      });
      return RouteSettings(
          name: "${AppLinks.SCHEDUL}", arguments: Get.arguments); //TODO 想pop回去
    } else {
      print('!authService.isLogin');
      Get.dialog(
        Center(
          child: Text(
            '你已經登入了： ${authService.user.value}',
          ),
        ),
      );
      return super.redirect(route);
    }
  }
}

class EmailVerificationMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    //
    FirebaseAuthService authService = Get.find<FirebaseAuthService>();
    if (!authService.isLogin) {
      Future.delayed(Duration(seconds: 1),
          () => Get.snackbar("提示", "请先登录APP${Get.arguments}"));
      return RouteSettings(name: AppLinks.LOGIN);
    } else {
      print('!authService.isLogin');
      Get.dialog(Center(
        child: Text(
          '你已經登入了： ${authService.user.value}',
        ),
      ));
      return super.redirect(route);
    }
  }
}
