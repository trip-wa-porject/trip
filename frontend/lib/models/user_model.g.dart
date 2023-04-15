// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['idno'] as String?,
      json['userId'] as String?,
      json['email'] as String?,
      json['name'] as String?,
      json['mobile'] as String?,
      json['emergentContactor'] as String?,
      json['emergentContactTel'] as String?,
      json['contactorRelationship'] as String?,
      json['sexual'] as int?,
      json['address'] as String?,
      json['birth'] as String?,
      json['member'] as int?,
      dateTimeFromTimestamp(json['createDate'] as int?),
      dateTimeFromTimestamp(json['updateDate'] as int?),
      json['agreements'] as Map<String, dynamic>? ?? {},
      (json['registerTrips'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'idno': instance.idno,
      'userId': instance.userId,
      'email': instance.email,
      'name': instance.name,
      'mobile': instance.mobile,
      'emergentContactor': instance.emergentContactor,
      'emergentContactTel': instance.emergentContactTel,
      'contactorRelationship': instance.contactorRelationship,
      'sexual': instance.sexual,
      'address': instance.address,
      'birth': instance.birth,
      'member': instance.membership,
      'registerTrips': instance.registerTrips,
      'createDate': timestampFromDateTimeFromTimestamp(instance.createDate),
      'updateDate': timestampFromDateTimeFromTimestamp(instance.updateDate),
      'agreements': instance.agreements,
    };
