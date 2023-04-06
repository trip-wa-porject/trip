import 'package:json_annotation/json_annotation.dart';

part 'schedule_model.g.dart';
/*

 Map jspn = {
      "title": "秀霸線(四天，週五~週一)",
      "start_date": "2023-03-31",
      "end_date": "2023-04-03",
      "level": "BK",
      "type": "百岳",
      "area": ["新竹縣尖石鄉", "苗栗縣泰安鄉", "台中市和平區"],
      "breif":
          "秀霸線包含池有山、品田山、布秀蘭山、巴紗拉雲山、大霸尖山、小霸尖山、伊澤山和加利山。有別於傳統路線，來趟秀霸連走讚嘆這巍峨神聖的稜線。",
      "member_price": 5000,
      "price": 5200,
      "applicants": 0,
      "limitation": 20,
      "information": {
        "apply_start": "2022-10-03",
        "apply_end": "2023-01-10",
        "apply_way": "向活動收費組報名,亦開放線上報名",
        "gather_place": "新埔捷運站２號出口",
        "gather_time": "3/30下午14:00",
        "transportation_way": "專車",
        "transportation_info": "前一天下午二點集合",
        "pre_departure_meeting_date": "2023/01/12 20:00",
        "pre_departure_meeting_place": "220 新北市 板橋區 陽明街76號5樓",
        "memo": "食宿另計",
        "leader": "呂萬龍 0918122870",
        "guides": ["林麗英", "吳泰學", "陳尚融", "林盈吉"],
        "note": ""
      },
      "status": "canceled"
    };
 */

@JsonSerializable()
class ScheduleModel {
  String id;

  //title
  final String title;

  //start_date
  final DateTime startDate;

  //end_date
  final DateTime endDate;

  @JsonKey(name: 'images')
  final List<String> imageUrls;

  //level
  final String level;

  //type
  final String type;

  //area
  final List<Area> area;

  //breif
  final String breif;

  //member_price
  final int memberPrice;

  //price
  final int price;

  //applicants
  final int applicants;

  //limitation
  final int limitation;

  //information
  final ScheduleInformation information;

  //status
  final int status;

