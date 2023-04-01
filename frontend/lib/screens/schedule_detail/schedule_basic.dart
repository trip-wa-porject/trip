import 'package:flutter/material.dart';
import 'package:tripflutter/component/tableViewColumn.dart';

import '../../models/schedule_model.dart';
import '../../utils/date_format_utils.dart';
import '../../utils/level_format_utils.dart';

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
            TableViewColumn.createColumn(
                '活動日期', DateFormatUtils.getDateWithFullDateTemplate(model.startDate, model.endDate)),
            TableViewColumn.createColumn('報名期間', DateFormatUtils.getDateWithFullDateTemplate(
                model.information.applyStart, model.information.applyEnd)),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          children: [
            TableViewColumn.createColumn('等級', LevelFormatUtils.getLevelStringTemplate(model.level)),
            TableViewColumn.createColumn('名額限制',
                '${model.limitation} / 剩${model.limitation -
                    model.applicants}人'),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          children: [
            TableViewColumn.createColumn('類型', model.type),
            TableViewColumn.createColumnWithPriceRichText('收費金額', model.price, model.memberPrice),
          ],
        ),
      ],
    );
  }
}