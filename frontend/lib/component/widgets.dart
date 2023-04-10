import 'package:flutter/material.dart';

import '../consts.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 151,
      height: 57,
      child: Placeholder(
        color: Colors.white,
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
