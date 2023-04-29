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
    TextStyle redText = MyStyles.kTextStyleH4.copyWith(
      fontSize: 19.36,
      color: MyStyles.redC80000,
      fontWeight: FontWeight.bold,
    );
    return Container(
      decoration: boxDecoration,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 13,
              horizontal: 25,
            ),
            child: Row(
              children: [
                Text(
                  " 總金額\$${totalPrice}",
                  style: redText,
                ),
                Text('（報名費用${isContainVIP ? '+會員費用' : ''}）'),
                Spacer(),
                Text(
                  '已確認付款金額：0元  ',
                  style: redText,
                ),
                Text(
                  '剩餘金額：$totalPrice元',
                  style: redText,
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
                              child: Center(
                                  child: Text(
                                e ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
