import 'package:flutter/material.dart';

import '../../models/schedule_model.dart';
import '../../consts.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key, this.model, this.index}) : super(key: key);

  final ScheduleModel? model;
  final int? index;

  @override
  Widget build(BuildContext context) {
    // final ScheduleModel _model = model ?? ScheduleModel.sample();
    return Card(
      child: Row(
        children: [
          Expanded(flex: 1, child: _leftSideImage('我是行程編號')),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  _rightSideInfo('04/07-04/09', '屏東縣'),
                  _rightSideBook('3300'),
                ],
              )),
        ],
      ),
    );
  }

  Widget _leftSideImage(String tripNum) {
    return Container(
      height: 230,
      decoration: BoxDecoration(
        image: DecorationImage(
            alignment: const Alignment(-.2, 0),
            image: Image.asset('assets/images/demo.jpeg').image,
            fit: BoxFit.cover),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
      ),
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 15),
      child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color.fromRGBO(255, 255, 255, 0.6)),
            child: Text(
              tripNum,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          )),
    );
  }

  Widget _rightSideInfo(String date, String location) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text("$date $location"),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text('舊好茶部落巡禮 雲豹的故鄉\n(三天，週五~週日)',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
          Row(
            children: [
              _customTab(true, '2天'),
              _customTab(false, '健行'),
              _customTab(false, '大眾路線 (入門)')
            ],
          )
        ],
      ),
    );
  }

  Widget _rightSideBook(String price) {
    return Expanded(
        flex: 1,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              '熱烈報名中',
              style: MyStyles.kTextStyleH1,
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                "\$ $price起",
                style: MyStyles.kTextStyleSubtitle1,
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _customButton('瞭解更多'),
                  _customButton('立即預訂'),
                ],
              ))
        ]));
  }

  Widget _customButton(String label) {
    return Container(
        margin: const EdgeInsets.only(left: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: Padding(
            padding: const EdgeInsets.only(
                right: 8.0, left: 8.0, top: 4.0, bottom: 4.0),
            child: Text(label, style: MyStyles.kTextStyleH2)));
  }

  Widget _customTab(bool active, String label) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 0, left: 20, top: 12, bottom: 12),
      padding: const EdgeInsets.only(left: 6, right: 6, bottom: 4),
      decoration: BoxDecoration(
          border: Border.all(color: MyStyles.greyScale757575),
          borderRadius: BorderRadius.circular(8.0),
          color: active ? MyStyles.tripTertiary : Colors.white),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
              color: active ? Colors.white : Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}
