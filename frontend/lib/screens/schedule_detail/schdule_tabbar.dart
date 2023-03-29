import 'package:flutter/material.dart';
import 'package:tripflutter/screens/schedule_detail/schedule_basic.dart';

import '../../models/schedule_model.dart';

class ScheduleTabBar extends StatefulWidget {
  const ScheduleTabBar({Key? key, required this.model}) : super(key: key);

  final ScheduleModel model;

  @override
  State<ScheduleTabBar> createState() => _ScheduleTabbedPageState();
}

class _ScheduleTabbedPageState extends State<ScheduleTabBar>
    with SingleTickerProviderStateMixin {
  static const List<Tab> scheduleTabs = <Tab>[
    Tab(text: '基本資料'),
    Tab(text: '交通方式'),
    Tab(text: '路線地圖'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: scheduleTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          width: double.maxFinite,
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: const Color(0xFF9e9e9e),
            controller: _tabController,
            indicatorColor: const Color(0xFFEA9F49),
            indicatorWeight: 7,
            padding: EdgeInsets.zero,
            indicatorPadding: const EdgeInsets.fromLTRB(1.5, 0, 1.5, 0),
            labelPadding: const EdgeInsets.fromLTRB(1.5, 0, 1.5, 0),
            tabs: [
              createTab(scheduleTabs[0].text!, 'tab_left'),
              createTab(scheduleTabs[1].text!, 'tab_middle'),
              createTab(scheduleTabs[2].text!, 'tab_right'),
            ],
          ),
        ),
        SizedBox(
          width: double.maxFinite,
          height: 260,
          child: TabBarView(
            controller: _tabController,
            children: [
              ScheduleBasic(model: ScheduleModel.sample(),),
              ScheduleBasic(model: ScheduleModel.sample(),),
              ScheduleBasic(model: ScheduleModel.sample(),),
            ],
            // scheduleTabs.map((Tab tab) {
            //   final String label = tab.text!.toLowerCase();
            //   return Center(
            //     child: Text(
            //       'This is the $label tab',
            //       style: const TextStyle(fontSize: 36),
            //     ),
            //   );
            // }).toList(),
          ),
        ),
      ],
    ));
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
        image: AssetImage('assets/$tabImage.png'),
        fit: BoxFit.none,
      ),
    ),
    child: Tab(
      height: 55,
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
