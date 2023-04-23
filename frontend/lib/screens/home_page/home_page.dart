import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/screens/schedule_manager/schedule_manager_page.dart';
import 'package:tripflutter/screens/schedule_selector/schedule_selector.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic selected;
  var heart = false;
  PageController controller = PageController();

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
          controller: controller,
          children: [
            ScheduleSelector(),
            // Center(child: Text('Home')),
            ScheduleManagerPage(),
            Center(child: Text('Manager')),
            Center(child: Text('Profile')),
          ],
        ),
      ),
      bottomNavigationBar: StylishBottomBar(
        items: [
          BottomBarItem(
              icon: const Icon(
                Icons.house,
              ),
              borderColor: Colors.white,
              // selectedIcon: Icon(
              //   Icons.house,
              // ),
              backgroundColor: Colors.white,
              selectedColor: MyStyles.tripTertiary,
              title: const Text(
                '行程首頁',
              )),
          BottomBarItem(
              icon: const Icon(
                Icons.local_activity,
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
          bubbleFillStyle: BubbleFillStyle.outlined,
          unselectedIconColor: Colors.white,
        ),
      ),
    );
  }
}
