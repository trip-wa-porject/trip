import 'package:json_annotation/json_annotation.dart';

part 'zipcode_model.g.dart';
/*
 Map json = [{
    "districts": [
      {
        "zip": "100",
        "name": "中正區"
      },
      {
        "zip": "103",
        "name": "大同區"
      },
      {
        "zip": "104",
        "name": "中山區"
      },
      {
        "zip": "105",
        "name": "松山區"
      },
      {
        "zip": "106",
        "name": "大安區"
      },
      {
        "zip": "108",
        "name": "萬華區"
      },
      {
        "zip": "110",
        "name": "信義區"
      },...
    ],
    "name": "臺北市"
    },....]
 */

@JsonSerializable(explicitToJson: true)
class ZipCodeModelResponse {
  final List<ZipCodeModel> list;

  ZipCodeModelResponse({
    required this.list,
  });

  factory ZipCodeModelResponse.fromJson(List<dynamic> json) {
    List<ZipCodeModel> list = [];
    list = json.map((i) => ZipCodeModel.fromJson(i)).toList();

    return ZipCodeModelResponse(list: list);
  }
}

@JsonSerializable(explicitToJson: true)
class ZipCodeModel {
  final String name;
  final List<District> districts;

  ZipCodeModel({
    required this.name,
    required this.districts,
  });

  factory ZipCodeModel.fromJson(Map<String, dynamic> json) {
    return _$ZipCodeModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ZipCodeModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class District {
  final String zip;
  final String name;

  District({
    required this.zip,
    required this.name,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return _$DistrictFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}
