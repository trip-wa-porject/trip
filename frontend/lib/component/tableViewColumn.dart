import 'package:flutter/cupertino.dart';

import '../consts.dart';

class TableViewColumn {
  static Widget createColumn(String columnTitle, String columnContent) {
    return Expanded(
      flex: 3,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 96,
              color: MyStyles.tripNeutral,
              alignment: Alignment.center,
              child: Text(
                columnTitle,
                style: const TextStyle(
                    fontSize: 24, color: MyStyles.greyScale424242),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 96,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  columnContent,
                  style: const TextStyle(
                      fontSize: 24, color: MyStyles.greyScale000000),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget createColumnExpandHeight(
      String columnTitle, String columnContent) {
    return Container(
      width: double.infinity,
      child: Expanded(
        flex: 3,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 120,
                color: MyStyles.tripNeutral,
                alignment: Alignment.center,
                child: Text(
                  columnTitle,
                  style: const TextStyle(
                      fontSize: 24, color: MyStyles.greyScale424242),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    columnContent,
                    style: const TextStyle(
                        fontSize: 24, color: MyStyles.greyScale000000),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget createColumnWithImage(String columnTitle, String image) {
    return Container(
      width: double.infinity,
      child: Expanded(
        flex: 3,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 520,
                color: MyStyles.tripNeutral,
                alignment: Alignment.center,
                child: Text(
                  columnTitle,
                  style: const TextStyle(
                      fontSize: 24, color: MyStyles.greyScale424242),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 520,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: SizedBox(
                      height: 410, width: 850, child: Image.asset(image)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
