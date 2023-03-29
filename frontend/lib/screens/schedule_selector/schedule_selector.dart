import 'package:flutter/material.dart';

import '../schedule_detail/schdule_detail.dart';
import 'schedule_card.dart';
import '../../models/schedule_model.dart';
import 'schedule_options.dart';
import 'package:get/get.dart';

class ScheduleSelector extends StatelessWidget {
  const ScheduleSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ScheduleOptions(),
        Expanded(
          child: Placeholder(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (c, index) {
                return GestureDetector(
                  onTap: () async {
                    print('onTap');
                    await Get.dialog(ScheduleDetail(
                      model: ScheduleModel.sample(),
                    ));
                  },
                  child: ScheduleCard(
                    index: index + 1,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
