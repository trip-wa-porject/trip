import 'package:flutter/material.dart';

import '../../models/schedule_model.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key, this.model, this.index}) : super(key: key);

  final ScheduleModel? model;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final ScheduleModel _model = model ?? ScheduleModel.sample();
    return Card(
      child: Container(
        height: 200,
        width: 400,
        child: Column(
          children: [
            Text('行程名稱：${_model.title} ${index ?? ''}'),
            Text('金額: ${_model.cost}'),
          ],
        ),
      ),
    );
  }
}
