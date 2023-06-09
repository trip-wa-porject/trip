import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
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
    // controller.setTabController(2);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('活動行程管理'),
          titleTextStyle: MyStyles.kTextStyleH2Normal.copyWith(
            color: Colors.white,
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: MyStyles.kTextStyleH4,
            onTap: (index) {
              controller.selectedIndex.value = index;
            },
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
        body: TabBarView(
          children: [
            Obx(
              () {
                if (controller.isLoading.value) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ScheduleStatusCardSkeleton(),
                        );
                      });
                }

                List<Registration> registrations =
                    controller.userJoinedModel.toList();
                List<GPXModel> downloadedGpx =
                    controller.downloadedGpx.toList();
                TabStatus status = TabStatus.register;
                switch (0) {
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
                        registrations.where((p0) => p0.status == 2).toList();
                    status = TabStatus.waitCheck;
                    break;
                  default:
                }

                //已付款
                return ListView.builder(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                  itemCount: registrations.length,
                  itemBuilder: (ctx, index) {
                    return Center(
                      child: FutureBuilder<ScheduleModel?>(
                        future: controller
                            .getOneTripData(registrations[index].tripId),
                        builder: (ctx, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ScheduleStatusCard(
                                model: snapshot.data!,
                                registration: registrations[index],
                                tabStatus: status,
                                gpxModel: downloadedGpx.firstWhereOrNull(
                                    (element) =>
                                        element.tripId ==
                                        registrations[index].tripId),
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
            Obx(
              () {
                if (controller.isLoading.value) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ScheduleStatusCardSkeleton(),
                        );
                      });
                }

                List<Registration> registrations =
                    controller.userJoinedModel.toList();
                List<GPXModel> downloadedGpx =
                    controller.downloadedGpx.toList();
                TabStatus status = TabStatus.register;
                switch (1) {
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
                        registrations.where((p0) => p0.status == 2).toList();
                    status = TabStatus.waitCheck;
                    break;
                  default:
                }

                //已付款
                return ListView.builder(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                  itemCount: registrations.length,
                  itemBuilder: (ctx, index) {
                    return Center(
                      child: FutureBuilder<ScheduleModel?>(
                        future: controller
                            .getOneTripData(registrations[index].tripId),
                        builder: (ctx, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ScheduleStatusCard(
                                model: snapshot.data!,
                                registration: registrations[index],
                                tabStatus: status,
                                gpxModel: downloadedGpx.firstWhereOrNull(
                                    (element) =>
                                        element.tripId ==
                                        registrations[index].tripId),
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
          ],
        ),
      ),
    );
  }

  @override
  Widget? desktop() {
    final parameters = Get.parameters;
    int initialIndex = 0;
    if (parameters.containsKey('tab')) {
      initialIndex = int.tryParse(parameters['tab'] ?? "0") ?? 0;
    }
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.selectedIndex.value = initialIndex;
    });
    return DefaultTabController(
      length: 4,
      initialIndex: initialIndex,
      child: Scaffold(
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
                    '登山行程管理',
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
                      color: const Color(0xfffff9ee),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      border:
                          Border.all(color: borderColor, width: borderWidth),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: TabBar(
                      // controller: controller.tabController,
                      onTap: (index) {
                        controller.selectedIndex.value = index;
                      },
                      labelPadding: const EdgeInsets.all(0),
                      labelColor: Colors.white,
                      unselectedLabelColor: MyStyles.primary,
                      indicatorWeight: 0,
                      labelStyle: MyStyles.kTextStyleH4M.copyWith(),
                      unselectedLabelStyle: MyStyles.kTextStyleH4M.copyWith(),
                      indicator: const BoxDecoration(
                        color: MyStyles.primary,
                        // backgroundBlendMode: BlendMode.dstOver,
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
                            child: Center(
                              child: Obx(
                                () => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (controller.selectedIndex.value == 0)
                                      const Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                      ),
                                    const Text('已報名'),
                                  ],
                                ),
                              ),
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
                            child: Center(
                              child: Obx(
                                () => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (controller.selectedIndex.value == 1)
                                      const Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                      ),
                                    Text(
                                      '等待審核中',
                                    ),
                                  ],
                                ),
                              ),
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
                            child: Center(
                              child: Obx(
                                () => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (controller.selectedIndex.value == 2)
                                      const Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                      ),
                                    Text('繼續報名'),
                                  ],
                                ),
                              ),
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
                            child: Center(
                              child: Obx(
                                () => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (controller.selectedIndex.value == 3)
                                      const Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                      ),
                                    Text('已取消'),
                                  ],
                                ),
                              ),
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
                if (controller.isLoading.value) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (ctx, index) {
                        return Center(
                          child: Builder(
                            builder: (ctx) {
                              return ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 1160,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: ScheduleStatusCardSkeleton(),
                                ),
                              );
                            },
                          ),
                        );
                      });
                }

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
                        registrations.where((p0) => p0.status == 2).toList();
                    status = TabStatus.waitCheck;
                    break;
                  case 2:
                    registrations =
                        registrations.where((p0) => p0.status == 0).toList();
                    status = TabStatus.pay;
                    break;
                  case 3:
                    registrations =
                        registrations.where((p0) => p0.status == 3).toList();
                    status = TabStatus.cancel;
                    break;
                  default:
                }
                if (registrations.isEmpty) {
                  return const Center(
                    child: Text('目前無相關紀錄'),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: registrations.length,
                  itemBuilder: (ctx, index) {
                    return Center(
                      child: Builder(
                        builder: (ctx) {
                          if (registrations[index].scheduleModel != null) {
                            return ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 1160,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: ScheduleStatusCard(
                                  model: registrations[index].scheduleModel!,
                                  registration: registrations[index],
                                  tabStatus: status,
                                ),
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
              height: 60,
            ),
            Obx(() {
              if (controller.isLoadingRecommend.value) {
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: kCardWidth),
                    child: Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              margin: const EdgeInsets.all(4.0),
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                  ),
                );
              }

              return controller.scheduleList.isNotEmpty
                  ? Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: kCardWidth),
                        child: Row(
                          children: const [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '推薦相關行程',
                                style: MyStyles.kTextStyleH3Bold,
                              ),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox();
            }),
            const SizedBox(
              height: 60,
            ),
            //推薦行程
            Obx(() {
              if (controller.isLoadingRecommend.value) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [0, 1, 2]
                      .map((element) => Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: kCardWidth),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: SizedBox(
                                  height: kCardHeight,
                                  child: const ScheduleCardSkeleton(),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                );
              }

              return Column(
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
              );
            }),
            const SizedBox(
              height: 110,
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

//以下
enum TabStatus {
  register,
  pay,
  waitCheck,
  cancel,
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
    MyWebButton cancelRegister = MyWebButton(
      label: '取消報名',
      iconData: Icons.close,
      style: MyWebButton.styleMediumFillGrey(),
      onPressed: () {
        controller.cancelRegister(registration);
      },
    );
    switch (status) {
      case TabStatus.register:
        return [
          cancelRegister,
        ];
      case TabStatus.pay:
        return [
          cancelRegister,
          const SizedBox(
            width: 8,
          ),
          MyWebButton(
            label: '繼續付款',
            iconData: Icons.attach_money,
            style: MyWebButton.styleMediumFilledOrange(),
            onPressed: () {
              controller.goToPayPage(registration.tripId!);
            },
          ),
        ];
      case TabStatus.cancel:
        return [
          MyWebButton(
            label: '重新報名',
            iconData: Icons.refresh,
            style: MyWebButton.styleMediumFillGrey(),
            onPressed: () {
              controller.retryRegister(registration);
            },
          ),
        ];
      case TabStatus.waitCheck:
        return [
          cancelRegister,
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
                    MyWebButton(
                      label: '查看行程',
                      iconData: Icons.search,
                      style: MyWebButton.styleMediumOutlinedOrange(),
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

class ScheduleStatusCardSkeleton extends GetResponsiveView {
  ScheduleStatusCardSkeleton({Key? key}) : super(key: key);
  final decoration = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(10.0));

  final bool enabled = true;

  @override
  Widget? phone() {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: enabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(4.0),
                height: 30,
                width: double.infinity,
                decoration: decoration,
              ),
              Container(
                margin: const EdgeInsets.all(4.0),
                height: 30,
                width: 160,
                decoration: decoration,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(children: [
                Container(
                  margin: const EdgeInsets.all(4.0),
                  height: 40,
                  width: 77,
                  decoration: decoration,
                ),
                const Expanded(
                  child: SizedBox(
                    width: 4,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(4.0),
                  height: 40,
                  width: 77,
                  decoration: decoration,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget? desktop() {
    return Card(
      elevation: 8,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: enabled,
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
                        Container(
                          margin: const EdgeInsets.all(4.0),
                          height: 30,
                          width: 252,
                          decoration: decoration,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin: const EdgeInsets.all(4.0),
                          height: 30,
                          width: 172,
                          decoration: decoration,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin: const EdgeInsets.all(4.0),
                          height: 20,
                          width: 160,
                          decoration: decoration,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        height: 40,
                        width: 113,
                        decoration: decoration,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            height: 40,
                            width: 113,
                            decoration: decoration,
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            height: 40,
                            width: 113,
                            decoration: decoration,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
              height: 30,
              width: double.infinity,
              decoration: decoration,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
              height: 30,
              width: double.infinity,
              decoration: decoration,
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
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
      '票種': '一般會員',
      '付款金額': '2400',
      '繳費狀態': '已繳費',
      '繳費方式': '匯款或無存摺存款',
      '是否成行': '成行',
    };
    tableColumn['付款金額'] =
        registration.scheduleModel!.price.toString(); //default
    tableColumn['繳費編號'] = registration.tripId.toString() +
        registration.userId!.codeUnitAt(0).toString() +
        registration.userId!.codeUnitAt(1).toString();

    switch (registration.status) {
      case 0:
        tableColumn['繳費狀態'] = '尚未繳費';
        break;
      case 1:
        tableColumn['繳費狀態'] = '已繳費';
        break;
      case 2:
        tableColumn['繳費狀態'] = '待工作人員確認';
        break;
      case 3:
        tableColumn['繳費狀態'] = '已取消報名';
        break;
    }
    if (registration.paymentInfo!.keys.isNotEmpty) {
      int? method = registration.paymentInfo!['method'];
      switch (method) {
        case 0:
          tableColumn['繳費方式'] = 'ATM繳款';
          break;
        case 1:
          tableColumn['繳費方式'] = '匯款或無存摺存款';
          break;
        case 2:
          tableColumn['繳費方式'] = '信用卡';
          break;
        default:
      }
      bool? isMember = registration.paymentInfo!['isMember'];
      if (isMember == true) {
        tableColumn['票種'] = 'VIP會員';
        tableColumn['付款金額'] =
            registration.scheduleModel!.memberPrice.toString();
      }
    }
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
                    e,
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
