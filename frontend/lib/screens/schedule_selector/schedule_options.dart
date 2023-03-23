import 'package:flutter/material.dart';

import 'schedule_options/check_box_group.dart';

class ScheduleOptions extends StatelessWidget {
  const ScheduleOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          ScheduleOptionCheckBoxGroup(
            title: "路線等級",
            allItem: ['A', 'B', 'C'],
            onChangeCallback: (dynamic value) {
              print(value);
            },
          ),
          ScheduleOptionCheckBoxGroup(
            title: "區域",
            allItem: ['北部', '中部', '南部'],
            mode: CheckBoxOptionMode.multiple,
            onChangeCallback: (dynamic value) {
              print(value);
            },
          ),
        ],
      ),
    );
  }
}
