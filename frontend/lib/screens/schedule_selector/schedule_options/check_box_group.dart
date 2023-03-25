import 'package:flutter/material.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/screens/schedule_selector/customized_dropdown_button/customized_dropdown_button.dart';

enum CheckBoxOptionMode { single, multiple }

enum ScheduleOptionType { checkbox, datePicker }

class ScheduleOptionCheckSelector extends StatefulWidget {
  const ScheduleOptionCheckSelector({
    Key? key,
    required this.title,
    required this.allItems,
    required this.onChangeCallback,
    this.selectedItems,
    this.mode = CheckBoxOptionMode.single,
    this.selectorOptionType = ScheduleOptionType.checkbox,
    this.width = 100,
  }) : super(key: key);

  final String title;
  final List<String> allItems;
  final List<dynamic>? selectedItems;
  final Function(dynamic) onChangeCallback;
  final CheckBoxOptionMode mode;
  final ScheduleOptionType selectorOptionType;
  final double width;

  @override
  State<ScheduleOptionCheckSelector> createState() =>
      _ScheduleOptionCheckSelectorState();
}

class _ScheduleOptionCheckSelectorState
    extends State<ScheduleOptionCheckSelector> {
  late List<dynamic> selectedItems;
  late List<String> items;

  DateTime? selectedDate;

  @override
  void initState() {
    selectedItems = widget.selectedItems ?? [];
    items = widget.allItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets hintPadding = const EdgeInsets.only(left: 8.0);
    ButtonStyleData buttonStyleData = ButtonStyleData(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: MyStyles.greyScaleE7EAEE,
        ),
      ),
      height: 40,
      width: widget.width,
    );
    MenuItemStyleData menuItemStyleData = const MenuItemStyleData(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
    );
    DropdownStyleData dropdownStyleData = DropdownStyleData(
      width: widget.width, //展開視窗風格
      maxHeight: widget.allItems.length > 8 ? 400 : null,
      offset: const Offset(0, -8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
      child: (widget.selectorOptionType == ScheduleOptionType.datePicker)
          ? DropdownButtonHideUnderline(
              child: CustomizedDropdownButton(
                dropdownMenuType: DropdownMenuType.datePicker,
                dropdownSearchData: DropdownSearchData(
                  //好醜
                  searchInnerWidget: CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2001),
                    lastDate: DateTime(2099),
                    onDateChanged: (DateTime dateTime) {
                      selectedDate = dateTime;
                      setState(() {});
                      selectedItems.add("date1");
                    },
                  ),
                  searchInnerWidgetHeight: 200,
                ),
                isExpanded: true,
                hint: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: hintPadding,
                    child: Text(
                      '${widget.title}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'date1',
                    child: StatefulBuilder(
                      builder: (ctx, menuState) {
                        return InkWell(
                          onTap: () {
                            selectedItems.add("date1");
                            setState(() {});
                          },
                          child: Placeholder(),
                        );
                      },
                    ),
                  ),
                ],
                value: selectedItems.isEmpty ? null : selectedItems.last,
                onChanged: (value) {
                  print(value);
                },
                selectedItemBuilder: (ctx) {
                  return [
                    Center(
                        child: Text(
                            '${selectedDate?.month}月${selectedDate?.day}日'))
                  ];
                },
                buttonStyleData: buttonStyleData,
                dropdownStyleData: dropdownStyleData,
              ),
            )
          :
          //一般check box
          DropdownButtonHideUnderline(
              child: CustomizedDropdownButton(
                isExpanded: true,
                hint: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: hintPadding,
                    child: Text(
                      '${widget.title}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ),

                items: items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    //disable default onTap to avoid closing menu when selecting an item
                    enabled: false,
                    child: StatefulBuilder(
                      builder: (context, menuSetState) {
                        final _isSelected = selectedItems.contains(item);
                        return InkWell(
                          onTap: () {
                            _isSelected
                                ? selectedItems.remove(item)
                                : selectedItems.add(item);
                            //This rebuilds the StatefulWidget to update the button's text
                            setState(() {});
                            //This rebuilds the dropdownMenu Widget to update the check mark
                            menuSetState(() {});
                          },
                          child: Container(
                            height: double.infinity,
                            // padding:
                            //     const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                _isSelected
                                    ? Icon(
                                        Icons.check_box_rounded,
                                        color: MyStyles.tripTertiary,
                                      )
                                    : const Icon(
                                        Icons.check_box_outline_blank,
                                      ),
                                const SizedBox(width: 8),
                                Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
                //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                value: selectedItems.isEmpty ? null : selectedItems.last,
                onChanged: (value) {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2001),
                    lastDate: DateTime(2099),
                  );
                },
                selectedItemBuilder: (context) {
                  return items.map(
                    (item) {
                      return Container(
                        alignment: AlignmentDirectional.center,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          selectedItems.join(', '),
                          style: const TextStyle(
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      );
                    },
                  ).toList();
                },
                buttonStyleData: buttonStyleData,
                menuItemStyleData: menuItemStyleData,
                dropdownStyleData: dropdownStyleData,
              ),
            ),
    );
  }
}
