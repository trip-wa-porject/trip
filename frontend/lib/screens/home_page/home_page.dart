import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:tripflutter/component/buttons.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/modules/auth_service.dart';
import 'package:tripflutter/screens/home_page/home_page_controller.dart';
import 'package:tripflutter/screens/profile_page/profile_page.dart';
import 'package:tripflutter/screens/schedule_manager/schedule_manager_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic selected;
  var heart = false;
  PageController controller = PageController();
  HomePageController homepageController = Get.put(HomePageController());

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const ClampingScrollPhysics(),
          controller: controller,
          onPageChanged: (value) {
            print('change page :$value');
            setState(() {
              selected = value;
            });
          },
          children: [
            ScheduleManagerPage(),
            const ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: StylishBottomBar(
        items: [
          BottomBarItem(
              icon: const Icon(
                Icons.hiking,
              ),
              borderColor: Colors.white,
              backgroundColor: Colors.white,
              selectedColor: MyStyles.tripTertiary,
              title: const Text(
                '活動管理',
              )),
          BottomBarItem(
              icon: const Icon(
                Icons.person,
              ),
              borderColor: Colors.white,
              backgroundColor: Colors.white,
              selectedColor: MyStyles.tripTertiary,
              title: const Text(
                '會員資料',
              )),
        ],
        backgroundColor: MyStyles.tripTertiary,
        currentIndex: selected ?? 0,
        onTap: (index) {
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
        option: BubbleBarOptions(
          borderRadius: BorderRadius.circular(10),
          bubbleFillStyle: BubbleFillStyle.outlined,
          unselectedIconColor: Colors.white,
        ),
      ),
    );
  }
}
