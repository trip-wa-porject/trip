import 'package:flutter/material.dart';

enum CheckBoxOptionMode { single, multiple }

enum CheckBoxOptionAxisMode { vertical, horizontal }

class ScheduleOptionCheckBoxGroup extends StatefulWidget {
  const ScheduleOptionCheckBoxGroup({
    Key? key,
    required this.title,
    required this.allItem,
    required this.onChangeCallback,
    this.selectedItems,
    this.mode = CheckBoxOptionMode.single,
    this.axisMode = CheckBoxOptionAxisMode.vertical,
  }) : super(key: key);

  final String title;
  final List<dynamic> allItem;
  final List<dynamic>? selectedItems;
  final Function(dynamic) onChangeCallback;
  final CheckBoxOptionMode mode;
  final CheckBoxOptionAxisMode axisMode;

  @override
  State<ScheduleOptionCheckBoxGroup> createState() =>
      _ScheduleOptionCheckBoxGroupState();
}

class _ScheduleOptionCheckBoxGroupState
    extends State<ScheduleOptionCheckBoxGroup> {
  late List<dynamic> selectedItems;
  @override
  void initState() {
    selectedItems = widget.selectedItems ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('路線等級'),
          Flex(
            direction: Axis.vertical,
            children: widget.allItem
                .map((e) => Row(
                      children: [
                        Checkbox(
                            value: selectedItems.contains(e),
                            onChanged: (value) {
                              setState(() {
                                if (widget.mode == CheckBoxOptionMode.single) {
                                  if (value == true) {
                                    selectedItems.clear();
                                    selectedItems.add(e);
                                  } else {
                                    selectedItems.clear();
                                  }
                                } else {
                                  if (value == true) {
                                    selectedItems.add(e);
                                  } else {
                                    selectedItems.remove(e);
                                  }
                                }

                                widget.onChangeCallback(selectedItems);
                              });
                            }),
                        Text("$e"),
                      ],
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
