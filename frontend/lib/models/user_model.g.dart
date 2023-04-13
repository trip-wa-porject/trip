// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['idno'] as String?,
      json['id'] as String?,
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
      json['createDate'] as String?,
      json['updateDate'] as String?,
      json['agreements'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'idno': instance.idno,
      'id': instance.userId,
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
      'createDate': instance.createDate,
      'updateDate': instance.updateDate,
      'agreements': instance.agreements,
    };
