import 'package:flutter/material.dart';
import 'package:tripflutter/consts.dart';

import '../../models/schedule_model.dart';

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
          padding:
              const EdgeInsets.only(top: 8, bottom: 8),
          child: Column(
            children: const [
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    '標題',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 34, color: MyStyles.tripTertiary),
                  )),
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    '2023/03/19(日) - 03/17(一)',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, color: MyStyles.greyScale757575),
                  )),
              //tags
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top:24.0, bottom: 48.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: SizedBox.fromSize(
                      size: const Size.fromRadius(140),
                      child: Image.asset(
                        'assets/images/forest.jpg',
                        fit: BoxFit.fill,
                      )),
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
                          style:
                              TextStyle(fontSize: 24, color: MyStyles.greyScale212121),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(
                          left: 48.0,
                        ),
                        child: const Text(
                          '活動內容活動內容活動內容活動內容活動內容活動內容活動內容活動內容活動內容活動內容活動內容活動內容活動內容活動內容',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14, color: MyStyles.greyScale757575),
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
                                  'assets/images/mountain.jpg',
                                  width: 98,
                                  height: 98,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                alignment: Alignment.bottomRight,
                                // padding: const EdgeInsets.only(
                                //   right: 24.0,
                                // ),
                                child: SizedBox(
                                  height: 55,
                                  width: 230,
                                  child: TextButton(
                                    onPressed: null,
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
