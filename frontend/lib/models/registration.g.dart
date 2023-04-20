// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Registration _$RegistrationFromJson(Map<String, dynamic> json) => Registration(
      json['tripId'] as String?,
      json['userId'] as String?,
      json['price'] as int?,
      dateTimeFromTimestamp(json['paymentExpireDate'] as int?),
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
      'paymentExpireDate':
          timestampFromDateTimeFromTimestamp(instance.paymentExpireDate),
      'paymentInfo': instance.paymentInfo,
      'status': instance.status,
      'createDate': timestampFromDateTimeFromTimestamp(instance.createDate),
      'updateDate': timestampFromDateTimeFromTimestamp(instance.updateDate),
    };
