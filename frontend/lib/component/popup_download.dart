import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/consts.dart';

class PopupDownload extends StatelessWidget {
  const PopupDownload({super.key});

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
                  image: AssetImage('assets/images/popup_map.png'),
                  fit: BoxFit.none,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Image.asset('assets/images/popup_close.png'),
                        iconSize: 50,
                        onPressed: () => Get.back(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: const [
                          Text(
                            '已成功下載 GPX！',
                            style: TextStyle(
                                fontSize: 36, color: MyStyles.greyScale424242),
                          ),
                          Icon(
                            size: 125,
                            Icons.file_download_outlined,
                            color: MyStyles.greyScale424242,
                          ),
                        ],
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
