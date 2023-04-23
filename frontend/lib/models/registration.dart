import 'package:json_annotation/json_annotation.dart';

import '../utils/utils.dart';
part 'registration.g.dart';

@JsonSerializable(explicitToJson: true)
class Registration {
  //登山行程 ID
  final String? tripId;

  //使用者 ID
  final String? userId;

  //價格
  final int? price;

  //付款期限截止日
  @JsonKey(
      fromJson: dateTimeFromTimestamp,
      toJson: timestampFromDateTimeFromTimestamp)
  final DateTime? paymentExpireDate;

  //付款方式
  final Map<String, dynamic>? paymentInfo;

  //付款狀態
  final int? status;

  //報名日期
  //int to date
  @JsonKey(
      fromJson: dateTimeFromTimestamp,
      toJson: timestampFromDateTimeFromTimestamp)
  final DateTime? createDate;

  //更新日期
  @JsonKey(
      fromJson: dateTimeFromTimestamp,
      toJson: timestampFromDateTimeFromTimestamp)
  final DateTime? updateDate;

  Registration(this.tripId, this.userId, this.price, this.paymentExpireDate,
      this.paymentInfo, this.status, this.createDate, this.updateDate);

  factory Registration.fromJson(Map<String, dynamic> json) {
    return _$RegistrationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RegistrationToJson(this);

  static Registration sample() {
    return Registration(
        '808080',
        'userId',
        1234,
        DateTime.now().add(Duration(days: 3)),
        {},
        0,
        DateTime.now().subtract(Duration(minutes: 10)),
        DateTime.now());
  }
}
