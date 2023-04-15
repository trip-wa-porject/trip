import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripflutter/models/schedule_model.dart';

import 'package:intl/intl.dart';
import '../../component/tableViewColumn.dart';
import '../../consts.dart';

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

    return Table(
      border: TableBorder.all(width: 1, color: MyStyles.green3),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(1.0),
        1: IntrinsicColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableViewColumn.createColumn('集合地點', model.information.gatherPlace),
        TableViewColumn.createColumn('集合時間',
            DateFormat('MM/dd kk:mm').format(model.information.gatherTime!)),
        TableViewColumn.createColumn(
            '交通方式', model.information.transportationWay),
        TableViewColumn.createColumn('下車地點', model.information.gatherPlace),
        TableViewColumn.createColumn(
            '行前會議', model.information.preDepartureMeetingPlace),
        TableViewColumn.createColumn('領隊', model.information.leader),
        TableViewColumn.createColumn(
            '嚮導', getGuidesColumn(model.information.guides)),
        TableViewColumn.createColumn('注意事項', model.information.memo),
        TableViewColumn.createColumn(
            '交通資訊', model.information.transportationInfo),
      ],
    );
  }
}
