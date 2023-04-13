// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Registration _$RegistrationFromJson(Map<String, dynamic> json) => Registration(
      json['tripId'] as String?,
      json['userId'] as String?,
      json['price'] as int?,
      json['paymentExpireDate'] == null
          ? null
          : DateTime.parse(json['paymentExpireDate'] as String),
      json['paymentInfo'] as Map<String, dynamic>?,
      json['status'] as int?,
      dateTimeFromTimestamp(json['createDate'] as int?),
      dateTimeFromTimestamp(json['updateDate'] as int?),
    );

Map<String, dynamic> _$RegistrationToJson(Registration instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'userId': instance.userId,
      'price': instance.price,
      'paymentExpireDate': instance.paymentExpireDate?.toIso8601String(),
      'paymentInfo': instance.paymentInfo,
      'status': instance.status,
      'createDate': timestampFromDateTimeFromTimestamp(instance.createDate),
      'updateDate': timestampFromDateTimeFromTimestamp(instance.updateDate),
    };
