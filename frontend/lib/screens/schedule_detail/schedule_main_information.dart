import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/utils/level_format_utils.dart';

import '../../models/schedule_model.dart';
import '../../utils/date_format_utils.dart';
import '../schedule_apply/schedule_apply.dart';

class ScheduleMainInformation extends StatefulWidget {
  const ScheduleMainInformation({Key? key, required this.model})
      : super(key: key);

  final ScheduleModel model;

  @override
  State<ScheduleMainInformation> createState() =>
      _ScheduleMainInformationState();
}

class _ScheduleMainInformationState extends State<ScheduleMainInformation> {
  late PageController _pageController;
  int activePage = 0;
  List<String> images = [
    'https://images.unsplash.com/photo-1448375240586-882707db888b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9yZXN0fGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    'https://images.unsplash.com/photo-1589182373726-e4f658ab50f0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80',
    'https://images.unsplash.com/photo-1448375240586-882707db888b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9yZXN0fGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    'https://images.unsplash.com/photo-1448375240586-882707db888b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9yZXN0fGVufDB8fDB8fA%3D%3D&w=1000&q=80',
  ];

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 1.0, initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //標題區
        Padding(
          padding: const EdgeInsets.only(left:10, top: 8, bottom: 10, right: 10),
          child: Column(
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    widget.model.title,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: MyStyles.tripTertiary),
                  )),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Text(
                      DateFormatUtils.getDateWithFullDateTemplate(
                          widget.model.startDate, widget.model.endDate),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 36, color: MyStyles.greyScale757575),
                    ),
                    //tags
                    const SizedBox(
                      width: 12.0,
                    ),
                    _customTab(
                        true,
                        DateFormatUtils.getTotalDate(
                            widget.model.startDate, widget.model.endDate)),
                    const SizedBox(
                      width: 12.0,
                    ),
                    _customTab(false, widget.model.type),
                    const SizedBox(
                      width: 12.0,
                    ),
                    _customTab(
                        false,
                        LevelFormatUtils.getLevelStringTemplate(
                            widget.model.level)),
                  ],
                ),
              ),
            ],
          ),
        ),
        //圖片 Gallery
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
                height: 375,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                    itemCount: images.length,
                    pageSnapping: true,
                    controller: _pageController,
                    onPageChanged: (page) {
                      setState(() {
                        activePage = page;
                      });
                    },
                    itemBuilder: (context, pagePosition) {
                      return Container(
                          margin: const EdgeInsets.only(
                              left: 10, top: 10, right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(images[pagePosition],
                                fit: BoxFit.cover),
                          ));
                    })),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _indicators(images.length, activePage),
            ),
          ],
        ),
        //資訊區 Card
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
          padding: const EdgeInsets.all(35),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2),
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textScaleFactor: ScaleSize.textScaleFactor(context),
                    text: TextSpan(
                      text: '非會員 ',
                      style: MyStyles.kTextStyleH1
                          .copyWith(color: MyStyles.greyScale000000),
                      children: [
                        TextSpan(
                          text: '\$${widget.model.price}',
                          style: MyStyles.kTextStyleH1
                              .copyWith(color: MyStyles.redC80000),
                        ),
                        const TextSpan(
                          text: ' 會員 ',
                        ),
                        TextSpan(
                          text: '\$${widget.model.memberPrice}',
                          style: MyStyles.kTextStyleH1
                              .copyWith(color: MyStyles.redC80000),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '報名期間：${DateFormatUtils.getDateWithDateTemplate(widget.model.information.applyStart, widget.model.information.applyEnd)}',
                    style: MyStyles.kTextStyleH3
                        .copyWith(color: MyStyles.greyScale757575),
                    // textScaleFactor: ScaleSize.textScaleFactor(context),
                  ),
                ],
              ),),
              SizedBox(
                height: 65,
                width: 205,
                child: TextButton(
                  onPressed: () async {
                    await Get.dialog(const ScheduleApply());
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          MyStyles.tripSecondaryF8D797),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                  color: MyStyles.tripSecondaryF8D797)))),
                  child: Text(
                    '立即報名',
                    style: MyStyles.kTextStyleH2Normal
                        .copyWith(color: MyStyles.greyScale000000),
                  ),
                ),
              ),
            ],
          ),
        ),

        // IntrinsicHeight(
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.stretch,
        //     children: [
        //       ClipRRect(
        //         borderRadius: BorderRadius.circular(18.0),
        //         child: SizedBox.fromSize(
        //           size: const Size.fromRadius(140),
        //           child: Image.network(
        //             model.imageUrls.first,
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //       ),
        //       Expanded(
        //         child: Column(
        //           children: [
        //             Container(
        //               alignment: Alignment.topLeft,
        //               padding: const EdgeInsets.only(
        //                 left: 48.0,
        //               ),
        //               child: const Text(
        //                 '活動簡介',
        //                 textAlign: TextAlign.left,
        //                 style: TextStyle(
        //                     fontSize: 24, color: MyStyles.greyScale212121),
        //               ),
        //             ),
        //             Container(
        //               height: 135,
        //               alignment: Alignment.topLeft,
        //               padding: const EdgeInsets.only(
        //                 left: 48.0,
        //                 top: 12.0,
        //               ),
        //               child: Scrollbar(
        //                 thumbVisibility: true,
        //                 //always show scrollbar
        //                 thickness: 8,
        //                 //width of scrollbar
        //                 radius: const Radius.circular(20),
        //                 //corner radius of scrollbar
        //                 scrollbarOrientation: ScrollbarOrientation.right,
        //                 child: SingleChildScrollView(
        //                   child: Text(
        //                     model.breif,
        //                     textAlign: TextAlign.left,
        //                     style: const TextStyle(
        //                         fontSize: 14,
        //                         color: MyStyles.greyScale757575),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             Flexible(
        //               child: Row(
        //                 children: [
        //                   Flexible(
        //                     child: Container(
        //                       alignment: Alignment.bottomLeft,
        //                       padding: const EdgeInsets.only(
        //                         left: 48.0,
        //                       ),
        //                       child: Image.asset(
        //                         'assets/images/qrcode.jpeg',
        //                         width: 98,
        //                         height: 98,
        //                       ),
        //                     ),
        //                   ),
        //                   Flexible(
        //                     child: Container(
        //                       alignment: Alignment.bottomRight,
        //                       child: SizedBox(
        //                         height: 55,
        //                         width: 230,
        //                         child: TextButton(
        //                           onPressed: () async {
        //                             await Get.dialog(const ScheduleApply());
        //                           },
        //                           style: ButtonStyle(
        //                               backgroundColor:
        //                                   MaterialStateProperty.all<Color>(
        //                                       const Color(0xFFEA9F49)),
        //                               shape: MaterialStateProperty.all<
        //                                       RoundedRectangleBorder>(
        //                                   RoundedRectangleBorder(
        //                                       borderRadius:
        //                                           BorderRadius.circular(
        //                                               100.0),
        //                                       side: const BorderSide(
        //                                           color:
        //                                               Color(0xFFEA9F49))))),
        //                           child: const Text(
        //                             '立即報名',
        //                             style: TextStyle(
        //                               color: MyStyles.greyScale000000,
        //                               fontSize: 20,
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // ),
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
            color: active ? MyStyles.tripNeutral : MyStyles.greyScale757575,
            fontSize: 20),
      ),
    ),
  );
}

List<Widget> _indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 15),
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: currentIndex == index ? MyStyles.greyScale9E9E9E : Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 3),
            blurRadius: 1,
            color: Colors.black.withOpacity(0.3),
          )
        ],
        shape: BoxShape.circle,
      ),
    );
  });
}

class ScaleSize {
  static double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 2500) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}