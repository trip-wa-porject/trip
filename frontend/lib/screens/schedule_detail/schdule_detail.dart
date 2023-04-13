import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/component/my_app_bar.dart';
import 'package:tripflutter/screens/schedule_detail/schedule_basic.dart';
import 'package:tripflutter/screens/schedule_detail/schedule_detail_controller.dart';
import 'package:tripflutter/screens/schedule_detail/schedule_main_information.dart';
import 'package:tripflutter/screens/schedule_detail/schedule_route.dart';
import 'package:tripflutter/screens/schedule_detail/schedule_transportation.dart';
import '../../consts.dart';
import '../../models/schedule_model.dart';

class ScheduleDetailPage extends GetView<ScheduleDetailController> {
  const ScheduleDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ScheduleDetailController());

    return Scaffold(
      appBar: MyAppBar(),
      body: Obx(
        () => controller.model.value == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ScheduleDetail(
                model: controller.model.value!,
                alreadyJoin: controller.userAlreadyJoin(),
              ),
      ),
    );
  }
}

class ScheduleDetail extends StatefulWidget {
  const ScheduleDetail(
      {Key? key, required this.model, this.alreadyJoin = false})
      : super(key: key);

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

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: scheduleTabs.length);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    padding = MediaQuery.of(context).size.width * 0.1;

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        color: MyStyles.greyScaleF4F4F4,
        padding: EdgeInsets.only(
          right: padding,
          left: padding,
        ),
        child: SizedBox(
          height: 1500,
          width: MediaQuery.of(context).size.width * 0.8,
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(
                  child: ScheduleMainInformation(
                    model: widget.model,
                    alreadyJoined: widget.alreadyJoin,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      DecoratedTabBar(
                        tabBar: TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: MyStyles.greyScaleCFCFCE,
                          controller: _tabController,
                          indicatorColor: Colors.transparent,
                          indicatorWeight: 0.01,
                          padding: EdgeInsets.zero,
                          indicatorPadding:
                              const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          labelPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          tabs: [
                            createTab(_tabController, 0, Icons.account_box,
                                scheduleTabs[0].text!, 'tab_left'),
                            createTab(_tabController, 1, Icons.directions_car,
                                scheduleTabs[1].text!, 'tab_middle'),
                            createTab(_tabController, 2, Icons.map,
                                scheduleTabs[2].text!, 'tab_right'),
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _indicators(context, scheduleTabs.length,
                                _tabController.index),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ScheduleBasic(
                  model: widget.model,
                ),
                ScheduleTransportation(
                  model: widget.model,
                ),
                ScheduleRoute(
                  model: widget.model,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget createTab(TabController tabController, int tabIndex, IconData tabIcon,
    String tabTitle, String tabImage) {
  double leftPadding = tabIndex == 0 ? 0 : 5;
  double rightPadding = tabIndex == 2 ? 0 : 5;

  return Container(
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
                    style: MyStyles.kTextStyleH3Bold.copyWith(
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
  );
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
      width: ((MediaQuery.of(context).size.width * 0.8) / 3) -
          leftPadding -
          rightPadding,
      height: 6,
      decoration: BoxDecoration(
        color:
            currentIndex == index ? MyStyles.tripTertiary : Colors.transparent,
        shape: BoxShape.rectangle,
      ),
    );
  });
}
