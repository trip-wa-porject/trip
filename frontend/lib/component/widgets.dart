import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 143.22,
      height: 39.32,
      child: InkWell(
        onTap: () {
          Get.toNamed('${AppLinks.SCHEDUL}');
        },
        child: Placeholder(
          color: Colors.white,
        ),
      ),
    );
  }
}

//bg image
class BgImage extends StatelessWidget {
  const BgImage({Key? key, this.child}) : super(key: key);

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 470,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/main_bg.png',
            height: 470,
            fit: BoxFit.cover,
            color: MyStyles.greyScale000000.withOpacity(.5),
            colorBlendMode: BlendMode.overlay,
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}

//back button
class MyBackButton extends StatelessWidget {
  const MyBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      constraints: BoxConstraints(maxWidth: kCardWidth),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: MyStyles.greyScale212121),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          Text('back'),
        ],
      ),
    );
  }
}
