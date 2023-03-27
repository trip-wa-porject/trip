import 'package:flutter/material.dart';

import '../../models/schedule_model.dart';
import '../../consts.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard(
      {Key? key, this.model, this.index})
      : super(key: key);

  final ScheduleModel? model;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final ScheduleModel _model =
        model ?? ScheduleModel.sample();
    return Card(
      child: Container(
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
    return new Expanded(
      flex: 1,
      child: Container(
          height: 180,
          alignment: Alignment.center,
          child: Image.asset(
              'assets/Demo/demo.jpeg')),
    );
  }

  Widget _rightSideInfo() {
    return new Expanded(
      flex: 3,
      child: Container(
        alignment: Alignment.topLeft,
        height: 180,
        child: _tripInfo(),
      ),
    );
  }

  Widget _tripInfo() {
    return new Column(
        // mainAxisAlignment:
        //     MainAxisAlignment.center,
        children: [
          Row(children: [
            Container(
                height: 50,
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 8.0),
                  child: Text('活動名稱',
                      style:
                          MyStyles.kTextStyleH3),
                )),
            Container(
                height: 50,
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding:
                        const EdgeInsets.only(
                            right: 8.0),
                    child: Text('3/20 - 3/23',
                        style: MyStyles
                            .kTextStyleBody1))),
            Container(
                height: 50,
                alignment: Alignment.bottomCenter,
                child: Text('新竹市',
                    style: MyStyles
                        .kTextStyleSubtitle1)),
            // Container(
            //   height: 50,
            //   alignment: Alignment.bottomCenter,
            //   child: Flex(children: [
            //     Expanded(
            //       flex: 1,
            //       children: Container(
            //         alignment: Alignment.topLeft,
            //         height: 180,
            //         color: Colors.lightGreen[50],
            //         child: Text('即將額滿',
            //             style: MyStyles
            //                 .kTextStyleH1),
            //       ),
            //     )
            //   ]),
            // )
          ])
        ]);
  }
}
