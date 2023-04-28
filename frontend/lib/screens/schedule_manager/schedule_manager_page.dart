import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/component/buttons.dart';
import 'package:tripflutter/component/footer.dart';
import 'package:tripflutter/consts.dart';
import 'package:tripflutter/models/gpx_model.dart';
import 'package:tripflutter/models/registration.dart';
import 'package:tripflutter/models/schedule_model.dart';
import 'package:tripflutter/screens/schedule_manager/schedule_manager_controller.dart';
import 'package:tripflutter/screens/schedule_selector/schedule_card.dart';

import '../../component/my_app_bar.dart';
import '../../component/widgets.dart';

class ScheduleManagerPage extends GetResponsiveView<ScheduleManagerController> {
  ScheduleManagerPage({Key? key}) : super(key: key);

  @override
  Widget? phone() {
    controller.setTabController(2);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('活動行程管理'),
        titleTextStyle: MyStyles.kTextStyleH2Normal.copyWith(
          color: Colors.white,
        ),
        bottom: TabBar(
          controller: controller.tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: MyStyles.kTextStyleH4,
          tabs: const [
            Tab(
              text: '已報名',
            ),
            Tab(
              text: '繼續報名',
            ),
          ],
        ),
      ),
      body: Obx(
        () {
          List<Registration> registrations =
              controller.userJoinedModel.toList();
          List<GPXModel> downloadedGpx = controller.downloadedGpx.toList();
          TabStatus status = TabStatus.register;
          switch (controller.selectedIndex.value) {
            case 0:
              registrations =
                  registrations.where((p0) => p0.status == 1).toList();
              status = TabStatus.register;
              break;
            case 1:
              registrations =
                  registrations.where((p0) => p0.status == 0).toList();
              status = TabStatus.pay;
              break;
            case 2:
              registrations =
                  registrations.where((p0) => p0.status == 3).toList();
              status = TabStatus.cancel;
              break;
            case 3:
              registrations =
                  registrations.where((p0) => p0.status == 3).toList();
              status = TabStatus.deleted;
              break;
            default:
          }

          //已付款
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
            itemCount: registrations.length,
            itemBuilder: (ctx, index) {
              return Center(
                child: FutureBuilder<ScheduleModel?>(
                  future:
                      controller.getOneTripData(registrations[index].tripId),
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ScheduleStatusCard(
                          model: snapshot.data!,
                          registration: registrations[index],
                          tabStatus: status,
                          gpxModel: downloadedGpx.firstWhereOrNull((element) =>
                              element.tripId == registrations[index].tripId),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget? desktop() {
    controller.setTabController(4);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: const MyAppBar(),
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 80,
          ),
          const Center(child: MyBackButton()),
          const SizedBox(
            height: 52,
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: kCardWidth),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '活動行程管理',
                  style: MyStyles.kTextStyleH2Bold
                      .copyWith(color: MyStyles.tripTertiary),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: SizedBox(
              width: 1160,
              child: Builder(builder: (context) {
                double borderWidth = 0.5;
                Color borderColor = MyStyles.tripPrimary;
                return Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 244, 244, 244),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    border: Border.all(color: borderColor, width: borderWidth),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: TabBar(
                    controller: controller.tabController,
                    labelPadding: const EdgeInsets.all(0),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    indicatorWeight: 0,
                    labelStyle: MyStyles.kTextStyleH3Bold.copyWith(),
                    unselectedLabelStyle: MyStyles.kTextStyleH3.copyWith(),
                    indicator: const BoxDecoration(
                      color: Colors.orange,
                      backgroundBlendMode: BlendMode.dstOver,
                    ),
                    tabs: [
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: borderColor,
                              width: borderWidth,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          child: const Center(
                            child: const Text('已報名'),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: borderColor,
                              width: borderWidth,
                            ),
                          ),
                          child: const Center(
                            child: Text('繼續報名'),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: borderColor,
                              width: borderWidth,
                            ),
                          ),
                          child: const Center(
                            child: Text('已取消'),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: borderColor,
                              width: borderWidth,
                            ),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: const Center(
                            child: Text('退票紀錄'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 44,
          ),
          Obx(
            () {
              List<Registration> registrations =
                  controller.userJoinedModel.toList();
              TabStatus status = TabStatus.register;
              switch (controller.selectedIndex.value) {
                case 0:
                  registrations =
                      registrations.where((p0) => p0.status == 1).toList();
                  status = TabStatus.register;
                  break;
                case 1:
                  registrations =
                      registrations.where((p0) => p0.status == 0).toList();
                  status = TabStatus.pay;
                  break;
                case 2:
                  registrations =
                      registrations.where((p0) => p0.status == 3).toList();
                  status = TabStatus.cancel;
                  break;
                case 3:
                  registrations =
                      registrations.where((p0) => p0.status == 3).toList();
                  status = TabStatus.deleted;
                  break;
                default:
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: registrations.length,
                itemBuilder: (ctx, index) {
                  return Center(
                    child: FutureBuilder<ScheduleModel?>(
                      future: controller
                          .getOneTripData(registrations[index].tripId),
                      builder: (ctx, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 1160,
                            ),
                            child: ScheduleStatusCard(
                              model: snapshot.data!,
                              registration: registrations[index],
                              tabStatus: status,
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: 120,
          ),
          Obx(() => controller.scheduleList.isNotEmpty
              ? Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: kCardWidth),
                    child: Row(
                      children: const [
                        Expanded(child: Divider()),
                        Text('推薦行程'),
                        Expanded(child: Divider()),
                      ],
                    ),
                  ),
                )
              : const SizedBox()),

          //推薦行程
          Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                children: controller.scheduleList
                    .map((element) => Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: kCardWidth),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: SizedBox(
                                height: kCardHeight,
                                child: ScheduleCard(
                                  model: element,
                                  index: 0,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              )),
          const SizedBox(
            height: 110,
          ),
          const Footer(),
        ],
      ),
    );
  }
}

//以下
enum TabStatus {
  register,
  pay,
  cancel,
  deleted,
}

class ScheduleStatusCard extends GetResponsiveView<ScheduleManagerController> {
  ScheduleStatusCard({
    super.key,
    required this.model,
    required this.registration,
    required this.tabStatus,
    this.gpxModel,
  }) : super(alwaysUseBuilder: false);

  final ScheduleModel model;
  final Registration registration;
  final GPXModel? gpxModel;
  final TabStatus tabStatus;

  @override
  Widget phone() {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: MyStyles.tripPrimary,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.title,
              style: MyStyles.kTextStyleH4,
            ),
            Text(
              model.getDateRageString(),
              style: MyStyles.kTextStyleSubtitle1,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: tabStatus == TabStatus.register
                  ? [
                      MyAppIconButton(
                        iconData: Icons.search,
                        label: '查看行程',
                        style: MyAppIconButton.styleOrangeBorder(),
                        onPressed: () {},
                      ),
                      const Expanded(
                        child: SizedBox(
                          width: 4,
                        ),
                      ),
                      gpxModel == null
                          ? MyAppIconButton(
                              iconData: Icons.file_download_outlined,
                              label: '下載GPX',
                              style: MyAppIconButton.styleOrangeFill(),
                              onPressed: () async {
                                await Get.find<ScheduleManagerController>()
                                    .downloadGPX(model);
                              },
                            )
                          : MyAppIconButton(
                              iconData: Icons.map,
                              label: '打開GPX',
                              style: MyAppIconButton.styleGreenFill(),
                              onPressed: () {
                                Get.toNamed(AppLinks.GPX);
                              },
                            ),
                    ]
                  : [
                      MyAppIconButton(
                        iconData: Icons.search,
                        label: '查看行程',
                        style: MyAppIconButton.styleOrangeBorder(),
                        onPressed: () {},
                      ),
                      const Expanded(
                        child: SizedBox(
                          width: 4,
                        ),
                      ),
                      MyAppIconButton(
                        iconData: Icons.attach_money,
                        label: '前往繳費',
                        style: MyAppIconButton.styleGreenFill(),
                        onPressed: () async {},
                      ),
                    ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getButtons(TabStatus status) {
    switch (status) {
      case TabStatus.register:
        return [
          MyFilledButton(
            label: '取消報名',
            style: MyOutlinedButton.style1(),
            onPressed: () {
              controller.cancelRegister(registration);
            },
          ),
        ];
      case TabStatus.pay:
        return [
          MyFilledButton(
            label: '取消報名',
            style: MyOutlinedButton.style1(),
            onPressed: () {
              controller.cancelRegister(registration);
            },
          ),
          const SizedBox(
            width: 8,
          ),
          MyFilledButton(
            label: '繼續付款',
            style: MyOutlinedButton.style1(),
            onPressed: () {
              controller.goToPayPage(registration.tripId!);
            },
          ),
        ];
      case TabStatus.cancel:
        return [
          MyFilledButton(
            label: '重新報名',
            style: MyOutlinedButton.style1(),
            onPressed: () {
              controller.retryRegister(registration);
            },
          ),
        ];
      case TabStatus.deleted:
        return [
          MyFilledButton(
            label: '重新報名',
            style: MyOutlinedButton.style1(),
            onPressed: () {
              controller.retryRegister(registration);
            },
          ),
        ];
      default:
        return [];
    }
  }

  @override
  Widget? desktop() {
    return Card(
      elevation: 8,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: MyStyles.tripPrimary,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: MyStyles.kTextStyleH4,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${model.getDateRageString()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: MyStyles.kTextStyleSubtitle1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '活動編號：${model.id}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: MyStyles.kTextStyleBody1,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MyOutlinedButton(
                      label: '查看行程',
                      style: MyOutlinedButton.style1(),
                      onPressed: () {
                        controller.goToDetailPage(registration.tripId!);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: getButtons(tabStatus),
                    ),
                  ],
                )
              ],
            ),
          ),
          PayTableInCard(
            registration: registration,
          )
        ],
      ),
    );
  }
}

class PayTableInCard extends StatelessWidget {
  const PayTableInCard({
    Key? key,
    required this.registration,
  }) : super(key: key);

  final Registration registration;

  @override
  Widget build(BuildContext context) {
    double lineWidth = 0.5;
    BoxDecoration boxDecorationTitle = BoxDecoration(
      color: MyStyles.tripNeutral,
      border: Border.all(color: MyStyles.tripPrimary, width: lineWidth),
    );
    BoxDecoration boxDecorationEdgeLeft = BoxDecoration(
      border: Border.all(color: MyStyles.tripPrimary, width: lineWidth),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10.0),
      ),
    );
    BoxDecoration boxDecorationEdgeRight = BoxDecoration(
      border: Border.all(color: MyStyles.tripPrimary, width: lineWidth),
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(10.0),
      ),
    );
    BoxDecoration boxDecoration = BoxDecoration(
      border: Border.all(color: MyStyles.tripPrimary, width: lineWidth),
    );
    BoxDecoration boxDecorationOutSide = BoxDecoration(
      border: Border.all(color: MyStyles.tripPrimary, width: lineWidth),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0),
      ),
    );
    TextStyle redText = MyStyles.kTextStyleH4.copyWith(
      fontSize: 19.36,
      color: MyStyles.redC80000,
      fontWeight: FontWeight.bold,
    );

    Map<String, String> tableColumn = {
      '繳費編號': '80808000808',
      '票種': 'VIP會員',
      '付款金額': '2400',
      '繳費狀態': '已繳費',
      '繳費方式': '匯款或無存摺存款',
      '是否成行': '成行',
    };
    return Container(
      decoration: boxDecorationOutSide,
      child: Row(
        children: tableColumn.keys.map((e) {
          late BoxDecoration decoration;
          if (e == '繳費編號') {
            decoration = boxDecorationEdgeLeft;
          } else if (e == '是否成行') {
            decoration = boxDecorationEdgeRight;
          } else {
            decoration = boxDecoration;
          }

          return Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: boxDecorationTitle,
                  child: Center(
                      child: Text(
                    e ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: MyStyles.kTextStyleSubtitle1Bold,
                  )),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: decoration,
                  child: Center(
                      child: Text(
                    tableColumn[e] ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: MyStyles.kTextStyleBody1,
                  )),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
