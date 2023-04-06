// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) =>
    ScheduleModel(
      id: json['id'] as String,
      title: json['title'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
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
      applicants: json['applicants'] as int,
      limitation: json['limitation'] as int,
      information: ScheduleInformation.fromJson(
          json['information'] as Map<String, dynamic>),
      status: json['status'] as int,
    );

Map<String, dynamic> _$ScheduleModelToJson(ScheduleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'images': instance.imageUrls,
      'level': instance.level,
      'type': instance.type,
      'area': instance.area,
      'breif': instance.breif,
      'memberPrice': instance.memberPrice,
      'price': instance.price,
      'applicants': instance.applicants,
      'limitation': instance.limitation,
      'information': instance.information,
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
      applyStart: DateTime.parse(json['applyStart'] as String),
      applyEnd: DateTime.parse(json['applyEnd'] as String),
      applyWay: json['applyWay'] as String,
      gatherPlace: json['gatherPlace'] as String,
      gatherTime: DateTime.parse(json['gatherTime'] as String),
      transportationWay: json['transportationWay'] as String,
      transportationInfo: json['transportationInfo'] as String,
      preDepartureMeetingDate:
          DateTime.parse(json['preDepartureMeetingDate'] as String),
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
      'applyStart': instance.applyStart.toIso8601String(),
      'applyEnd': instance.applyEnd.toIso8601String(),
      'applyWay': instance.applyWay,
      'gatherPlace': instance.gatherPlace,
      'gatherTime': instance.gatherTime.toIso8601String(),
      'transportationWay': instance.transportationWay,
      'transportationInfo': instance.transportationInfo,
      'preDepartureMeetingDate':
          instance.preDepartureMeetingDate.toIso8601String(),
      'preDepartureMeetingPlace': instance.preDepartureMeetingPlace,
      'memo': instance.memo,
      'leader': instance.leader,
      'guides': instance.guides,
      'note': instance.note,
    };
