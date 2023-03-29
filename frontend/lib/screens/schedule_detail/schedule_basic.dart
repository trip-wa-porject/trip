import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            createColumn('活動日期', '2023/03/19-2023/03/31'),
            createColumn('報名期間', '2023/03/01-2023/03/18'),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          children: [
            createColumn('等級', '大眾路線（入門）'),
            createColumn('名額限制', '20人(剩三人)'),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          children: [
            createColumn('類型', '百岳'),
            createColumn('收費金額', '非會員 \$3,500 會員 \$3,000'),
          ],
        ),
      ],
    );
  }
}

Widget createColumn(String columnTitle, String columnContent) {
  return Expanded(
    flex: 3,
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 96,
            color: const Color(0xFFF6F2EA),
            alignment: Alignment.center,
            child: Text(columnTitle,
              style: const TextStyle(fontSize: 24, color: Color(0xFF424242)),),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 96,
            alignment: Alignment.centerLeft,
            child: Text(columnContent,
              style: const TextStyle(fontSize: 24, color: Color(0xFF000000)),),
          ),
        ),
      ],
    ),
  );
}