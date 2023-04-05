import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/screens/schedule_selector/schedule_selector_controller.dart';

import '../../models/schedule_model.dart';
import '../../consts.dart';
import 'dart:math' as math;

import '../schedule_apply/schedule_apply.dart';

Map<int, String> intToDate = {
  1: '一',
  2: '二',
  3: '三',
  4: '四',
  5: '五',
  6: '六',
  7: '日'
};

Map<String, String> levelToString = {
  'A': '大眾路線（入門',
  'B': '健腳山友（中級）',
  'C': '艱難路線（進階）',
  'Ｋ': '特殊行程（事前繳費',
};

Map<int, String> intToStatus = {
  0: '熱烈報名中',
  1: '已額滿',
  2: '尚有#名額',
  3: '已取消',
  4: '即將額滿',
};

Map<int, TextStyle> intToStatusStyle = {
  0: MyStyles.kTextStyleH1,
  1: MyStyles.kTextStyleH1.copyWith(color: MyStyles.redC80000),
  2: MyStyles.kTextStyleH1,
  3: MyStyles.kTextStyleH1.copyWith(color: MyStyles.greyScale9E9E9E),
  4: MyStyles.kTextStyleH1,
};

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key, required this.model, required this.index})
      : super(key: key);

  final ScheduleModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ScheduleModel _model = model;

    return Card(
      margin: const EdgeInsets.all(0.0),
      child: Row(
        children: [
          SizedBox(
              width: 560,
              child: _leftSideImage("${_model.id}", _model.imageUrls.first)),
          SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _rightSideInfo(_model.startDate, _model.endDate,
                  _model.area.map((e) => e.toString()).toList(), _model.title),
            ),
          ),
          SizedBox(
              width: 250,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _rightSideBook(model.price),
              )),
        ],
      ),
    );
  }

  Widget _leftSideImage(String tripNum, String? imageUrl) {
    return Container(
      height: 230,
      decoration: BoxDecoration(
        image: DecorationImage(
            alignment: const Alignment(-.2, 0),
            // image: AssetImage('assets/images/demo.jpeg'), //TODO 使用真實URL
            image: Image.network(imageUrl != null
                    ? imageUrl
                    : "https://www.thepackablelife.com/wp-content/uploads/2020/01/get-paid-to-hike.jpg")
                .image,
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$handleStartDate(${intToDate[startDate.weekday]}) - $handleEndDate(${intToDate[endDate.weekday]}) ${area.first.substring(0, 3)}",
          maxLines: 1,
          style: MyStyles.kTextStyleBody1,
        ),
        Text(
          "$title",
          maxLines: 1,
          style: MyStyles.kTextStyleH3,
        ),
        Text(
          '領隊- ${model.information.leader.substring(0, 3)} /嚮導- ${model.information.guides.join(',')}',
          maxLines: 1,
        ),
        Row(
          children: [
            _customTab(true, '${timeDelta}天'),
            const SizedBox(
              width: 12.0,
            ),
            _customTab(false, '${model.type}'),
            const SizedBox(
              width: 12.0,
            ),
            _customTab(false, '${levelToString[model.level]}')
          ],
        )
      ],
    );
  }

  Widget _rightSideBook(int price) {
    int _status = 0;

    int count = model.limitation - model.applicants;
    if (count > 9) {
      _status = 0;
    } else if (count > 0) {
      _status = 2;
    } else if (count == 0) {
      _status = 1;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            '${intToStatus[_status]!.replaceAll('#', count.toString())}',
            style: intToStatusStyle[_status],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              price == 0 ? "免費" : "\$ $price 起",
              style: MyStyles.kTextStyleSubtitle1.copyWith(
                color: price == 0 ? MyStyles.redC80000 : null,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _customButton('了解更多', () {
                  Get.find<ScheduleSelectorController>().goToDetail(model);
                }),
                SizedBox(
                  width: 8,
                ),
                _customButton('立即預訂', () async {
                  await Get.dialog(const ScheduleApply());
                }),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _customButton(String label, void Function()? onPressed) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: label == '了解更多' ? Colors.white : MyStyles.tripPrimary,
        side: BorderSide(width: 1.0, color: MyStyles.tripPrimary),
        foregroundColor: MyStyles.greyScale424242,
        textStyle: MyStyles.kTextStyleBody1,
      ),
      onPressed: onPressed,
      child: Text(label, style: MyStyles.kTextStyleNormal),
    );
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
