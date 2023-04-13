import 'package:flutter/material.dart';
import 'package:tripflutter/consts.dart';

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
      payMethod: '匯款或無存摺存款',
      lastNumbers: '98989',
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
      payMethod: '匯款或無存摺存款',
      lastNumbers: '98989',
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
    return Container(
      decoration: boxDecoration,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Text(" 總金額\$3000"),
                Text('（報名費用＋會員費用）'),
                Spacer(),
                Text('已確認付款金額：0元'),
                Text('剩餘金額：3000元'),
              ],
            ),
          ),
          Row(
              children: OrderData()
                  .dataTitle
                  .map((e) => Expanded(
                        child: Container(
                          decoration: boxDecorationTitle,
                          child: Center(child: Text(e ?? "")),
                        ),
                      ))
                  .toList()),
          ...(orderData
              .map((e) => Row(
                  children: e.data
                      .map((e) => Expanded(
                            child: Container(
                              decoration: boxDecoration,
                              child: Center(child: Text(e ?? "")),
                            ),
                          ))
                      .toList()))
              .toList())
        ],
      ),
    );
  }
}
