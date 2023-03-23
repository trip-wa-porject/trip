class ScheduleModel {
  String? title;
  int? cost;

  ScheduleModel({
    this.title,
    this.cost,
  });

  static ScheduleModel sample() {
    return ScheduleModel(title: "行程名稱", cost: 1000);
  }
}
