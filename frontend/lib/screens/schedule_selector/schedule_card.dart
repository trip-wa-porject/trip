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
      child: SizedBox(
        height: 200,
        child: Row(
          children: [
            _leftSideImage(),
            _rightSideInfo(),
          ],
        ),
      ),
    );
  }

  Widget _leftSideImage() {
    return Expanded(
      flex: 1,
      child: Container(
          height: 180,
          alignment: Alignment.center,
          child: Image.asset('assets/Demo/demo.jpeg')),
    );
  }

  Widget _rightSideInfo() {
    return Expanded(
      flex: 3,
      child: Container(
        alignment: Alignment.topLeft,
        height: 180,
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
        height: 120,
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
                    borderRadius: BorderRadius.circular(999),
                    color: MyStyles.greyScaleD9D9D9,
                  ),
                  height: 25,
                  child: const Padding(
                      padding: EdgeInsets.only(right: 10.0, left: 10.0),
                      child: Text('!', style: MyStyles.kTextStyleH2)),
                ),
              ])),
          const SizedBox(
              height: 25, child: Text('中級山', style: MyStyles.kTextStyleNormal)),
          const SizedBox(
              height: 25, child: Text('百岳', style: MyStyles.kTextStyleNormal)),
        ]));
  }
}
