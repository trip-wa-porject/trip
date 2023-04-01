import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/consts.dart';

class ScheduleApply extends StatelessWidget {
  const ScheduleApply({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: SizedBox(
            width: 620,
            height: 330,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(18.0),
                  topLeft: Radius.circular(18.0),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/popup_mountain.png'),
                  fit: BoxFit.none,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Image.asset('assets/images/popup_close.png'),
                        iconSize: 50,
                        onPressed: () => Get.back(),
                      ),
                    ),
                    const Center(
                      child: Text(
                        '恭喜您報名成功！',
                        style: TextStyle(
                            fontSize: 36, color: MyStyles.greyScale424242),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