  ScheduleModel({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.imageUrls,
    required this.level,
    required this.type,
    required this.area,
    required this.breif,
    required this.memberPrice,
    required this.price,
    required this.applicants,
    required this.limitation,
    required this.information,
    required this.status,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return _$ScheduleModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);

  static ScheduleModel sample() {
    return ScheduleModel(
      id: '1',
      title: "秀霸線",
      startDate: DateTime(2023, 3, 31), //2023-03-31
      endDate: DateTime(2023, 4, 3),
      imageUrls: [
        'https://cdntwrunning.biji.co/800_74e082409a0b128a84a0cc4ff9ff494bde926f8df342a0394ea9358938f32f17.jpg'
      ],
      level: 'BK',
      type: '百岳',
      area: [Area("新竹縣", "新竹縣"), Area("苗栗縣", "泰安鄉"), Area('台中市', '和平區')],
      breif:
          "秀霸線包含池有山、品田山、布秀蘭山、巴紗拉雲山、大霸尖山、小霸尖山、伊澤山和加利山。有別於傳統路線，來趟秀霸連走讚嘆這巍峨神聖的稜線。",
      memberPrice: 5000,
      price: 5200,
      applicants: 0,
      limitation: 20,
      information: ScheduleInformation(
        applyStart: DateTime(2022, 10, 03),
        applyEnd: DateTime(2022, 1, 10),
        applyWay: "向活動收費組報名,亦開放線上報名",
        gatherPlace: "新埔捷運站２號出口",
        gatherTime: DateTime(2022, 3, 30, 14), //3/30下午14:00
        transportationWay: "專車",
        transportationInfo: "前一天下午二點集合",
        preDepartureMeetingDate:
            DateTime(2023, 1, 12, 20), //"2023/01/12 20:00",
        preDepartureMeetingPlace: "220 新北市 板橋區 陽明街76號5樓",
        memo: "食宿另計",
        leader: "呂萬龍 0918122870",
        guides: ["林麗英", "吳泰學", "陳尚融", "林盈吉"],
        note: "",
      ),
      status: 0,
    );
  }

  static ScheduleModel sampleFromJson() {
    Map<String, dynamic> map = {
      "id": "104",
      "area": [
        {'city': '新北市', 'county': '土城區'}
      ],
      "limitation": 12,
      "images": [
        "https://cdntwrunning.biji.co/600_faf2493ca508b44713cfde49f54a92ef.jpg"
      ],
      "endDate": "2023-04-23",
      "level": "C",
      "memberPrice": 1344,
      "applicants": 3,
      "breif":
          "秀霸線包含池有山、品田山、布秀蘭山、巴紗拉雲山、大霸尖山、小霸尖山、伊澤山和加利山。有別於傳統路線，來趟秀霸連走讚嘆這巍峨神聖的稜線。",
      "title": "天上山步道",
      "type": "郊山步道",
      "url": "https://hiking.biji.co/index.php?q=trail&act=detail&id=104",
      "roadImage":
          "https://cdntwrunning.biji.co/600_faf2493ca508b44713cfde49f54a92ef.jpg",
      "price": 844,
      "information": {
        "gatherPlace": "新埔捷運站２號出口",
        "leader": "呂萬龍 0918122870",
        "note": "",
        "preDepartureMeetingPlace": "220 新北市 板橋區 陽明街76號5樓",
        "memo": "食宿另計",
        "arriveSite": "在山腳下",
        "transportationWay": "專車",
        "guides": ["林麗英", "吳泰學", "陳尚融", "林盈吉"],
        "applyWay": "向活動收費組報名,亦開放線上報名",
        "applyEnd": "2023-03-11",
        "gatherTime": "2023-04-20T06:00",
        "preDepartureMeetingDate": "2023-04-20T06:00",
        "applyStart": "2023-02-26",
        "transportationInfo": "前一天下午二點集合"
      },
      "startDate": "2023-04-20",
      "status": 0
    };
    return ScheduleModel.fromJson(map);
  }
}

/*
      "information": {
        "apply_start": "2022-10-03",
        "apply_end": "2023-01-10",
        "apply_way": "向活動收費組報名,亦開放線上報名",
        "gather_place": "新埔捷運站２號出口",
        "gather_time": "3/30下午14:00",
        "transportation_way": "專車",
        "transportation_info": "前一天下午二點集合",
        "pre_departure_meeting_date": "2023/01/12 20:00",
        "pre_departure_meeting_place": "220 新北市 板橋區 陽明街76號5樓",
        "memo": "食宿另計",
        "leader": "呂萬龍 0918122870",
        "guides": ["林麗英", "吳泰學", "陳尚融", "林盈吉"],
        "note": ""
      }
 */

@JsonSerializable()
class Area {
  Area(this.city, this.county);
  final String city;
  final String county;
  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);

  Map<String, dynamic> toJson() => _$AreaToJson(this);

  @override
  String toString() {
    return '$city$county';
  }
}

@JsonSerializable()
class ScheduleInformation {
  ScheduleInformation({
    required this.applyStart,
    required this.applyEnd,
    required this.applyWay,
    required this.gatherPlace,
    required this.gatherTime,
    required this.transportationWay,
    required this.transportationInfo,
    required this.preDepartureMeetingDate,
    required this.preDepartureMeetingPlace,
    required this.memo,
    required this.leader,
    required this.guides,
    required this.note,
  });
  //apply_start
  final DateTime applyStart;
  //apply_end
  final DateTime applyEnd;

  //apply_way
  final String applyWay;

  //gather_place
  final String gatherPlace;

  //gather_time
  final DateTime gatherTime;

  //transportation_way
  final String transportationWay;

  //transportation_info
  final String transportationInfo;

  //pre_departure_meeting_date
  final DateTime preDepartureMeetingDate;

  //pre_departure_meeting_place
  final String preDepartureMeetingPlace;

  //memo
  final String memo;

  //leader
  final String leader;

  //guides
  final List<String> guides;

  //note
  final String note;

  factory ScheduleInformation.fromJson(Map<String, dynamic> json) =>
      _$ScheduleInformationFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleInformationToJson(this);
}
