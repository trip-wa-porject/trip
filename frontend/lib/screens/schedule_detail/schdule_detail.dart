import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tripflutter/component/my_app_bar.dart';
import 'package:tripflutter/screens/schedule_detail/schedule_basic.dart';
import 'package:tripflutter/screens/schedule_detail/schedule_detail_controller.dart';
import 'package:tripflutter/screens/schedule_detail/schedule_main_information.dart';
import 'package:tripflutter/screens/schedule_detail/schedule_route.dart';
import 'package:tripflutter/screens/schedule_detail/schedule_transportation.dart';
import '../../component/buttons.dart';
import '../../component/footer.dart';
import '../../consts.dart';
import '../../models/schedule_model.dart';
import '../../utils/amount_format_utils.dart';
import '../../utils/date_format_utils.dart';
import '../schedule_manager/schedule_manager_controller.dart';

enum PropertyStatus {
  Order('訂單資訊'),
  Full('已額滿'),
  Apply('立即報名');

  const PropertyStatus(this.showedString);

  final String showedString;

  @override
  String toString() => showedString;
}

class ScheduleDetailPage extends GetView<ScheduleDetailController> {
  const ScheduleDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ScheduleDetailController());
    controller.getData();
    return Scaffold(
      appBar: MyAppBar(),
      body: Obx(
        () => controller.model.value == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ScheduleDetail(
                controller: controller,
                model: controller.model.value!,
                alreadyJoin: controller.userAlreadyJoin(),
              ),
      ),
    );
  }
}

class ScheduleDetail extends StatefulWidget {
  const ScheduleDetail(
      {Key? key,
      required this.controller,
      required this.model,
      this.alreadyJoin = false})
      : super(key: key);

  final ScheduleDetailController controller;
  final ScheduleModel model;
  final bool alreadyJoin;

  @override
  State<ScheduleDetail> createState() => _ScheduleDetailPageState();
}

