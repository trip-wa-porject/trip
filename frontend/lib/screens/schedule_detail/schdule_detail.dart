import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/screens/schedule_detail/schedule_basic.dart';
import 'package:tripflutter/screens/schedule_detail/schedule_main_information.dart';
import 'package:tripflutter/screens/schedule_detail/schedule_route.dart';
import 'package:tripflutter/screens/schedule_detail/schedule_transportation.dart';
import '../../consts.dart';
import '../../models/schedule_model.dart';

class ScheduleDetail extends StatefulWidget {
  const ScheduleDetail({Key? key, required this.model}) : super(key: key);

  final ScheduleModel model;

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
  late bool fixedScroll;
  late double padding;

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: scheduleTabs.length);
    super.initState();
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

    return Container(
        alignment: Alignment.topCenter,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          right: padding,
          left: padding,
        ),
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: ScheduleMainInformation(
                  model: widget.model,
                ),
              ),
              SliverToBoxAdapter(
                child: DecoratedTabBar(
                  tabBar: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: MyStyles.greyScaleCFCFCE,
                    controller: _tabController,
                    indicatorColor: MyStyles.tripPrimary,
                    indicatorWeight: 6,
                    padding: EdgeInsets.zero,
                    indicatorPadding: const EdgeInsets.fromLTRB(1.5, 0, 1.5, 0),
                    labelPadding: const EdgeInsets.fromLTRB(1.5, 0, 1.5, 0),
                    tabs: [
                      createTab(scheduleTabs[0].text!, 'tab_left'),
                      createTab(scheduleTabs[1].text!, 'tab_middle'),
                      createTab(scheduleTabs[2].text!, 'tab_right'),
                    ],
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: MyStyles.tripSecondaryF8D797,
                        width: 6.0,
                      ),
                    ),
                  ),
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
    );
  }
}

Widget createTab(String tabTitle, String tabImage) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20.0),
        topLeft: Radius.circular(20.0),
      ),
      image: DecorationImage(
        colorFilter: const ColorFilter.mode(Color(0x80FFFFFF), BlendMode.color),
        image: AssetImage('assets/images/$tabImage.png'),
        fit: BoxFit.none,
      ),
    ),
    child: Tab(
      height: 103,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.assignment_ind),
          const SizedBox(
            width: 8,
          ),
          Text(tabTitle),
        ],
      ),
    ),
  );
}

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  const DecoratedTabBar(
      {super.key, required this.tabBar, required this.decoration});

  final TabBar tabBar;
  final BoxDecoration decoration;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            left: 1.5, right: 1.5, child: Container(decoration: decoration)),
        tabBar,
      ],
    );
  }
}
