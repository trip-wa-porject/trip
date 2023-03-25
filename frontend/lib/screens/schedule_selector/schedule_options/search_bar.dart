import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../../consts.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return LayoutBuilder(builder: (context, constrains) {
      return FloatingSearchBar(
        leadingActions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
              icon: const Icon(
                Icons.search_rounded,
                color: MyStyles.greyScale9E9E9E,
              ),
              onPressed: () {},
            ),
          ),
        ],
        hint: '請輸入活動編號、活動名稱、領隊嚮導名字',
        hintStyle: MyStyles.kTextStyleSubtitle1.copyWith(
          color: MyStyles.greyScale9E9E9E,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(60)),
        elevation: 0.0,
        margins: const EdgeInsets.all(0.0),
        backgroundColor: MyStyles.tripNeutral,
        backdropColor: Colors.transparent,
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 300),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: double.infinity,
        // width: isPortrait ? 600 : 1000,
        height: kSearchBarHeight,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: (query) {
          // Call your model, bloc, controller here.
          print(query);
        },
        // Specify a custom transition to be used for
        // animating between opened and closed stated.
        transition: CircularFloatingSearchBarTransition(),
        actions: [],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Text('tag?')],
                // children: Colors.accents.map((color) {
                //   return Container(height: 112, color: color);
                // }).toList(),
              ),
            ),
          );
        },
      );
    });
  }
}
