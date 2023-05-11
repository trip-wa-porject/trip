import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripflutter/component/map_widget.dart';
import 'package:tripflutter/consts.dart';

import 'gpx_controller.dart';

class GpxPage extends StatefulWidget {
  const GpxPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GpxState();
}

class GpxState extends State<GpxPage> {
  final GpxController controller = Get.put(GpxController());
  bool isWindowVisibility = false;
  MapWindowType mapWindowType = MapWindowType.info;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isWindowVisibility) isWindowVisibility = !isWindowVisibility;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('路線導覽'),
          titleTextStyle: MyStyles.kTextStyleSubtitle1.copyWith(
            color: Colors.white,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            MapWidget(gpxController: controller),
            Container(
              color: isWindowVisibility ? Colors.black.withOpacity(0.0) : null,
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    bottom: 100.0,
                    child: Visibility(
                      visible: isWindowVisibility,
                      child: getShowingFloatWindow(),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 36.0,
              left: 15.0,
              child: roundIconButton(MyStyles.tripNeutral, Icons.map_outlined,
                  MyStyles.tripTertiary, true, () {
                setState(() {
                  mapWindowType = MapWindowType.mapLayer;
                  isWindowVisibility = !isWindowVisibility;
                });
              }),
            ),
            Positioned(
              bottom: 36.0,
              right: 15.0,
              child: Row(
                children: [
                  roundIconButton(MyStyles.tripTertiary, Icons.info_outline,
                      Colors.white, false, () {
                    setState(() {
                      mapWindowType = MapWindowType.info;
                      isWindowVisibility = !isWindowVisibility;
                    });
                  }),
                  roundIconButton(MyStyles.tripTertiary,
                      Icons.business_center_outlined, Colors.white, false, () {
                    setState(() {
                      mapWindowType = MapWindowType.tools;
                      isWindowVisibility = !isWindowVisibility;
                    });
                  }),
                  roundIconButton(MyStyles.tripPrimary,
                      Icons.my_location_outlined, Colors.white, false, () {
                    setState(() {
                      controller.locationCallback?.call();
                    });
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getShowingFloatWindow() {
    if (mapWindowType == MapWindowType.tools) {
      return floatToolsWindow();
    } else if (mapWindowType == MapWindowType.mapLayer) {
      return floatMapTypeWindow();
    }
    return floatInfoWindow();
  }

  Widget floatToolsWindow() {
    return Card(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      elevation: 10,
      shadowColor: Colors.black,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 168,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            floatWindowTitle('其他工具', Icons.business_center_outlined),
            Expanded(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // floatWindowItemWithImage(
                    //     '兩點量測', 'assets/images/measure.png', 24.0, () {
                    //   controller.routeDistanceCallback?.call();
                    // }),
                    // const VerticalDivider(
                    //   thickness: 1,
                    //   indent: 0,
                    //   endIndent: 0,
                    //   color: Colors.grey,
                    // ),
                    floatWindowItemWithImage(
                        '緊急求救', 'assets/images/sos.png', 24.0, () {
                      setState(() {
                        isWindowVisibility = !isWindowVisibility;
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("注意！"),
                                content: const Text("緊急電話撥打中..."),
                                backgroundColor: Colors.white,
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: MyStyles
                                            .tripTertiary, // Background color
                                      ),
                                      child: const Text(
                                        "取消",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ],
                              );
                            });
                      });
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget floatMapTypeWindow() {
    return Card(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      elevation: 10,
      shadowColor: Colors.black,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 180,
        width: MediaQuery.of(context).size.width * 0.92,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            floatWindowTitle('選擇地圖', Icons.map_outlined),
            Expanded(
              child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    floatWindowItemWithImage(
                        '預設地圖', 'assets/images/default_map.png', 6.0, () {
                      setState(() {
                        isWindowVisibility = !isWindowVisibility;
                        controller.changeMapType(MapType.normal);
                      });
                    }),
                    floatWindowItemWithImage(
                        'Google 衛星圖', 'assets/images/satellite.png', 6.0, () {
                      setState(() {
                        isWindowVisibility = !isWindowVisibility;
                        controller.changeMapType(MapType.satellite);
                      });
                    }),
                    floatWindowItemWithImage(
                        'Google 地形圖', 'assets/images/terrain.png', 6.0, () {
                      setState(() {
                        isWindowVisibility = !isWindowVisibility;
                        controller.changeMapType(MapType.terrain);
                      });
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget floatInfoWindow() {
    return Card(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      elevation: 10,
      shadowColor: Colors.black,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            floatWindowTitle('資訊', Icons.info_outline),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
                color: Colors.white,
                child: Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(1.0),
                    1: IntrinsicColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: <Widget>[
                      columnItem('距離(km)', controller.distance.value),
                      columnItem('總花費時間(h)', controller.totalTime.value),
                      columnItem('平均速度(km/h)', controller.speed.value),
                    ]),
                    TableRow(children: <Widget>[
                      columnItem('高度落差(m)', '139'),
                      columnItem('累積爬升(m)', '201'),
                      columnItem('累積下降(m)', '182'),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget floatWindowTitle(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
      color: MyStyles.tripTertiary,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            size: 16.0,
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            width: 6.0,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: MyStyles.kTextStyleSubtitle1.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget columnItem(String title, String information) {
    return IntrinsicHeight(
      child: Column(children: <Widget>[
        Text(
          information,
          style: MyStyles.kTextStyleH3Bold
              .copyWith(color: MyStyles.greyScale424242),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              title,
              style: MyStyles.kTextStyleBody1
                  .copyWith(color: MyStyles.greyScale424242),
            ),
          ),
        ),
      ]),
    );
  }

  Widget floatWindowItemWithImage(
      String title, String imageSrc, double margin, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: margin),
          child: Column(
            children: [
              Image.asset(
                imageSrc,
                width: 100,
                height: 62,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                title,
                style: MyStyles.kTextStyleSubtitle1
                    .copyWith(color: MyStyles.greyScale424242),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget roundIconButton(Color bgColor, IconData icon, Color iconColor,
      bool isNeedBorder, void Function()? onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: SizedBox.fromSize(
        size: const Size(52, 52),
        child: ClipOval(
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
              side: BorderSide(
                  color:
                      isNeedBorder ? MyStyles.tripTertiary : Colors.transparent,
                  width: 2),
            ),
            color: bgColor,
            elevation: 5,
            shadowColor: Colors.black,
            child: InkWell(
              // splashColor: Colors.green,
              onTap: onTap,
              child: Icon(
                icon,
                size: 32.0,
                color: iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
