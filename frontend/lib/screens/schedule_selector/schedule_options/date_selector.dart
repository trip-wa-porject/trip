import 'package:flutter/material.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/screens/schedule_selector/customized_dropdown_button/customized_dropdown_button.dart';

class ScheduleOptionDateSelector extends StatelessWidget {
  ScheduleOptionDateSelector({
    Key? key,
    required this.title,
    this.selectedDate,
    this.startDate,
    this.lastDate,
    this.onDateChangeCallback,
    this.width = 100,
  }) : super(key: key);

  final String title;
  final Function(DateTime)? onDateChangeCallback;
  final double width;
  DateTime? selectedDate;
  DateTime? startDate;
  DateTime? lastDate;

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
      width: width,
    );
    MenuItemStyleData menuItemStyleData = const MenuItemStyleData(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
    );
    DropdownStyleData dropdownStyleData = DropdownStyleData(
      width: width, //展開視窗風格
      maxHeight: null,
      offset: const Offset(0, -8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
        child: DropdownButtonHideUnderline(
          child: CustomizedDropdownButton(
            dropdownMenuType: DropdownMenuType.datePicker,
            dropdownSearchData: DropdownSearchData(
              //好醜
              searchInnerWidget: CalendarDatePicker(
                initialDate: startDate ?? DateTime.now(),
                firstDate: startDate ?? DateTime.now(),
                lastDate: lastDate ?? DateTime(2099),
                onDateChanged: (DateTime dateTime) {
                  if (onDateChangeCallback != null) {
                    onDateChangeCallback!(dateTime);
                  }
                },
              ),
              searchInnerWidgetHeight: 200,
            ),
            isExpanded: true,
            hint: selectedDate != null
                ? Center(
                    child: Text('${selectedDate?.month}月${selectedDate?.day}日'))
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: hintPadding,
                      child: Text(
                        '${title}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                  ),
            value: selectedDate,
            onChanged: (value) {
              print(value);
            },
            buttonStyleData: buttonStyleData,
            dropdownStyleData: dropdownStyleData,
          ),
        ));
  }
}
