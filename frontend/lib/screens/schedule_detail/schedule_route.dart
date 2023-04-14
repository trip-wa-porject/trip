import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/component/popup_download.dart';
import 'package:tripflutter/models/schedule_model.dart';

import '../../component/tableViewColumn.dart';
import '../../consts.dart';

import 'dart:convert' show utf8;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' show AnchorElement;

class ScheduleRoute extends StatelessWidget {
  const ScheduleRoute({Key? key, required this.model}) : super(key: key);

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
      children: [
        TableViewColumn.createColumnWithMap(
            _createDownloadButton(), '路線地圖', model.area),
      ],
    );
  }
}

Widget _createDownloadButton() {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: SizedBox(
      width: 105,
      height: 40,
      child: TextButton(
        onPressed: () async {
          downloadGpxTextFile('', 'test.gpx');
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

void downloadGpxTextFile(String text, String filename) {
  AnchorElement()
    ..href =
        '${Uri.dataFromString(text, mimeType: 'text/plain', encoding: utf8)}'
    ..download = filename
    ..style.display = 'none'
    ..click();
}