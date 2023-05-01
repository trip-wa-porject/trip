import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:get/get.dart';
import 'package:tripflutter/screens/admin_user_pages/admin_trip_manager.dart';
import 'package:tripflutter/screens/admin_user_pages/admin_user_page_controller.dart';

import 'admin_register_manager.dart';

class AdminUserHomePage extends StatefulWidget {
  const AdminUserHomePage({Key? key}) : super(key: key);

  @override
  State<AdminUserHomePage> createState() => _AdminUserHomePageState();
}

class _AdminUserHomePageState extends State<AdminUserHomePage> {
  int _currentIndex = 0;
  SideMenuController sideMenuController = SideMenuController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: MyAppBar(),
        body: Row(
      children: [
        SideMenu(
          controller: sideMenuController,
          backgroundColor: Colors.blueGrey,
          mode: SideMenuMode.open,
          builder: (data) => SideMenuData(
            header: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            items: [
              SideMenuItemDataTile(
                isSelected: _currentIndex == 0,
                onTap: () {
                  setState(() => _currentIndex = 0);
                },
                title: 'Dashboard',
                icon: const Icon(Icons.home),
              ),
              SideMenuItemDataTile(
                isSelected: _currentIndex == 1,
                onTap: () {
                  setState(() => _currentIndex = 1);
                },
                title: '行程管理',
                icon: const Icon(Icons.list_alt),
              ),
              SideMenuItemDataTile(
                isSelected: _currentIndex == 2,
                onTap: () {
                  setState(() => _currentIndex = 2);
                },
                title: '報名管理',
                icon: const Icon(Icons.app_registration),
              ),
              SideMenuItemDataTile(
                isSelected: false,
                onTap: () {
                  Get.find<AdminUserPageController>().signOutAdmin();
                },
                title: '退出',
                icon: const Icon(Icons.exit_to_app_sharp),
              ),
            ],
            footer: const Text('Footer'),
          ),
        ),
        Expanded(
          child: Container(
              color: Colors.white,
              child: Builder(
                builder: (ctx) {
                  if (_currentIndex == 0)
                    return Center(
                      child: Text(
                        'body',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    );
                  if (_currentIndex == 1) return AdminTripManager();
                  if (_currentIndex == 2) return AdminRegisterManager();
                  return Center(
                    child: Text('unknow'),
                  );
                },
              )),
        ),
      ],
    ));
  }
}
