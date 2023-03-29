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
          Expanded(flex: 1, child: const Text('test')),
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

  Widget _rightSideInfo() {
    return Expanded(
      flex: 3,
      child: Container(
        alignment: Alignment.topLeft,
        height: 200,
        child: _tripInfo(),
      ),
    );
  }

  Widget _tripInfo() {
    return Column(
        // mainAxisAlignment:
        //     MainAxisAlignment.center,
        children: [_tripInfoTitle(), _tripInfoLevel()]);
  }

  Widget _tripInfoTitle() {
    return Container(
        height: 48,
        alignment: Alignment.bottomCenter,
        child: Row(children: [
          const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Text('活動名稱', style: MyStyles.kTextStyleNormal)),
          const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Text('3/20 - 3/23', style: MyStyles.kTextStyleBody1)),
          const Text('新竹市', style: MyStyles.kTextStyleSubtitle1),
          Expanded(
              child: Container(
                  alignment: Alignment.centerRight,
                  height: 50,
                  child: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text('即將額滿', style: MyStyles.kTextStyleH1))))
        ]));
  }

  Widget _tripInfoLevel() {
    return SizedBox(
        height: 140,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
              height: 25,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                const Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text('進階', style: MyStyles.kTextStyleNormal)),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    color: MyStyles.greyScaleD9D9D9,
                  ),
                  height: 25,
                  child: const Padding(
                      padding: EdgeInsets.only(right: 10.0, left: 10.0),
                      child: Text('!', style: MyStyles.kTextStyleH2)),
                ),
              ])),
          const SizedBox(
              height: 40,
              width: 55,
              child: Center(
                child: Text(
                  '中級山',
                  style: MyStyles.kTextStyleNormal,
                ),
              )),
          Row(
            children: const [
              Text('百岳'),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  '\$3300起',
                  textAlign: TextAlign.end,
                ),
              ))
            ],
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [_customButton('了解更多'), _customButton('立即預訂')],
          ))
        ]));
  }

  Widget _customButton(String label) {
    return Container(
        height: 48,
        margin: const EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: Padding(
            padding: const EdgeInsets.only(
                right: 8.0, left: 8.0, top: 4.0, bottom: 4.0),
            child: Text(label, style: MyStyles.kTextStyleH2)));
  }
}
