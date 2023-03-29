import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/screens/schedule_detail/schdule_tabbar.dart';
import 'package:tripflutter/screens/schedule_detail/schedule_main_information.dart';
import '../../models/schedule_model.dart';

class ScheduleDetail extends StatelessWidget {
  const ScheduleDetail({Key? key, required this.model}) : super(key: key);

  final ScheduleModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(left: 200.0, top: 0, right: 200.0, bottom: 0),
      color: Colors.white,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 12, bottom: 24),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    iconSize: 18,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF424242),
                    ),
                  ),
                  const Text(
                    'back',
                    style: TextStyle(fontSize: 16, color: Color(0xFF1c2b1f)),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            ScheduleMainInformation(
              model: ScheduleModel.sample(),
            ),
            Expanded(
              flex: 1,
              child: ScheduleTabBar(
                model: ScheduleModel.sample(),
              ),
            ),
            // Scaffold(
            // resizeToAvoidBottomInset: false,
            // appBar: AppBar(
            //   bottom: PreferredSize(
            //     preferredSize: const Size.fromHeight(1.0),
            //     child: Container(
            //       color: const Color(0xFF979797),
            //     ),
            //   ),
            //   title: const Text('back',
            //       style: TextStyle(color: Color(0xFF1c2b1f), fontSize: 20)),
            //   centerTitle: false,
            //   toolbarHeight: 57,
            //   leading: IconButton(
            //     onPressed: () => Get.back(),
            //     icon: const Icon(
            //       Icons.arrow_back,
            //       color: Color(0xFF424242),
            //     ),
            //   ),
            //   backgroundColor: Colors.white,
            //   shadowColor: Colors.red,
            // ),
            // Column(
            //   children: [
            //     ScheduleMainInformation(
            //       model: ScheduleModel.sample(),
            //     ),
            //     Expanded(
            //       flex: 1,
            //       child: ScheduleTabBar(
            //         model: ScheduleModel.sample(),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
