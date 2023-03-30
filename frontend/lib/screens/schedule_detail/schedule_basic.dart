import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripflutter/component/tableViewColumn.dart';

import '../../models/schedule_model.dart';

class ScheduleBasic extends StatelessWidget {
  const ScheduleBasic({Key? key, required this.model}) : super(key: key);

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
            TableViewColumn.createColumn('活動日期', '2023/03/19-2023/03/31'),
            TableViewColumn.createColumn('報名期間', '2023/03/01-2023/03/18'),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          children: [
            TableViewColumn.createColumn('等級', '大眾路線（入門）'),
            TableViewColumn.createColumn('名額限制', '20人(剩三人)'),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          children: [
            TableViewColumn.createColumn('類型', '百岳'),
            TableViewColumn.createColumn('收費金額', '非會員 \$3,500 會員 \$3,000'),
          ],
        ),
      ],
    );
  }
}