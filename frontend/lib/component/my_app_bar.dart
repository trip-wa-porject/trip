import 'package:flutter/material.dart';

import '../consts.dart';
import 'widgets.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle appBarTextStyle =
        MyStyles.kTextStyleH4.copyWith(color: Colors.white);
    SizedBox appBarSpacer = const SizedBox(width: 24.0);

    return AppBar(
      backgroundColor: MyStyles.tripTertiary,
      title: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1160,
            maxHeight: 57,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Logo(),
              Row(
                children: [
                  Text(
                    '關於我們',
                    style: appBarTextStyle,
                  ),
                  appBarSpacer,
                  Text(
                    '路線資訊',
                    style: appBarTextStyle,
                  ),
                  appBarSpacer,
                  Text(
                    '主題活動',
                    style: appBarTextStyle,
                  ),
                  appBarSpacer,
                  Text(
                    '登山小學堂',
                    style: appBarTextStyle,
                  ),
                  appBarSpacer,
                  Text(
                    '會員專區',
                    style: appBarTextStyle,
                  ),
                  appBarSpacer,
                  Text(
                    '註冊',
                    style: appBarTextStyle,
                  ),
                  appBarSpacer,
                  FilledButton(
                    onPressed: () {},
                    child: Text('登入'),
                    style: FilledButton.styleFrom(
                      backgroundColor: MyStyles.tripNeutral,
                      foregroundColor: MyStyles.tripTertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      toolbarHeight: 120,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
