import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/utils/level_format_utils.dart';

import '../../models/schedule_model.dart';
import '../../utils/date_format_utils.dart';
import '../schedule_apply/schedule_apply.dart';

class ScheduleMainInformation extends StatelessWidget {
  const ScheduleMainInformation({Key? key, required this.model})
      : super(key: key);

  final ScheduleModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //標題區
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Column(
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    model.title ?? '',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 34, color: MyStyles.tripTertiary),
                  )),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Text(
                      DateFormatUtils.getDateWithFullDateTemplate(
                          model.startDate, model.endDate),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 20, color: MyStyles.greyScale757575),
                    ),
                    //tags
                    const SizedBox(
                      width: 12.0,
                    ),
                    _customTab(
                        true,
                        DateFormatUtils.getTotalDate(
                            model.startDate, model.endDate)),
                    const SizedBox(
                      width: 12.0,
                    ),
                    _customTab(false, model.type),
                    const SizedBox(
                      width: 12.0,
                    ),
                    _customTab(false,
                        LevelFormatUtils.getLevelStringTemplate(model.level)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 24.0, bottom: 48.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(140),
                    child: Image.network(
                      model.imageUrls.first,
                      fit: BoxFit.cover,
                    ),
                    // child: Image.asset(
                    //   'assets/images/forest.jpg',
                    //   fit: BoxFit.fill,
                    // ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(
                          left: 48.0,
                        ),
                        child: const Text(
                          '活動簡介',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 24, color: MyStyles.greyScale212121),
                        ),
                      ),
                      Container(
                        height: 135,
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(
                          left: 48.0,
                          top: 12.0,
                        ),
                        child: Scrollbar(
                          thumbVisibility: true,
                          //always show scrollbar
                          thickness: 8,
                          //width of scrollbar
                          radius: const Radius.circular(20),
                          //corner radius of scrollbar
                          scrollbarOrientation: ScrollbarOrientation.right,
                          child: SingleChildScrollView(
                            child: Text(
                              model.breif,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: MyStyles.greyScale757575),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Row(
                          children: [
                            Flexible(
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.only(
                                  left: 48.0,
                                ),
                                child: Image.asset(
                                  'assets/images/qrcode.jpeg',
                                  width: 98,
                                  height: 98,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                alignment: Alignment.bottomRight,
                                child: SizedBox(
                                  height: 55,
                                  width: 230,
                                  child: TextButton(
                                    onPressed: () async {
                                      await Get.dialog(const ScheduleApply());
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color(0xFFEA9F49)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0),
                                                side: const BorderSide(
                                                    color:
                                                        Color(0xFFEA9F49))))),
                                    child: const Text(
                                      '立即報名',
                                      style: TextStyle(
                                        color: MyStyles.greyScale000000,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _customTab(bool active, String label) {
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(right: 0, left: 0, top: 12, bottom: 12),
    padding: const EdgeInsets.only(left: 6, right: 6, bottom: 2, top: 2),
    decoration: BoxDecoration(
        border: Border.all(color: MyStyles.greyScale757575),
        borderRadius: BorderRadius.circular(6.0),
        color: active ? MyStyles.tripTertiary : Colors.white),
    child: Align(
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
            color: active ? Colors.white : MyStyles.greyScale757575,
            fontSize: 14),
      ),
    ),
  );
}
