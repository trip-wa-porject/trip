import 'package:flutter/material.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/screens/schedule_selector/customized_dropdown_button/customized_dropdown_button.dart';

class ScheduleOptionDateSelector extends StatelessWidget {
  const ScheduleOptionDateSelector({
    Key? key,
    required this.title,
    this.selectedDate,
    this.startDate,
    this.lastDate,
    required this.isClockwise,
    required this.borderColor,
    this.onDateChangeCallback,
    this.width = 100,
  }) : super(key: key);

  final String title;
  final Function(DateTime)? onDateChangeCallback;
  final double width;
  final DateTime? selectedDate;
  final DateTime? startDate;
  final DateTime? lastDate;
  final bool isClockwise;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    EdgeInsets hintPadding = const EdgeInsets.only(left: 8.0);
    ButtonStyleData buttonStyleData = ButtonStyleData(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(4.0),
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
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
    IconStyleData iconStyleData = const IconStyleData(
      icon: Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.keyboard_arrow_down),
      ),
      iconDisabledColor: MyStyles.greyScale757575,
      iconEnabledColor: MyStyles.greyScale757575,
      iconSize: 16,
    );
    return DropdownButtonHideUnderline(
      child: CustomizedDropdownButton(
        dropdownMenuType: DropdownMenuType.datePicker,
        dropdownSearchData: DropdownSearchData(
          //好醜
          searchInnerWidget: CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: isClockwise ? DateTime.now() : DateTime(1923),
            lastDate: isClockwise ? DateTime(2099) : DateTime.now(),
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
            ? Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: hintPadding,
                  child: Text('${selectedDate?.year}年${selectedDate?.month}月${selectedDate?.day}日'),
                ))
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
        iconStyleData: iconStyleData,
      ),
    );
  }
}
