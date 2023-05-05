import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tripflutter/component/buttons.dart';
import 'package:tripflutter/screens/schedule_manager/schedule_manager_controller.dart';
import 'package:tripflutter/screens/schedule_selector/schedule_selector_controller.dart';

import '../../models/schedule_model.dart';
import '../../consts.dart';
import '../../utils/date_format_utils.dart';

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
  'K': '特殊行程（事前繳費',
};

Map<int, String> intToStatus = {
  0: '熱烈報名中',
  1: '已額滿',
  2: '尚有#名額',
  3: '已取消',
  4: '即將額滿',
};

Map<int, TextStyle> intToStatusStyle = {
  0: MyStyles.kTextStyleH2Bold.copyWith(color: MyStyles.redC80000),
  1: MyStyles.kTextStyleH2Bold.copyWith(color: MyStyles.greyScale9E9E9E),
  2: MyStyles.kTextStyleH2Bold.copyWith(color: MyStyles.greyScale424242),
  3: MyStyles.kTextStyleH2Bold.copyWith(color: MyStyles.greyScale9E9E9E),
  4: MyStyles.kTextStyleH2Bold.copyWith(color: MyStyles.greyScale424242),
};

class ScheduleCard extends StatelessWidget {
  const ScheduleCard(
      {Key? key,
      required this.model,
      required this.index,
      this.isShowOnly = false})
      : super(key: key);

  final ScheduleModel model;
  final int index;
  final bool isShowOnly;

  @override
  Widget build(BuildContext context) {
    final ScheduleModel _model = model;

    return GestureDetector(
      onTap: () {
        Get.find<ScheduleSelectorController>().goToDetail(model);
      },
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.all(0.0),
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        child: Row(
          children: [
            SizedBox(
                width: 363,
                child: _leftSideImage("${_model.id}", _model.imageUrls.first)),
            Flexible(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    top: 16.0,
                    bottom: 18,
                  ),
                  child: _rightSideInfo(
                      _model.startDate!,
                      _model.endDate!,
                      _model.area.map((e) => e.toString()).toList(),
                      _model.title),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 30,
                top: 16.0,
                bottom: 18,
              ),
              child: _rightSideBook(model.price),
            ),
          ],
        ),
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
          image: Image.network(
            imageUrl ??
                "https://www.thepackablelife.com/wp-content/uploads/2020/01/get-paid-to-hike.jpg",
            errorBuilder: (ctx, o, s) {
              return Image.asset('assets/images/demo.jpeg');
            },
          ).image,
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
      ),
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(16),
      // child: Align(
      //     alignment: Alignment.bottomLeft,
      //     child: Container(
      //       padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      //       decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(8.0),
      //           color: const Color.fromRGBO(255, 255, 255, 0.6)),
      //       child: Text(
      //         "ID-$tripNum",
      //         style: MyStyles.kTextStyleBody1,
      //       ),
      //     )),
    );
  }

  Widget _rightSideInfo(
      DateTime startDate, DateTime endDate, List<String> area, String title) {
    final handleStartDate =
        "${startDate.month.toString()}/${startDate.day.toString()}";

    final handleEndDate =
        "${endDate.month.toString()}/${endDate.day.toString()}";

    // final timeDelta = endDate.difference(startDate).inDays;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "$handleStartDate(${intToDate[startDate.weekday]}) - $handleEndDate(${intToDate[endDate.weekday]})", //${area.first.substring(0, 3)}
              maxLines: 1,
              style: MyStyles.kTextStyleH4.copyWith(
                color: MyStyles.greyScale212121,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.maps_ugc_outlined,
              color: MyStyles.tripTertiary,
            ),
            Text(
              "${area.first.substring(0, 3)}", //
              maxLines: 1,
              style: MyStyles.kTextStyleH4.copyWith(
                color: MyStyles.greyScale212121,
              ),
            ),
          ],
        ),
        Text(
          title,
          maxLines: 1,
          style: MyStyles.kTextStyleH3M.copyWith(
            color: MyStyles.greyScale000000,
          ),
        ),
        Text(
          '領隊- ${model.information.leader.substring(0, 3)} /嚮導- ${model.information.guides.join(',')}',
          maxLines: 1,
          style: MyStyles.kTextStyleBody1.copyWith(
            color: MyStyles.greyScale000000,
          ),
        ),
        const SizedBox(),
        Row(
          children: [
            _customTab(true, DateFormatUtils.getTotalDate(startDate, endDate)),
            const SizedBox(
              width: 12.0,
            ),
            _customTab(false, model.type),
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

    int count = model.limitation - model.applicants.length;
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
        if (_status == 2)
          RichText(
            text: TextSpan(
              style: MyStyles.kTextStyleH2Bold.copyWith(
                color: MyStyles.greyScale424242,
              ),
              children: <TextSpan>[
                const TextSpan(text: '尚有'),
                TextSpan(
                  text: '${count.toString()}位',
                  style: MyStyles.kTextStyleH2Bold.copyWith(
                    color: MyStyles.redC80000,
                  ),
                ),
                const TextSpan(text: '名額'),
              ],
            ),
            textScaleFactor: MediaQuery.of(Get.context!).textScaleFactor,
          ),
        if (_status != 2)
          Text(
            '${intToStatus[_status]!.replaceAll('#', "${count.toString()}位")}',
            style: intToStatusStyle[_status],
          ),
        Text(
          price == 0 ? "免費" : "\$ $price 起",
          style: MyStyles.kTextStyleH4.copyWith(
            color: MyStyles.greyScale000000,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _customButton('了解更多', () {
              Get.find<ScheduleSelectorController>().goToDetail(model);
            }),
            const SizedBox(
              width: 8,
            ),
            _customButton(
                '立即預訂',
                isShowOnly
                    ? null
                    : () async {
                        Get.find<ScheduleManagerController>()
                            .joinNewEvent(model.id, model);
                      }),
          ],
        )
      ],
    );
  }

  Widget _customButton(String label, void Function()? onPressed) {
    return label == '了解更多'
        ? MyWebButton(
            label: label,
            style: MyWebButton.styleMediumOutlinedOrange(),
            onPressed: onPressed,
          )
        : MyWebButton(
            label: label,
            style: MyWebButton.styleMediumFilledOrange(),
            onPressed: onPressed,
          );
  }

  Widget _customTab(bool active, String label) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 4, top: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0), color: MyStyles.green4),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          label,
          style: MyStyles.kTextStyleBody1.copyWith(
            color: MyStyles.tripTertiary,
          ),
        ),
      ),
    );
  }
}

class ScheduleCardSkeleton extends StatelessWidget {
  const ScheduleCardSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10.0));

    bool enabled = true;

    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(0.0),
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: enabled,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
              width: 340,
              height: double.infinity,
            ),
          ),
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: enabled,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          height: 20,
                          width: 280,
                          decoration: decoration,
                        ),
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          height: 20,
                          width: 230,
                          decoration: decoration,
                        ),
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          height: 20,
                          width: 66,
                          decoration: decoration,
                        ),
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          height: 14,
                          width: 288,
                          decoration: decoration,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              height: 16,
                              width: 50,
                              decoration: decoration,
                            ),
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              height: 16,
                              width: 50,
                              decoration: decoration,
                            ),
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              height: 16,
                              width: 50,
                              decoration: decoration,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          height: 46,
                          width: 165,
                          decoration: decoration,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 29,
                            width: 70,
                            decoration: decoration,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              height: 40,
                              width: 77,
                              decoration: decoration,
                            ),
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              height: 40,
                              width: 77,
                              decoration: decoration,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
