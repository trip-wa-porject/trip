import 'package:flutter/material.dart';
import 'package:tripflutter/consts.dart';

import '../../utils/amount_format_utils.dart';

class OrderData {
  String? id, detail, date, price, payState, payMethod, lastNumbers, emailState;

  OrderData({
    this.id,
    this.detail,
    this.date,
    this.price,
    this.payState,
    this.payMethod,
    this.lastNumbers,
    this.emailState,
  });

  static OrderData sample() {
    return OrderData(
      id: '808080080808',
      detail: '舊好茶部落巡禮',
      date: '待確認',
      price: '2400',
      payState: '待確認',
      payMethod: '',
      lastNumbers: '',
      emailState: '尚未通知',
    );
  }

  static OrderData sampleVIP() {
    return OrderData(
      id: '808080080808',
      detail: '正式會員',
      date: '待確認',
      price: '600',
      payState: '待確認',
      payMethod: '',
      lastNumbers: '',
      emailState: '尚未通知',
    );
  }

  List<String?> get data => [
        id,
        detail,
        date,
        price,
        payState,
        payMethod,
        lastNumbers,
        emailState,
      ];

  List<String?> get dataTitle => [
        '繳費編號',
        '商品明細',
        '繳費日期',
        '付款金額',
        '繳費狀態',
        '繳費方式',
        '匯款後五碼',
        '信件',
      ];
}

class PayTable extends StatelessWidget {
  const PayTable({Key? key, required this.orderData}) : super(key: key);

  final List<OrderData> orderData;

  @override
  Widget build(BuildContext context) {
    BoxDecoration boxDecorationTitle = BoxDecoration(
      color: MyStyles.tripNeutral,
      border: Border.all(color: MyStyles.tripPrimary, width: 1),
    );
    BoxDecoration boxDecoration = BoxDecoration(
      border: Border.all(color: MyStyles.tripPrimary, width: 1),
    );
    int totalPrice = 0;
    for (var o in orderData) {
      if (o.price != null) {
        int price = int.tryParse(o.price!) ?? 0;
        totalPrice += price;
      }
    }
    bool isContainVIP = orderData.any((element) => element.detail == "正式會員");

    TextStyle title = MyStyles.kTextStyleH4.copyWith();
    TextStyle label = MyStyles.kTextStyleSubtitle1Bold.copyWith();
    TextStyle content = MyStyles.kTextStyleBody1.copyWith();
    return Container(
      decoration: boxDecoration,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 13,
              horizontal: 8,
            ),
            child: Row(
              children: [
                Text(
                  " 總金額 NT\$ ${amountFormat(totalPrice)}",
                  style: title,
                ),
                Text(
                  '（報名費用${isContainVIP ? '+會員費用' : ''}）',
                  style: title,
                ),
                Spacer(),
                Text(
                  '已確認付款金額：NT\$ 0元  ',
                  style: title,
                ),
                Text(
                  '剩餘金額：NT\$ ${amountFormat(totalPrice)}元',
                  style: title,
                ),
              ],
            ),
          ),
          Row(
              children: OrderData()
                  .dataTitle
                  .map((e) => Expanded(
                        child: Container(
                          decoration: boxDecorationTitle,
                          child: Center(
                              child: Text(
                            e ?? "",
                            style: label,
                          )),
                        ),
                      ))
                  .toList()),
          ...(orderData
              .map((e) => Row(
                  children: e.data
                      .map((i) => Expanded(
                            child: Container(
                              decoration: boxDecoration,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Center(
                                  child: Text(
                                e.data.indexOf(i) == 3
                                    ? 'NT\$ ${amountFormat(int.parse(i!))}'
                                    : (i ?? ""),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: content,
                              )),
                            ),
                          ))
                      .toList()))
              .toList())
        ],
      ),
    );
  }
}
