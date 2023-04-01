import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
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
    return const MySearchBar();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ScheduleSelectorController());
    return Obx(() {
      late double paintHeight;
      if (controller.scheduleList.isEmpty) {
        paintHeight = Get.size.height + kEmptyImageHeight + 120 + 80;
      } else {
        paintHeight =
            Get.size.height + controller.scheduleList.length * kCardHeight;
      }
      return SizedBox(
        height: paintHeight,
        width: kCardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.directions_walk),
                ),
                Text('登山行程'),
              ],
            ),
            Divider(),
            SizedBox(
              height: 40.0,
            ),
            Flexible(
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: kSearchBarHeight,
                    right: 0,
                    child: const ScheduleOptions(),
                  ),
                  Positioned(
                    left: 0,
                    top: kSearchBarHeight + 180,
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
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border:
                                      Border.all(color: MyStyles.tripNeutral),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 60.0),
                                  child: Center(
                                    child: Text(
                                      '很抱歉，目前沒有相關行程，請重新搜尋ＱＱ',
                                      style: MyStyles.kTextStyleH1.copyWith(
                                          color: MyStyles.greyScale616161),
                                    ),
                                  ),
                                ),
                              ),
                              Image.asset(
                                'assets/images/empty.png',
                                width: kEmptyImageHeight,
                                height: kEmptyImageHeight,
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.separated(
                        cacheExtent: kCardHeight,
                        padding: const EdgeInsets.all(0.0),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.scheduleList.length,
                        itemBuilder: (c, index) {
                          return SizedBox(
                            height: kCardHeight,
                            width: kCardWidth,
                            child: ScheduleCard(
                              model: controller.scheduleList[index],
                              index: index + 1,
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 8.0,
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
          ],
        ),
      );
    });
  }
}
