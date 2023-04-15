// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) =>
    ScheduleModel(
      id: json['tripId'] as String,
      title: json['title'] as String,
      startDate: dateTimeFromTimestamp(json['startDate'] as int?),
      endDate: dateTimeFromTimestamp(json['endDate'] as int?),
      imageUrls:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      level: json['level'] as String,
      type: json['type'] as String,
      area: (json['area'] as List<dynamic>)
          .map((e) => Area.fromJson(e as Map<String, dynamic>))
          .toList(),
      breif: json['breif'] as String,
      memberPrice: json['memberPrice'] as int,
      price: json['price'] as int,
      applicants: (json['applicants'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      limitation: json['limitation'] as int,
      information: ScheduleInformation.fromJson(
          json['information'] as Map<String, dynamic>),
      status: json['status'] as int,
    );

Map<String, dynamic> _$ScheduleModelToJson(ScheduleModel instance) =>
    <String, dynamic>{
      'tripId': instance.id,
      'title': instance.title,
      'startDate': timestampFromDateTimeFromTimestamp(instance.startDate),
      'endDate': timestampFromDateTimeFromTimestamp(instance.endDate),
      'images': instance.imageUrls,
      'level': instance.level,
      'type': instance.type,
      'area': instance.area.map((e) => e.toJson()).toList(),
      'breif': instance.breif,
      'memberPrice': instance.memberPrice,
      'price': instance.price,
      'applicants': instance.applicants,
      'limitation': instance.limitation,
      'information': instance.information.toJson(),
      'status': instance.status,
    };

Area _$AreaFromJson(Map<String, dynamic> json) => Area(
      json['city'] as String,
      json['county'] as String,
    );

Map<String, dynamic> _$AreaToJson(Area instance) => <String, dynamic>{
      'city': instance.city,
      'county': instance.county,
    };

ScheduleInformation _$ScheduleInformationFromJson(Map<String, dynamic> json) =>
    ScheduleInformation(
      applyStart: dateTimeFromTimestamp(json['applyStart'] as int?),
      applyEnd: dateTimeFromTimestamp(json['applyEnd'] as int?),
      applyWay: json['applyWay'] as String,
      gatherPlace: json['gatherPlace'] as String,
      gatherTime: dateTimeFromTimestamp(json['gatherTime'] as int?),
      transportationWay: json['transportationWay'] as String,
      transportationInfo: json['transportationInfo'] as String,
      preDepartureMeetingDate:
          dateTimeFromTimestamp(json['preDepartureMeetingDate'] as int?),
      preDepartureMeetingPlace: json['preDepartureMeetingPlace'] as String,
      memo: json['memo'] as String,
      leader: json['leader'] as String,
      guides:
          (json['guides'] as List<dynamic>).map((e) => e as String).toList(),
      note: json['note'] as String,
    );

Map<String, dynamic> _$ScheduleInformationToJson(
        ScheduleInformation instance) =>
    <String, dynamic>{
      'applyStart': timestampFromDateTimeFromTimestamp(instance.applyStart),
      'applyEnd': timestampFromDateTimeFromTimestamp(instance.applyEnd),
      'applyWay': instance.applyWay,
      'gatherPlace': instance.gatherPlace,
      'gatherTime': timestampFromDateTimeFromTimestamp(instance.gatherTime),
      'transportationWay': instance.transportationWay,
      'transportationInfo': instance.transportationInfo,
      'preDepartureMeetingDate':
          timestampFromDateTimeFromTimestamp(instance.preDepartureMeetingDate),
      'preDepartureMeetingPlace': instance.preDepartureMeetingPlace,
      'memo': instance.memo,
      'leader': instance.leader,
      'guides': instance.guides,
      'note': instance.note,
    };
