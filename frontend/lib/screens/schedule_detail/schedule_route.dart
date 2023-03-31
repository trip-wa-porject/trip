import 'package:flutter/material.dart';
import 'package:tripflutter/models/schedule_model.dart';

import '../../component/tableViewColumn.dart';

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
            TableViewColumn.createColumnWithImage('路線地圖', 'assets/images/forest.jpg'),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          children: [
            TableViewColumn.createColumnWithImage('高度圖', 'assets/images/forest.jpg'),
          ],
        ),
      ],
    );
  }
}
