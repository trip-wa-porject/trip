import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  String? idno; //	身份證號	base64
  @JsonKey(name: 'id')
  String? userId; //	使用者 ID
  String? email; //	信箱帳號
  String? name; //	使用者姓名	base64
  String? mobile; //	手機號碼
  String? emergentContactor; //	緊急聯絡人姓名	base64
  String? emergentContactTel; //	緊急聯絡人電話
  String? contactorRelationship; //	緊急聯絡人關係
  int? sexual; //	性別
  String? address; //	地址
  String? birth; //	出生日期

  @JsonKey(name: 'member')
  int? membership; //	會員狀態	分成 訪客 ＆ 正式會員
  String? createDate; //	註冊日期
  String? updateDate; //	更新日期
  Map? agreements; //	閱讀條款統一狀態	Map{}

  UserModel(
      this.idno,
      this.userId,
      this.email,
      this.name,
      this.mobile,
      this.emergentContactor,
      this.emergentContactTel,
      this.contactorRelationship,
      this.sexual,
      this.address,
      this.birth,
      this.membership,
      this.createDate,
      this.updateDate,
      this.agreements);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
