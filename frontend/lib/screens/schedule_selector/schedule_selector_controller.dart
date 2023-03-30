import 'package:get/get.dart';
import 'package:tripflutter/models/schedule_model.dart';

class ScheduleSelectorController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<AreaOption> areaOptions = <AreaOption>[].obs;
  List<PriceOption> priceOptions = <PriceOption>[].obs;
  List<LevelOption> levelOptions = <LevelOption>[].obs;
  List<DayOption> dayOptions = <DayOption>[].obs;
  List<TypeOption> typeOptions = <TypeOption>[].obs;

  RxList<ScheduleModel> scheduleList = <ScheduleModel>[].obs;

  clearAllSelected() {
    print('clearAllSelected');
  }

  search() async {
    print('search');
    isLoading.value = true;
    List<ScheduleModel> list =
        List.generate(3, (index) => ScheduleModel.sample());
    scheduleList.addAll(list);
    await 3.delay();
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
  }
}

enum AreaOption {
  //南投縣
  NantouCity('南投縣'),
  //台北市
  TaipeiCity('台北市'),
  //台中市
  TaichungCity('台中市'),
  //台南市
  TainanCity('台南市'),
  //高雄市
  KaohsiungCity('高雄市'),
  //台東縣
  TaitungCity('台東縣'),
  //雲林縣
  YunlinCity('雲林縣'),
  //嘉義縣
  ChiayiCity('嘉義縣'),
  //新北市
  NewTaipeiCity('新北市'),
  //桃園市
  TaoyuanCity('桃園市'),
  //基隆市
  KeelungCity('基隆市'),
  //新竹市
  HsinchuCity('新竹市'),
  //花蓮縣
  HualienCity('花蓮縣'),
  //苗栗縣
  MiaoliCity('苗栗縣'),
  //彰化縣
  ChanghuaCity('彰化縣'),
  //屏東縣
  PingtungCity('屏東縣'),
  //宜蘭縣
  YilanCity('宜蘭縣'),
  //澎湖縣
  PenghuCity('澎湖縣');

  const AreaOption(this.showedString);
  final String showedString;
}

enum PriceOption {
  Range1(r"NT$ 0 - NT$3,000"),
  Range2(r'NT$ 3,000 - NT$5,000'),
  Range3(r'NT$ 5,000 - NT$7,000'),
  Range4(r'NT$ 7,000 - NT$10,000'),
  Range5(r'NT$ 10,000以上');

  const PriceOption(this.showedString);
  final String showedString;
}

enum LevelOption {
  A('A.大眾路線（入門）'),
  B('B.健腳山友（中級）'),
  C('C.艱難路線（進階）'),
  K('Ｋ.特殊行程（事前繳費）');

  const LevelOption(this.showedString);
  final String showedString;
}

enum DayOption {
  oneDays('1天內'),
  twoDays('2天'),
  threeDays('3天'),
  moreThanThreeDays('3天以上');

  const DayOption(this.showedString);
  final String showedString;
}

enum TypeOption {
  //郊山
  type1('郊山'),
  //中級山
  type2('中級山'),
  //百岳
  type3('百岳');

  const TypeOption(this.showedString);
  final String showedString;
}
