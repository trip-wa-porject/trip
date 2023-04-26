import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/component/map_widget.dart';
import 'package:tripflutter/consts.dart';

import 'gpx_controller.dart';

class GpxPage extends StatefulWidget {
  const GpxPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GpxState();
}

class GpxState extends State<GpxPage> {
  // with SingleTickerProviderStateMixin
  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(seconds: 2),
  //   vsync: this,
  // )..repeat(reverse: true);
  // late final Animation<Offset> _offsetAnimation = Tween<Offset>(
  //   begin: Offset.zero,
  //   end: const Offset(1.5, 0.0),
  // ).animate(CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.elasticIn,
  // ));

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final GpxController controller = Get.put(GpxController());

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const MapWidget(),
        // Positioned(
        //   bottom: 100.0,
        //   child: showFloatInfoWindow(true, context),
        // ),
        // SlideTransition(
        //   position: _offsetAnimation,
        //   child: Positioned(
        //     bottom: 100.0,
        //     child: showFloatInfoWindow(true, context),
        //   ),
        // ),
        // Positioned(
        //   bottom: 36.0,
        //   left: 15.0,
        //   child:
        //       roundIconButton(MyStyles.tripNeutral, Icons.map_outlined, () {}),
        // ),
        // Positioned(
        //   bottom: 36.0,
        //   right: 15.0,
        //   child: Row(
        //     children: [
        //       roundIconButton(MyStyles.tripTertiary, Icons.info_outline, () {
        //         // setState(() {
        //         //   _visible = !_visible;
        //         // });
        //       }),
        //       roundIconButton(
        //           MyStyles.tripTertiary, Icons.business_center_outlined, () {}),
        //       roundIconButton(
        //           MyStyles.tripPrimary, Icons.near_me_outlined, () {}),
        //     ],
        //   ),
        // )
      ],
    );
  }
}

Widget showFloatInfoWindow(bool isVisible, BuildContext context) {
  return Container(
      height: MediaQuery.of(context).size.height / 5,
      // color: Colors.white,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
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
        children: [
          floatWindowTitle('資訊', Icons.info_outline),
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              floatWindowItemWithImage('衛星地圖', 'images/forest.jpg'),
              floatWindowItemWithImage('地形地圖', 'images/forest.jpg'),
            ],
          ),
        ],
      ));
}

Widget floatWindowTitle(String title, IconData icon) {
  return Container(
    padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
    color: MyStyles.tripTertiary,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          title,
          style: MyStyles.kTextStyleSubtitle1.copyWith(color: Colors.white),
        ),
      ],
    ),
  );
}

Widget floatWindowItemWithImage(String title, String imageSrc) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Image.asset(imageSrc),
      const Icon(
        Icons.abc_outlined,
        color: Colors.black,
      ),
      Text(
        title,
        style: MyStyles.kTextStyleH3.copyWith(color: MyStyles.greyScale424242),
      )
    ],
  );
}

Widget roundIconButton(Color bgColor, IconData icon, Function()? onTap) {
  return Padding(
    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
    child: SizedBox.fromSize(
      size: const Size(52, 52),
      child: ClipOval(
        child: Material(
          color: bgColor,
          elevation: 5,
          shadowColor: Colors.yellow,
          child: InkWell(
            // splashColor: Colors.green,
            onTap: onTap,
            child: Icon(
              icon,
              size: 32.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
