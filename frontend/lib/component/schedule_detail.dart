import 'package:flutter/material.dart';

import '../models/schedule_model.dart';

class ScheduleDetail extends StatelessWidget {
  const ScheduleDetail({Key? key, required this.model}) : super(key: key);

  final ScheduleModel model;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Card(
          child: Container(
            child: Column(
              children: [
                Text('行程名稱：${model.title} '),
                Text('金額: ${model.cost}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
