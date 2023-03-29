import 'package:flutter/material.dart';

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
              const EdgeInsets.only(left: 24, top: 8, right: 24, bottom: 8),
          child: Column(
            children: const [
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    '標題',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 26, color: Colors.lightGreen),
                  )),
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    '2023/03/19(日) - 03/17(一)',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  )),
              //tags
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: SizedBox.fromSize(
                      size: const Size.fromRadius(120),
                      child: Image.asset(
                        'assets/forest.jpg',
                        fit: BoxFit.fill,
                      )),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(
                          left: 24.0,
                          right: 24.0,
                        ),
                        child: const Text(
                          '活動簡介',
                          textAlign: TextAlign.left,
                          style:
                              TextStyle(fontSize: 20, color: Colors.blueGrey),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(
                          left: 24.0,
                          right: 24.0,
                        ),
                        child: const Text(
                          '活動內容活動內容活動內容活動內容活動內容活動內容活動內容活動內容活動內容活動內容活動內容活動內容活動內容活動內容',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Flexible(
                        child: Row(
                          children: [
                            Flexible(
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.only(
                                  left: 24.0,
                                ),
                                child: Image.asset(
                                  'assets/mountain.jpg',
                                  width: 75,
                                  height: 75,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                alignment: Alignment.bottomRight,
                                padding: const EdgeInsets.only(
                                  right: 24.0,
                                ),
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
                                        color: Colors.black,
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
