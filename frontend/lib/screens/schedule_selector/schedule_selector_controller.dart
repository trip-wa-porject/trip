import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/models/schedule_model.dart';
import 'package:tripflutter/modules/hike_repository.dart';

import '../schedule_detail/schdule_detail.dart';

class ScheduleSelectorController extends GetxController {
  BackendRepository backendRepository = BackendRepository();
  FloatingSearchBarController searchController = FloatingSearchBarController();
  TextEditingController searchTextController = TextEditingController();
  RxBool isLoading = false.obs;
  RxList<ScheduleModel> scheduleList = <ScheduleModel>[].obs;

  RxList<AreaOption> areaOptions = <AreaOption>[].obs;
  RxList<PriceOption> priceOptions = <PriceOption>[].obs;
  RxList<LevelOption> levelOptions = <LevelOption>[].obs;
  RxList<DayOption> dayOptions = <DayOption>[].obs;
  RxList<TypeOption> typeOptions = <TypeOption>[].obs;
  Rxn<DateTime> selectedStartDateTime = Rxn<DateTime>();
  Rxn<DateTime> selectedEndDateTime = Rxn<DateTime>();

  RxBool hasSeat = false.obs;

  selectTypeOption(List<TypeOption> options) {
    typeOptions.assignAll(options);
    typeOptions.refresh();
  }

  selectDayOption(List<DayOption> options) {
    dayOptions.assignAll(options);
    dayOptions.refresh();
  }

  selectLevelOption(List<LevelOption> options) {
    levelOptions.assignAll(options);
    levelOptions.refresh();
  }

  selectAreaOption(List<AreaOption> options) {
    areaOptions.assignAll(options);
    areaOptions.refresh();
  }

  selectPriceOption(List<PriceOption> options) {
    priceOptions.assignAll(options);
    priceOptions.refresh();
  }

  selectStartDate(DateTime dateTime) {
    selectedStartDateTime.value = dateTime;
  }

  selectEndDate(DateTime dateTime) {
    selectedEndDateTime.value = dateTime;
  }

  selectHasSeat(bool newValue) {
    hasSeat.value = !hasSeat.value;
  }

  clearAllSelected() {
    print('clearAllSelected');
    areaOptions.clear();
    priceOptions.clear();
    levelOptions.clear();
    dayOptions.clear();
    typeOptions.clear();
    selectedStartDateTime.value = null;
    selectedEndDateTime.value = null;
    hasSeat.value = false;
    searchController.query = '';
  }

  search() async {
    print('search');
    try {
      isLoading.value = true;
      Map<String, dynamic> querys = {};
      DateTime? startDate = selectedStartDateTime.value;
      DateTime? endDate = selectedEndDateTime.value;
      if (startDate != null) {
        querys.addAll({
          "startDateFrom": "${DateFormat('yyyy-MM-dd').format(startDate)}",
        });
      }
      if (endDate != null) {
        querys.addAll({
          "startDateTo": "${DateFormat('yyyy-MM-dd').format(endDate)}",
        });
      }
      List<String> selectedLevels =
          levelOptions.toList().map((e) => e.queryString).toList();
      if (selectedLevels.isNotEmpty) {
        querys.addAll({
          "level": selectedLevels,
        });
      }

      List<String> selectedTypes =
          typeOptions.toList().map((e) => '${e.showedString}步道').toList();
      if (selectedTypes.isNotEmpty) {
        querys.addAll({
          "type": selectedTypes,
        });
      }
      List<String> selectedAreas =
          areaOptions.toList().map((e) => e.showedString).toList();
      if (selectedAreas.isNotEmpty) {
        querys.addAll({
          "area": selectedAreas,
        });
      }

      List<int> selectedDays = dayOptions.toList().map((e) => e.value).toList();
      if (selectedDays.isNotEmpty) {
        querys.addAll({
          "days": selectedDays.first, //TODO修改為複選
        });
      }

      List<List<int>> selectedPrices =
          priceOptions.toList().map((e) => e.range).toList();
      if (selectedPrices.isNotEmpty) {
        querys.addAll({
          "price": selectedPrices.first, //TODO修改為複選
        });
      }

      String keyword = searchTextController.text;
      if (keyword.isNotEmpty) {
        querys.addAll({
          "keyword": keyword,
        });
      }

      print(querys);
      List<Map<String, dynamic>> result =
          await backendRepository.fetchTrip(querys);
      List<ScheduleModel> list =
          result.map((e) => ScheduleModel.fromJson(e)).toList();
      if (hasSeat.value == true) {
        list = list.where(filter).toList();
      }
      scheduleList.clear();
      scheduleList.addAll(list);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  //has seat
  bool filter(ScheduleModel model) {
    int count = model.limitation - model.applicants.length;
    if (count > 0) return true;
    return false;
  }

  goToDetail(ScheduleModel scheduleModel) {
    Get.toNamed('${AppLinks.SCHEDUL}${AppLinks.DETAIL}?id=${scheduleModel.id}',
        arguments: scheduleModel.toJson());
  }

  searchBarListener() {}

  @override
  void onInit() {
    List<ScheduleModel> list =
        List.generate(2, (index) => ScheduleModel.sampleFromJson());
    scheduleList.assignAll(list);
    searchTextController.addListener(searchBarListener);
    super.onInit();
  }

  @override
  void onClose() {
    searchTextController.removeListener(searchBarListener);
    super.onClose();
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

  @override
  String toString() => showedString;
}

enum PriceOption {
  Range1(r"NT$ 0 - NT$3,000", 0, 3000),
  Range2(r'NT$ 3,000 - NT$5,000', 3000, 5000),
  Range3(r'NT$ 5,000 - NT$7,000', 5000, 7000),
  Range4(r'NT$ 7,000 - NT$10,000', 7000, 10000),
  Range5(r'NT$ 10,000以上', 10000, 100000);

  const PriceOption(this.showedString, this.start, this.end);
  final String showedString;
  final int start;
  final int end;

  List<int> get range => [start, end];

  @override
  String toString() => showedString;
}

enum LevelOption {
  A('A.大眾路線（入門）', 'A'),
  B('B.健腳山友（中級）', 'B'),
  C('C.艱難路線（進階）', 'C');
  // K('Ｋ.特殊行程（事前繳費）');

  const LevelOption(this.showedString, this.queryString);
  final String showedString;
  final String queryString;

  @override
  String toString() => showedString;
}

enum DayOption {
  oneDays('1天內', 1),
  twoDays('2天', 2),
  threeDays('3天', 3),
  moreThanThreeDays('3天以上', 4);

  const DayOption(this.showedString, this.value);
  final String showedString;
  final int value;

  @override
  String toString() => showedString;
}

enum TypeOption {
  //郊山
  type1('郊山'),
  //中級山
  type2('中級山'),
  //百岳
  type3('百岳'),
  //海外
  type4('海外'),
  //健行
  type5('健行'),
  //攀岩/攀樹
  type6('攀岩/攀樹'),
  //溯溪
  type7('溯溪'),
  //攝影
  type8('攝影'),
  //攝影
  type9('其他');

  const TypeOption(this.showedString);
  final String showedString;

  @override
  String toString() => showedString;
}
