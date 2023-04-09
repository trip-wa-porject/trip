import 'package:flutter/material.dart';
import 'package:tripflutter/component/map_widget.dart';

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

  static Widget createColumnWithPriceRichText(
      String columnTitle, int price, int memberPrice) {
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
                  child: RichText(
                    text: TextSpan(
                      text: '非會員 ',
                      style:
                          const TextStyle(color: Colors.black, fontSize: 18.0),
                      children: [
                        TextSpan(
                            text: '\$$price',
                            style: const TextStyle(color: MyStyles.redC80000)),
                        const TextSpan(
                          text: ' 會員 ',
                        ),
                        TextSpan(
                            text: '\$$memberPrice',
                            style: const TextStyle(color: MyStyles.redC80000)),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  static Widget createColumnExpandHeight(
      String columnTitle, String columnContent) {
    return Expanded(
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
    );
  }

  static Widget createColumnWithImage(
      Widget? button, String columnTitle, String image) {
    return Expanded(
      flex: 3,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
                height: 350,
                color: MyStyles.tripNeutral,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      columnTitle,
                      style: const TextStyle(
                          fontSize: 24, color: MyStyles.greyScale424242),
                    ),
                    if (button != null) button,
                  ],
                )),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 350,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SizedBox(
                    height: 310, width: 550, child: Image.asset(image)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget createColumnWithMap(
      Widget? button, String columnTitle, List<String> keywordList) {
    return Expanded(
      flex: 3,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
                height: 350,
                color: MyStyles.tripNeutral,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      columnTitle,
                      style: const TextStyle(
                          fontSize: 24, color: MyStyles.greyScale424242),
                    ),
                    if (button != null) button,
                  ],
                )),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 350,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SizedBox(
                    height: 310, width: 550,
                    child: MapWidget(keywordList: keywordList)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
