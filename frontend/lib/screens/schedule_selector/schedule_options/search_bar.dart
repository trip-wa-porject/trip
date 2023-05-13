import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:tripflutter/screens/schedule_selector/schedule_selector_controller.dart';

import '../../../consts.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({Key? key, this.controller}) : super(key: key);

  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Align(
        alignment: Alignment.topCenter,
        //TODO check padding
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: SizedBox(
            height: kSearchBarHeight,
            width: constrains.maxWidth,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kSearchBarHeight),
                      color: Colors.white.withOpacity(.7),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 48,
                          height: 48,
                          child: Icon(
                            Icons.search,
                            color: MyStyles.greyScale757575,
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              hintText: '請輸入活動編號、活動名稱',
                              hintStyle: MyStyles.kTextStyleSubtitle1.copyWith(
                                color: MyStyles.greyScale757575,
                              ),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (value) {
                              Get.put(ScheduleSelectorController()).search();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
