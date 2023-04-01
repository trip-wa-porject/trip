import 'package:flutter_test/flutter_test.dart';
import 'package:tripflutter/models/schedule_model.dart';

void main() {
  test('testModel', () {
    Map<String, dynamic> map = {
      "id": "104",
      "area": ["新北市土城區"],
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
    ScheduleModel result = ScheduleModel.fromJson(map);
    expect(result.status, 0);
  });
}
