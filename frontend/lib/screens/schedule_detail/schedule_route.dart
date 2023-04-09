import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/component/popup_download.dart';
import 'package:tripflutter/models/schedule_model.dart';

import '../../component/tableViewColumn.dart';
import '../../consts.dart';

class ScheduleRoute extends StatelessWidget {
  const ScheduleRoute({Key? key, required this.model}) : super(key: key);

  final ScheduleModel model;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(width: 1, color: const Color(0xFFEA9F49)),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          children: [
            TableViewColumn.createColumnWithMap(
                createDownloadButton(), '路線地圖', model.area),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          children: [
            TableViewColumn.createColumnWithImage(
                null, '高度圖', 'assets/images/forest.jpg'),
          ],
        ),
      ],
    );
  }
}

Widget createDownloadButton() {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: SizedBox(
      width: 105,
      height: 40,
      child: TextButton(
        onPressed: () async {
          await Get.dialog(const PopupDownload());
        },
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xFFEA9F49)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    side: const BorderSide(color: Color(0xFFEA9F49))))),
        child: const Text(
          '下載GPX',
          style: TextStyle(
            color: MyStyles.greyScale000000,
            fontSize: 14,
          ),
        ),
      ),
    ),
  );
}
