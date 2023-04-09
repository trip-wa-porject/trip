import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:tripflutter/component/footer.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/screens/schedule_selector/schedule_selector_controller.dart';

import '../schedule_detail/schdule_detail.dart';
import 'schedule_card.dart';
import '../../models/schedule_model.dart';
import 'schedule_options.dart';
import 'package:get/get.dart';

import 'schedule_options/search_bar.dart';

class ScheduleSelector extends GetView<ScheduleSelectorController> {
  const ScheduleSelector({Key? key}) : super(key: key);

  Widget buildFloatingSearchBar(BuildContext context) {
    return MySearchBar(
      controller: controller.searchTextController,
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ScheduleSelectorController());
    return Obx(() {
      late double paintHeight;
      if (controller.scheduleList.isEmpty) {
        paintHeight = 470 + 145 + kEmptyImageHeight + 160 + 225 + kFooterHeight;
      } else {
        paintHeight = 470 +
            145 +
            controller.scheduleList.length * kCardHeight +
            225 +
            kFooterHeight;
      }
      return SingleChildScrollView(
        child: Stack(
          children: [
            //背景圖片
            SizedBox(
              height: 470,
              width: double.infinity,
              child: Image.asset(
                'assets/images/main_bg.png',
                height: 470,
                fit: BoxFit.cover,
                color: MyStyles.greyScale000000.withOpacity(.5),
                colorBlendMode: BlendMode.overlay,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: paintHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 126.0,
                    ),
                    Text(
                      '美好的登山體驗，從輕鬆選擇行程開始',
                      style: MyStyles.kTextStyleH2Bold
                          .copyWith(color: Colors.white),
                    ),
                    Flexible(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 4,
                            top: kSearchBarHeight +
                                kSearchBarTopPadding +
                                kSearchBarBottomPadding,
                            right: 4,
                            child: Center(
                              child: SizedBox(
                                height: kScheduleOptionsHeight,
                                width: kCardWidth + 8.0,
                                child: ScheduleOptions(),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: kSearchBarHeight +
                                kSearchBarTopPadding +
                                kSearchBarBottomPadding +
                                kScheduleOptionsHeight +
                                55,
                            right: 0,
                            bottom: 0,
                            child: Obx(() {
                              if (controller.isLoading.value) {
                                return const Align(
                                  alignment: Alignment.topCenter,
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (controller.scheduleList.isEmpty) {
                                //no data
                                return SizedBox(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 15.0,
                                          bottom: 92,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '很抱歉，目前沒有相關行程，請重新搜尋ＱＱ',
                                            style:
                                                MyStyles.kTextStyleH1.copyWith(
                                              color: MyStyles.greyScale616161,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/images/empty.png',
                                        width: kEmptyImageWidth,
                                        height: kEmptyImageHeight,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return ListView.separated(
                                cacheExtent: kCardHeight,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.scheduleList.length,
                                itemBuilder: (c, index) {
                                  return Center(
                                    child: SizedBox(
                                      height: kCardHeight,
                                      width: kCardWidth + 8.0,
                                      child: ScheduleCard(
                                        model: controller.scheduleList[index],
                                        index: index + 1,
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 16.0,
                                  );
                                },
                              );
                            }),
                          ),
                          Positioned.fill(
                            child: buildFloatingSearchBar(context),
                          ),
                        ],
                      ),
                    ),
                    const Footer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
