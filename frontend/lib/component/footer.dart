import 'package:flutter/material.dart';
import 'package:tripflutter/consts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      color: MyStyles.tripSecondary,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: kCardWidth, minHeight: kFooterHeight),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Get.toNamed('${AppLinks.TEST}');
                        launchUrlString(
                            'https://www.facebook.com/groups/129528063740264/');
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
                  ],
                ),
              ),
              const Divider(
                color: Colors.white,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '''Email｜services@thma.org.tw
電話｜02-22500059、22501129、22501126 
留守專機｜0919-309020、0919-309039 
傳真｜02-22502159
辦公時間｜每星期二、四晚上7:00-9:00
郵政信箱｜22099 新北市板橋郵政52號信箱 
地址｜22049 新北市板橋區陽明街76號5樓（離捷運新埔站 5 分鐘路程）''',
                    style: MyStyles.kTextStyleBody1.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  if (width > 910)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '下載 GPX 離線導覽地圖，確保旅途平安',
                              style: MyStyles.kTextStyleBody1.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    launchUrlString(
                                        'https://www.apple.com/tw/app-store/');
                                  },
                                  child: Image.asset(
                                    'assets/images/app_store.png',
                                    height: 46,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    launchUrlString(
                                        'https://play.google.com/store/apps');
                                  },
                                  child: Image.asset(
                                    'assets/images/play_store.png',
                                    height: 46,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Image.asset(
                            'assets/images/link_qrcode.png',
                            width: 118,
                            height: 118,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
