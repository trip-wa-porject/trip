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

class ScheduleModel {
  //title
  final String? title;

  //start_date
  final DateTime startDate;

  //end_date
  final DateTime endDate;

  //level
  final String level;

  //type
  final String type;

  //area
  final List<String> area;

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
  final String status;

  ScheduleModel({
    required this.title,
    required this.startDate,
    required this.endDate,
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

  static ScheduleModel sample() {
    return ScheduleModel(
      title: "秀霸線(四天，週五~週一)",
      startDate: DateTime(2023, 3, 31), //2023-03-31
      endDate: DateTime(2022, 4, 3),
      level: 'BK',
      type: '百岳',
      area: ["新竹縣尖石鄉", "苗栗縣泰安鄉", "台中市和平區"],
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
      status: "canceled",
    );
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
}