class _ScheduleDetailPageState extends State<ScheduleDetail>
    with SingleTickerProviderStateMixin {
  static const List<Tab> scheduleTabs = <Tab>[
    Tab(text: '基本資料'),
    Tab(text: '交通方式'),
    Tab(text: '路線地圖'),
  ];

  late TabController _tabController;

  late ScrollController _scrollController;
  late double padding;

  late PropertyStatus propertyStatus;

  late ScrollController _listController;
  bool offset = true;

  @override
  void initState() {
    propertyStatus = getButtonPropertyStatus(widget.alreadyJoin,
        widget.model.price, widget.model.limitation, widget.model.applicants);
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: scheduleTabs.length);
    _tabController.addListener(_handleTabSelection);

    _listController = ScrollController();
    _listController.addListener(
        () => {widget.controller.setOffset(_listController.offset)});
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  PropertyStatus getButtonPropertyStatus(
      bool alreadyJoin, int price, int limitation, List<String> applicants) {
    if (alreadyJoin) {
      //已報名
      return PropertyStatus.Order;
    } else {
      //尚未報名
      if (price == 0) {
        //免費（可以報名嗎？）
        return PropertyStatus.Apply;
      } else {
        if (limitation == 0) {
          //人數限制：無（可無限報名）
          return PropertyStatus.Apply;
        } else {
          //人數限制：剩Ｘ人
          if (limitation - applicants.length == 0) {
            //已額滿
            return PropertyStatus.Full;
          } else {
            //立即報名
            return PropertyStatus.Apply;
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    padding = MediaQuery.of(context).size.width * 0.1;

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _listController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  height: 1700,
                  width: kCardWidth,
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: Column(
                    children: [
                      ScheduleMainInformation(
                        model: widget.model,
                        alreadyJoined: widget.alreadyJoin,
                      ),
                      Container(
                        width: kCardWidth,
                        padding: const EdgeInsets.only(top: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: kCardWidth * 0.68,
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      DecoratedTabBar(
                                        tabBar: TabBar(
                                          labelColor: Colors.white,
                                          unselectedLabelColor:
                                              MyStyles.greyScaleCFCFCE,
                                          controller: _tabController,
                                          indicatorColor: Colors.transparent,
                                          indicatorWeight: 0.01,
                                          padding: EdgeInsets.zero,
                                          indicatorPadding:
                                              const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                          labelPadding:
                                              const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                          tabs: [
                                            createTab(
                                              _tabController,
                                              0,
                                              Icons.account_box,
                                              scheduleTabs[0].text!,
                                              'tab_left',
                                            ),
                                            createTab(
                                                _tabController,
                                                1,
                                                Icons.directions_car,
                                                scheduleTabs[1].text!,
                                                'tab_middle'),
                                            createTab(
                                                _tabController,
                                                2,
                                                Icons.map,
                                                scheduleTabs[2].text!,
                                                'tab_right'),
                                          ],
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: _indicators(
                                                context,
                                                scheduleTabs.length,
                                                _tabController.index),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (_tabController.index == 0)
                                    ScheduleBasic(
                                      model: widget.model,
                                    ),
                                  if (_tabController.index == 1)
                                    ScheduleTransportation(
                                      model: widget.model,
                                    ),
                                  if (_tabController.index == 2)
                                    ScheduleRoute(
                                      model: widget.model,
                                    ),
                                ],
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible: widget.controller.offset >= 850 - 215
                                    ? false
                                    : true,
                                child: getCard(context, widget, propertyStatus),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Footer(),
            ],
          ),
        ),
        Obx(
          () => Visibility(
              visible: widget.controller.offset >= 850 - 215 ? true : false,
              child: Positioned(
                right: 0,
                left: 0,
                top: 20,
                child: Center(
                  child: SizedBox(
                    width: 1148,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: getCard(context, widget, propertyStatus),
                    ),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}

String getPropertyState(int limitation, List<String> applicants) {
  if (limitation == 0) {
    return '名額限制 無';
  } else {
    return '名額限制 '
        '${limitation > 0 ? '$limitation位 / ' : ''}';
  }
}

Widget getCard(BuildContext context, ScheduleDetail widget,
    PropertyStatus propertyStatus) {
  return Container(
    width: kCardWidth * 0.29,
    margin: const EdgeInsets.only(left: 30),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2),
        ],
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textScaleFactor: Get.textScaleFactor,
          text: TextSpan(
            text: '一般會員 ',
            style:
                MyStyles.kTextStyleH3.copyWith(color: MyStyles.greyScale000000),
            children: [
              TextSpan(
                text: 'NT\$ ${amountFormat(widget.model.memberPrice)}',
                style: MyStyles.kTextStyleH3Bold
                    .copyWith(color: MyStyles.redC80000),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        RichText(
          textScaleFactor: Get.textScaleFactor,
          text: TextSpan(
            text: 'VIP 會員 ',
            style:
                MyStyles.kTextStyleH3.copyWith(color: MyStyles.greyScale000000),
            children: [
              TextSpan(
                text: 'NT\$ ${amountFormat(widget.model.price)}',
                style: MyStyles.kTextStyleH3Bold
                    .copyWith(color: MyStyles.redC80000),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          '報名截止 ${DateFormatUtils.getDateWithSingleFullDateTemplate(widget.model.information.applyEnd!)}',
          style: MyStyles.kTextStyleSubtitle1
              .copyWith(color: MyStyles.greyScale757575),
        ),
        const SizedBox(
          height: 6.0,
        ),
        RichText(
          text: TextSpan(
            text: getPropertyState(
                widget.model.limitation, widget.model.applicants),
            style: MyStyles.kTextStyleSubtitle1
                .copyWith(color: MyStyles.greyScale757575),
            children: [
              TextSpan(
                  text: widget.model.limitation > 0
                      ? '剩${widget.model.limitation - widget.model.applicants.length}位'
                      : '',
                  style: MyStyles.kTextStyleSubtitle1
                      .copyWith(color: MyStyles.redC80000)),
            ],
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Row(
          children: [
            MyWebButton(
              label: propertyStatus.showedString,
              style: propertyStatus == PropertyStatus.Apply ||
                      propertyStatus == PropertyStatus.Order
                  ? MyWebButton.styleLargeFilledOrange()
                  : MyWebButton.styleLargeFillGrey(),
              futureFunction: propertyStatus == PropertyStatus.Apply
                  ? () async {
                      await Get.find<ScheduleManagerController>()
                          .joinNewEvent(widget.model.id, widget.model);
                    }
                  : () async {
                      if (propertyStatus == PropertyStatus.Order) {
                        await Get.find<ScheduleManagerController>()
                            .goToPayPage(widget.model.id);
                      }
                    },
            ),
            const SizedBox(width: 12),
            MyWebButton(
                label: '分享',
                iconData: Icons.share,
                style: MyWebButton.styleSmallFilledForShare(),
                onPressed: () {
                  String shareUrl =
                      'https://wa-project-mountain.web.app/schedule/detail?id=${widget.model.id}';
                  String shareContent =
                      '想要嘗試有意思的登山行程嗎？我分享了有趣的行程給你喔！\n$shareUrl';
                  Clipboard.setData(ClipboardData(text: shareContent));
                  showShareDialog(context, shareContent);
                }),
          ],
        ),
      ],
    ),
  );
}

void showShareDialog(BuildContext context, String shareContent) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("分享：已複製以下內容"),
          content: Text(shareContent),
          backgroundColor: Colors.white,
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyStyles.tripTertiary, // Background color
                ),
                child: const Text(
                  "確定",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        );
      });
}

Widget createTab(TabController tabController, int tabIndex, IconData tabIcon,
    String tabTitle, String tabImage) {
  double leftPadding = tabIndex == 0 ? 0 : 5;
  double rightPadding = tabIndex == 2 ? 0 : 5;

  return GestureDetector(
      child: Container(
    padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
    alignment: Alignment.bottomCenter,
    height: 110,
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/$tabImage.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: tabController.index == tabIndex ? 110 : 95,
            foregroundDecoration: BoxDecoration(
              color: tabController.index == tabIndex
                  ? MyStyles.greyScale6037392F
                  : MyStyles.greyScale8037392F,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: tabController.index == tabIndex ? 110 : 95,
            child: Tab(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    tabIcon,
                    color: tabController.index == tabIndex
                        ? Colors.white
                        : MyStyles.greyScaleD9D9D9,
                    size: 45,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    tabTitle,
                    style: MyStyles.kTextStyleH4Bold.copyWith(
                        color: tabController.index == tabIndex
                            ? Colors.white
                            : MyStyles.greyScaleD9D9D9),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ));
}

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  const DecoratedTabBar({super.key, required this.tabBar});

  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        tabBar,
      ],
    );
  }
}

List<Widget> _indicators(
    BuildContext context, int imagesLength, int currentIndex) {
  double leftPadding = currentIndex == 0 ? 0 : 5;
  double rightPadding = currentIndex == 2 ? 0 : 5;

  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.only(
        left: leftPadding,
        right: rightPadding,
      ),
      width: (kCardWidth * 0.68 / 3) - leftPadding - rightPadding,
      height: 6,
      decoration: BoxDecoration(
        color:
            currentIndex == index ? MyStyles.tripTertiary : Colors.transparent,
        shape: BoxShape.rectangle,
      ),
    );
  });
}
