import 'package:flutter/material.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/screens/schedule_selector/customized_dropdown_button/customized_dropdown_button.dart';

enum CheckBoxOptionMode { single, multiple }

class ScheduleOptionCheckSelector<T> extends StatelessWidget {
  ScheduleOptionCheckSelector({
    Key? key,
    required this.title,
    required this.allItems,
    required this.onChangeCallback,
    required this.selectedItems,
    this.mode = CheckBoxOptionMode.single,
    this.width = 100,
  }) : super(key: key);

  final String title;
  final List<T> allItems;
  final List<T> selectedItems;
  final void Function(List<T>) onChangeCallback;
  final CheckBoxOptionMode mode;
  final double width;

  @override
  Widget build(BuildContext context) {
    EdgeInsets hintPadding = const EdgeInsets.only(left: 8.0);
    ButtonStyleData buttonStyleData = ButtonStyleData(
      decoration: BoxDecoration(
        color: Colors.white,
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
      maxHeight: allItems.length > 8 ? 400 : null,
      offset: const Offset(0, -8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
      ),
    );

    IconStyleData iconStyleData = IconStyleData(
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.keyboard_arrow_up),
      ),
      iconDisabledColor: MyStyles.greyScale757575,
      iconEnabledColor: MyStyles.greyScale757575,
      iconSize: 16,
    );
    return DropdownButtonHideUnderline(
      child: CustomizedDropdownButton(
        isExpanded: true,
        hint: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: hintPadding,
            child: Text(
              '${title}',
              style: TextStyle(
                fontSize: 14,
                color: MyStyles.greyScale757575,
              ),
            ),
          ),
        ),

        items: allItems.map((item) {
          return DropdownMenuItem<T>(
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
                    // setState(() {});
                    //This rebuilds the dropdownMenu Widget to update the check mark
                    menuSetState(() {});
                    onChangeCallback(selectedItems);
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
                          item.toString(),
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
        onChanged: (value) {},
        selectedItemBuilder: (context) {
          return allItems.map(
            (item) {
              return Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  selectedItems.join(', '),
                  style: const TextStyle(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                      color: MyStyles.greyScale757575),
                  maxLines: 1,
                ),
              );
            },
          ).toList();
        },
        buttonStyleData: buttonStyleData,
        menuItemStyleData: menuItemStyleData,
        dropdownStyleData: dropdownStyleData,
        iconStyleData: iconStyleData,
      ),
    );
  }
}
