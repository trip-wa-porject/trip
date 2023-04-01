import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripflutter/models/schedule_model.dart';

import 'package:intl/intl.dart';
import '../../component/tableViewColumn.dart';

class ScheduleTransportation extends StatelessWidget {
  const ScheduleTransportation({Key? key, required this.model})
      : super(key: key);

  final ScheduleModel model;

  @override
  Widget build(BuildContext context) {
    String getGuidesColumn(List<String> guides) {
      var stringBuffer = StringBuffer();
      for (var guide in guides) {
        stringBuffer.write('$guide、');
      }
      return stringBuffer.toString();
    }

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
                TableViewColumn.createColumn(
                    '集合地點', model.information.gatherPlace),
                TableViewColumn.createColumn('行前會議', '3/4(六) 陽明山山腳'),
              ],
            ),
            TableRow(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              children: [
                TableViewColumn.createColumn(
                    '集合時間',  DateFormat('MM/dd kk:mm').format(model.information.gatherTime)),
                TableViewColumn.createColumn('領隊', model.information.leader),
              ],
            ),
            TableRow(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              children: [
                TableViewColumn.createColumn(
                    '交通方式', model.information.transportationWay),
                TableViewColumn.createColumn('嚮導', getGuidesColumn(model.information.guides)),
              ],
            ),
            TableRow(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              children: [
                TableViewColumn.createColumn('下車地點', '陽明山'),
                TableViewColumn.createColumn('注意事項', model.information.memo),
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
                    '交通資訊', model.information.transportationInfo),
              ],
            ),
          ],
        ),
      ],
    );
  }
}