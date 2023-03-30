import 'package:flutter/material.dart';

import '../../models/schedule_model.dart';
import '../../consts.dart';

Map<int, String> intToDate = {
  1: '一',
  2: '二',
  3: '三',
  4: '四',
  5: '五',
  6: '六',
  7: '日'
};

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key, required this.model, required this.index})
      : super(key: key);

  final ScheduleModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ScheduleModel _model = ScheduleModel.sample();

    return Card(
      child: Row(
        children: [
          Expanded(
              flex: 1, child: _leftSideImage("${index + 1}", _model.imageUrl)),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    _rightSideInfo(_model.startDate, _model.endDate,
                        _model.area, _model.title),
                    _rightSideBook('${model.price}'),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _leftSideImage(String tripNum, String imageUrl) {
    return Container(
      height: 230,
      decoration: BoxDecoration(
        image: DecorationImage(
            alignment: const Alignment(-.2, 0),
            image: Image.network(imageUrl).image,
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

  Widget _rightSideInfo(
      DateTime startDate, DateTime endDate, List<String> area, String title) {
    final handleStartDate =
        "${startDate.month.toString()}/${startDate.day.toString()}";

    final handleEndDate =
        "${endDate.month.toString()}/${endDate.day.toString()}";

    final timeDelta = endDate.difference(startDate).inDays;

    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$handleStartDate - $handleEndDate ${area.join(', ')}"),
          Text(
              "$title \n(${intToDate[timeDelta]}天，週${intToDate[startDate.weekday]}~週${intToDate[endDate.weekday]})",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
          Row(
            children: [
              _customTab(true, '2天'),
              const SizedBox(
                width: 12.0,
              ),
              _customTab(false, '健行'),
              const SizedBox(
                width: 12.0,
              ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                '熱烈報名中',
                style: MyStyles.kTextStyleH1,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$ $price起",
                  style: MyStyles.kTextStyleSubtitle1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _customButton('瞭解更多'),
                    _customButton('立即預訂'),
                  ],
                )
              ],
            )
          ],
        ));
  }

  Widget _customButton(String label) {
    return Container(
        margin: const EdgeInsets.only(left: 10.0, top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: Padding(
            padding: const EdgeInsets.only(
                right: 8.0, left: 8.0, top: 4.0, bottom: 4.0),
            child: Text(label, style: MyStyles.kTextStyleNormal)));
  }

  Widget _customTab(bool active, String label) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 0, left: 0, top: 12, bottom: 12),
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
