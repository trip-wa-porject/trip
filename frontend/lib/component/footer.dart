import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/screens/api_test_page/api_test.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kFooterHeight,
      alignment: Alignment.center,
      color: MyStyles.tripSecondary,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: kCardWidth),
          child: FittedBox(
            child: SizedBox(
              width: kCardWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('${AppLinks.TEST}');
                    },
                    child: const Icon(
                      Icons.facebook,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    '新北市山岳協會',
                    style: MyStyles.kTextStyleBody1.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '''Email｜services@thma.org.tw
電話｜02-22500059、22501129、22501126 
留守專機｜0919-309020、0919-309039 
傳真｜02-22502159''',
                        style: MyStyles.kTextStyleBody1.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '''辦公時間｜每星期二、四晚上7:00-9:00
郵政信箱｜22099 新北市板橋郵政52號信箱 
地址｜22049 新北市板橋區陽明街76號5樓（離捷運新埔站 5 分鐘路程）''',
                        style: MyStyles.kTextStyleBody1.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
