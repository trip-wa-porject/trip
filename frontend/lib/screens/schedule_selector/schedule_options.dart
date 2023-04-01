import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/screens/schedule_selector/schedule_selector_controller.dart';

import 'schedule_options/check_box_group.dart';
import 'schedule_options/date_selector.dart';

class ScheduleOptions extends GetView<ScheduleSelectorController> {
  const ScheduleOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ScheduleSelectorController());
    double spacerWidth = 16.0;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 24.0,
        horizontal: 0.0,
      ),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Obx(
                    () => ScheduleOptionCheckSelector<TypeOption>(
                      title: "類型",
                      width: 140,
                      selectedItems: controller.typeOptions.toList(),
                      allItems: TypeOption.values,
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
                      width: 204,
                      allItems: LevelOption.values,
                      mode: CheckBoxOptionMode.multiple,
                      selectedItems: controller.levelOptions.toList(),
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
                      mode: CheckBoxOptionMode.multiple,
                      onChangeCallback: (value) {
                        controller.selectPriceOption(value);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Obx(
                    () => ScheduleOptionDateSelector(
                      title: "起始日期",
                      width: 360,
                      selectedDate: controller.selectedStartDateTime.value,
                      lastDate: controller.selectedEndDateTime.value,
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
                      onDateChangeCallback: (DateTime dateTime) {
                        controller.selectEndDate(dateTime);
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('顯示: '),
                          Obx(
                            () => Checkbox(
                              value: controller.hasSeat.value,
                              onChanged: (value) {
                                controller.selectHasSeat(value!);
                              },
                              activeColor: MyStyles.tripTertiary,
                            ),
                          ),
                          Text('尚有名額'), //TODO check box
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.clearAllSelected();
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.filter_list_alt),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  '清除所有',
                                  style: MyStyles.kTextStyleBody1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          SizedBox(
                            width: 200,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: MyStyles.tripTertiary,
                                textStyle: MyStyles.kTextStyleH3,
                              ),
                              onPressed: () {
                                controller.search();
                              },
                              child: Center(child: Text('搜尋')),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
