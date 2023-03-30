import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripflutter/models/schedule_model.dart';

import '../../component/tableViewColumn.dart';

class ScheduleTransportation extends StatelessWidget {
  const ScheduleTransportation({Key? key, required this.model})
      : super(key: key);

  final ScheduleModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
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
                TableViewColumn.createColumn('集合地點', '三重捷運站二號出口'),
                TableViewColumn.createColumn('行前會議', '3/4(六) 陽明山山腳'),
              ],
            ),
            TableRow(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              children: [
                TableViewColumn.createColumn('集合時間', '3/25 9:00'),
                TableViewColumn.createColumn('領隊', '林麗英'),
              ],
            ),
            TableRow(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              children: [
                TableViewColumn.createColumn('交通方式', '專車'),
                TableViewColumn.createColumn('嚮導', '呂萬隆、吳泰學、黃博宇'),
              ],
            ),
            TableRow(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              children: [
                TableViewColumn.createColumn('下車地點', '陽明山'),
                TableViewColumn.createColumn('注意事項', '食物'),
              ],
            ),
          ],
        ),
        Table(
          border: TableBorder.all(width: 1, color: const Color(0xFFEA9F49)),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(),
          },
          children: [
            TableRow(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              children: [
                TableViewColumn.createColumnExpandHeight(
                    '交通資訊', '一、原下車地點...\n二、可搭乘...\n三、劍潭......'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
