import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/schedule_model.dart';

class ScheduleDetail extends StatefulWidget {
  const ScheduleDetail({Key? key}) : super(key: key);

  @override
  State<ScheduleDetail> createState() => _ScheduleDetailState();
}

class _ScheduleDetailState extends State<ScheduleDetail> {
  Rxn<ScheduleModel> model = Rxn<ScheduleModel>();

  getData() async {
    try {
      model.value = ScheduleModel.fromJson(Get.arguments);
    } catch (e) {
      Future.delayed(Duration(seconds: 3), () {
        //TODO get data from api
        model.value = ScheduleModel.sampleFromJson();
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Card(
          child: Container(
            child: Obx(
              () => Column(
                children: [
                  Text('行程名稱：${model.value?.title} '),
                  Text('金額: ${model.value?.price}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
