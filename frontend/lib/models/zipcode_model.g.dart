// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zipcode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZipCodeModel _$ZipCodeModelFromJson(Map<String, dynamic> json) => ZipCodeModel(
      name: json['name'] as String,
      districts: (json['districts'] as List<dynamic>)
          .map((e) => District.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ZipCodeModelToJson(ZipCodeModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'districts': instance.districts.map((e) => e.toJson()).toList(),
    };

District _$DistrictFromJson(Map<String, dynamic> json) => District(
      zip: json['zip'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$DistrictToJson(District instance) => <String, dynamic>{
      'zip': instance.zip,
      'name': instance.name,
    };
