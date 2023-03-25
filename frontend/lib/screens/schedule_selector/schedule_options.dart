import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/screens/schedule_selector/schedule_selector_controller.dart';

import 'schedule_options/check_box_group.dart';

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
                  ScheduleOptionCheckSelector(
                    title: "類型",
                    width: 120,
                    allItems:
                        TypeOption.values.map((e) => e.showedString).toList(),
                    onChangeCallback: (dynamic value) {
                      print(value);
                    },
                  ),
                  SizedBox(
                    width: spacerWidth,
                  ),
                  ScheduleOptionCheckSelector(
                    title: "等級",
                    width: 220,
                    allItems:
                        LevelOption.values.map((e) => e.showedString).toList(),
                    mode: CheckBoxOptionMode.multiple,
                    onChangeCallback: (dynamic value) {
                      print(value);
                    },
                  ),
                  SizedBox(
                    width: spacerWidth,
                  ),
                  ScheduleOptionCheckSelector(
                    title: "區域",
                    width: 100,
                    allItems:
                        AreaOption.values.map((e) => e.showedString).toList(),
                    onChangeCallback: (dynamic value) {
                      print(value);
                    },
                  ),
                  SizedBox(
                    width: spacerWidth,
                  ),
                  ScheduleOptionCheckSelector(
                    title: "天數",
                    width: 120,
                    allItems:
                        DayOption.values.map((e) => e.showedString).toList(),
                    mode: CheckBoxOptionMode.multiple,
                    onChangeCallback: (dynamic value) {
                      print(value);
                    },
                  ),
                  SizedBox(
                    width: spacerWidth,
                  ),
                  ScheduleOptionCheckSelector(
                    title: "行程預算",
                    width: 200,
                    allItems:
                        PriceOption.values.map((e) => e.showedString).toList(),
                    mode: CheckBoxOptionMode.multiple,
                    onChangeCallback: (dynamic value) {
                      print(value);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  ScheduleOptionCheckSelector(
                    title: "起始日期",
                    width: 360,
                    allItems: [],
                    selectorOptionType: ScheduleOptionType.datePicker,
                    onChangeCallback: (dynamic value) {
                      print(value);
                    },
                  ),
                  SizedBox(
                    width: spacerWidth,
                  ),
                  ScheduleOptionCheckSelector(
                    title: "結束日期",
                    width: 360,
                    allItems: [],
                    selectorOptionType: ScheduleOptionType.datePicker,
                    onChangeCallback: (dynamic value) {
                      print(value);
                    },
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
                          Checkbox(
                            value: true,
                            onChanged: (value) {},
                            activeColor: MyStyles.tripTertiary,
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
