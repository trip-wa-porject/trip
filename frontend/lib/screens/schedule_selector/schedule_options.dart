import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:tripflutter/component/buttons.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/screens/schedule_selector/schedule_selector_controller.dart';

import 'schedule_options/check_box_group.dart';
import 'schedule_options/date_selector.dart';

//total height = 180
class ScheduleOptions extends GetView<ScheduleSelectorController> {
  const ScheduleOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ScheduleSelectorController());
    double spacerWidth = 8.0;

    return Card(
      elevation: 10.0,
      color: MyStyles.secondaryE1D5C9,
      surfaceTintColor: Colors.transparent,
      margin: const EdgeInsets.all(0.0),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 18.0, right: 18, top: 20, bottom: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 40.0,
              child: Row(
                children: [
                  Obx(
                    () => ScheduleOptionCheckSelector<TypeOption>(
                      title: "類型",
                      width: 125,
                      selectedItems: controller.typeOptions.toList(),
                      borderColor: Colors.transparent,
                      allItems: TypeOption.values,
                      mode: CheckBoxOptionMode.multiple,
                      onChangeCallback: (List<TypeOption> value) {
                        controller.selectTypeOption(value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: spacerWidth,
                  ),
                  Obx(
                    () => ScheduleOptionCheckSelector<LevelOption>(
                      title: "等級",
                      width: 220,
                      allItems: LevelOption.values,
                      mode: CheckBoxOptionMode.multiple,
                      selectedItems: controller.levelOptions.toList(),
                      borderColor: Colors.transparent,
                      onChangeCallback: (List<LevelOption> value) {
                        controller.selectLevelOption(value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: spacerWidth,
                  ),
                  Obx(
                    () => ScheduleOptionCheckSelector<AreaOption>(
                      title: "區域",
                      width: 120,
                      allItems: AreaOption.values,
                      selectedItems: controller.areaOptions.toList(),
                      mode: CheckBoxOptionMode.multiple,
                      borderColor: Colors.transparent,
                      onChangeCallback: (value) {
                        controller.selectAreaOption(value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: spacerWidth,
                  ),
                  Obx(
                    () => ScheduleOptionCheckSelector<DayOption>(
                      title: "天數",
                      width: 120,
                      allItems: DayOption.values,
                      mode: CheckBoxOptionMode.multiple,
                      selectedItems: controller.dayOptions.toList(),
                      borderColor: Colors.transparent,
                      onChangeCallback: (value) {
                        controller.selectDayOption(value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: spacerWidth,
                  ),
                  Obx(
                    () => ScheduleOptionCheckSelector<PriceOption>(
                      title: "行程預算",
                      width: 240,
                      allItems: PriceOption.values,
                      selectedItems: controller.priceOptions.toList(),
                      borderColor: Colors.transparent,
                      mode: CheckBoxOptionMode.multiple,
                      onChangeCallback: (value) {
                        controller.selectPriceOption(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Obx(
                    () => ScheduleOptionDateSelector(
                      title: "起始日期",
                      width: 360,
                      selectedDate: controller.selectedStartDateTime.value,
                      lastDate: controller.selectedEndDateTime.value,
                      isClockwise: true,
                      borderColor: Colors.transparent,
                      onDateChangeCallback: (DateTime dateTime) {
                        controller.selectStartDate(dateTime);
                      },
                    ),
                  ),
                  SizedBox(
                    width: spacerWidth,
                  ),
                  Obx(
                    () => ScheduleOptionDateSelector(
                      title: "結束日期",
                      width: 360,
                      startDate: controller.selectedStartDateTime.value,
                      selectedDate: controller.selectedEndDateTime.value,
                      isClockwise: true,
                      borderColor: Colors.transparent,
                      onDateChangeCallback: (DateTime dateTime) {
                        controller.selectEndDate(dateTime);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        '顯示: ',
                        style: MyStyles.kTextStyleBody1.copyWith(
                          color: MyStyles.greyScale616161,
                        ),
                      ),
                      Obx(
                        () => Checkbox(
                          value: controller.hasSeat.value,
                          onChanged: (value) {
                            controller.selectHasSeat(value!);
                          },
                          activeColor: MyStyles.tripTertiary,
                        ),
                      ),
                      Text(
                        '尚有名額',
                        style: MyStyles.kTextStyleBody1.copyWith(
                          color: MyStyles.greyScale000000,
                        ),
                      ), //TODO check box
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            controller.clearAllSelected();
                          },
                          child: const SizedBox(
                            height: 40,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                '清除所有',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: MyStyles.tripTertiary,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          )),
                      const SizedBox(
                        width: 16.0,
                      ),
                      MyWebButton(
                        label: '搜尋',
                        style: MyWebButton.styleSmallFilled(),
                        onPressed: () {
                          controller.search();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
