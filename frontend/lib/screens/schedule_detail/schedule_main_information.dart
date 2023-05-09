import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/utils/level_format_utils.dart';

import '../../models/schedule_model.dart';
import '../../utils/date_format_utils.dart';

class ScheduleMainInformation extends StatefulWidget {
  const ScheduleMainInformation(
      {Key? key, required this.model, this.alreadyJoined = false})
      : super(key: key);

  final ScheduleModel model;
  final bool alreadyJoined;

  @override
  State<ScheduleMainInformation> createState() =>
      _ScheduleMainInformationState();
}

class _ScheduleMainInformationState extends State<ScheduleMainInformation> {
  late PageController _pageController;
  late List<String> images;
  int activePage = 0;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 1.0, initialPage: 0);
    images = widget.model.imageUrls;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //標題區
        Padding(
          padding:
              const EdgeInsets.only(left: 10, top: 8, bottom: 10, right: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    widget.model.title,
                    textAlign: TextAlign.left,
                    style: MyStyles.kTextStyleH2Bold
                        .copyWith(color: MyStyles.tripTertiary),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Image.asset('assets/images/distance.png',),
                  const SizedBox(width: 8.0,),
                  Text(
                    getCities(widget.model.area),
                    style: MyStyles.kTextStyleH4
                        .copyWith(color: MyStyles.greyScale212121),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Text(
                      DateFormatUtils.getDateWithFullDateTemplate(
                          widget.model.startDate!, widget.model.endDate!),
                      textAlign: TextAlign.left,
                      style: MyStyles.kTextStyleH4
                          .copyWith(color: MyStyles.greyScale757575),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    _customTab(DateFormatUtils.getTotalDate(
                        widget.model.startDate!, widget.model.endDate!)),
                    const SizedBox(
                      width: 12.0,
                    ),
                    _customTab(widget.model.type),
                    const SizedBox(
                      width: 12.0,
                    ),
                    _customTab(LevelFormatUtils.getLevelStringTemplate(
                        widget.model.level)),
                  ],
                ),
              ),
            ],
          ),
        ),
        //圖片 Gallery
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
                height: 375,
                width: double.infinity,
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
            if (images.length > 1)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _indicators(images.length, activePage),
                  ),
                ),
              ),
            if (images.length > 1)
              Positioned(
                left: 10,
                child: ElevatedButton(
                  onPressed: () {
                    if (_pageController.page?.toInt() == 0) {
                      _pageController.animateToPage(images.length - 1,
                          duration: const Duration(microseconds: 300),
                          curve: Curves.ease);
                    } else {
                      _pageController.previousPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.ease);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),
            if (images.length > 1)
              Positioned(
                right: 10,
                child: ElevatedButton(
                  onPressed: () {
                    if (_pageController.page?.toInt() == images.length - 1) {
                      _pageController.animateToPage(0,
                          duration: const Duration(microseconds: 300),
                          curve: Curves.ease);
                    } else {
                      _pageController.nextPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.ease);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

Widget _customTab(String label) {
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(right: 0, left: 0, top: 12, bottom: 12),
    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8, top: 8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0), color: MyStyles.green4),
    child: Align(
      alignment: Alignment.center,
      child: Text(
        label,
        style: MyStyles.kTextStyleBody1.copyWith(color: MyStyles.tripTertiary),
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

String getCities(List<Area> cities) {
  return cities.join('、');
}

//RWD 字體縮放測試
class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 2500) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
