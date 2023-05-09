import 'package:flutter/material.dart';
import 'package:tripflutter/component/map_widget.dart';

import '../consts.dart';

class TableViewColumn {
  static TableRow createColumnWithApplicantsRichText(
      String columnTitle, int limitation, int applicants) {
    return TableRow(children: <Widget>[
      IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Container(
              width: 265,
              color: MyStyles.green1,
              alignment: Alignment.center,
              child: Text(
                columnTitle,
                style: MyStyles.kTextStyleH4Bold
                    .copyWith(color: MyStyles.greyScale424242),
              ),
            ),
            Flexible(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: RichText(
                    text: TextSpan(
                      text: '$limitation位 / ',
                      style: MyStyles.kTextStyleSubtitle1
                          .copyWith(color: MyStyles.greyScale212121),
                      children: [
                        TextSpan(
                            text: '剩${limitation - applicants}位',
                            style: MyStyles.kTextStyleSubtitle1
                                .copyWith(color: MyStyles.redC80000)),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      )
    ]);
  }

  static TableRow createColumn(String columnTitle, String columnContent) {
    return TableRow(children: <Widget>[
      IntrinsicHeight(
        child: Row(children: <Widget>[
          Container(
            width: 135,
            color: MyStyles.green1,
            alignment: Alignment.center,
            child: Text(
              columnTitle,
              style: MyStyles.kTextStyleH4Bold
                  .copyWith(color: MyStyles.greyScale424242),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                columnContent,
                overflow: TextOverflow.visible,
                style: MyStyles.kTextStyleSubtitle1
                    .copyWith(color: MyStyles.greyScale212121),
              ),
            ),
          ),
        ]),
      )
    ]);
  }

  static TableRow createColumnWithIcon(
      String columnTitle, String columnContent, Widget icon, void Function() onTap) {
    return TableRow(children: <Widget>[
      IntrinsicHeight(
        child: Row(children: <Widget>[
          Container(
            width: 135,
            color: MyStyles.green1,
            alignment: Alignment.center,
            child: Text(
              columnTitle,
              style: MyStyles.kTextStyleH4Bold
                  .copyWith(color: MyStyles.greyScale424242),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    columnContent,
                    overflow: TextOverflow.visible,
                    style: MyStyles.kTextStyleSubtitle1
                        .copyWith(color: MyStyles.greyScale212121),
                  ),
                  IconButton(
                    icon: icon,
                    iconSize: 18,
                    color: MyStyles.greyScale616161,
                    onPressed: onTap,
                  ),
                ],
              ),
            ),
          ),
        ]),
      )
    ]);
  }

  static TableRow createColumnWithImage(
      Widget? button, String columnTitle, String image) {
    return TableRow(children: <Widget>[
      IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Container(
              width: 135,
              color: MyStyles.green1,
              alignment: Alignment.center,
              child: Text(
                columnTitle,
                style: MyStyles.kTextStyleH4Bold
                    .copyWith(color: MyStyles.greyScale424242),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 85, bottom: 85, left: 140, right: 140),
                child: SizedBox(
                    height: 350, width: 720, child: Image.asset(image)),
              ),
            ),
          ],
        ),
      )
    ]);
  }

  static TableRow createColumnWithMap(Widget? button, String columnTitle) {
    return TableRow(children: <Widget>[
      IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Container(
                width: 135,
                color: MyStyles.green1,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      columnTitle,
                      style: MyStyles.kTextStyleH4Bold
                          .copyWith(color: MyStyles.greyScale424242),
                    ),
                    if (button != null) button,
                  ],
                )),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 35, bottom: 35, left: 60, right: 60),
                child: SizedBox(height: 300, width: 630, child: MapWidget()),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
