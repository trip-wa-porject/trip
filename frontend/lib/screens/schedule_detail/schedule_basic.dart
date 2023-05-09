import 'package:flutter/material.dart';
import 'package:tripflutter/component/tableViewColumn.dart';
import 'package:tripflutter/consts.dart';

import '../../models/schedule_model.dart';
import '../../utils/date_format_utils.dart';
import '../../utils/level_format_utils.dart';

class ScheduleBasic extends StatelessWidget {
  const ScheduleBasic({Key? key, required this.model}) : super(key: key);

  final ScheduleModel model;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(width: 1, color: MyStyles.green3),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(1.0),
        1: IntrinsicColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableViewColumn.createColumn('活動簡介', model.breif),
        TableViewColumn.createColumn('類型', model.type),
        TableViewColumn.createColumn(
            '等級',
            LevelFormatUtils.getLevelStringTemplate(model.level)),
        TableViewColumn.createColumn(
            '活動日期',
            DateFormatUtils.getDateWithFullDetailTemplate(
                model.startDate!, model.endDate!)),
        TableViewColumn.createColumn(
            '報名截止',
            '${DateFormatUtils.getDateWithSingleFullDateTemplate(
                model.information.applyEnd!)} 截止'),
      ],
    );
  }
}
