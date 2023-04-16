import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/component/buttons.dart';
import 'package:tripflutter/component/footer.dart';
import 'package:tripflutter/component/my_app_bar.dart';
import 'package:tripflutter/component/widgets.dart';
import 'package:tripflutter/consts.dart';

import 'consts.dart' as signupConsts;
import 'signup_content_one.dart';
import 'signup_content_three.dart';
import 'signup_content_two.dart';
import 'signup_controller.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return Scaffold(
      backgroundColor: Color(0xff686868),
      appBar: MyAppBar(),
      body: Material(
        child: Center(
          child: ListView(
            children: [
              BgImage(
                child: Center(
                  child: SizedBox(
                    width: 751,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '註冊成為會員',
                          style: MyStyles.kTextStyleH2Bold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 48.0,
                        ),
                        Text(
                          '歡迎加入新北山岳協會！ 我們致力於提供最好的登山體驗和資源，讓您在登山旅程中感受到無限的樂趣和挑戰。我們期待著您的加入，一同探索美麗的大自然，締造難忘的回憶。',
                          style: MyStyles.kTextStyleH3.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: LayoutBuilder(builder: (context, constrains) {
                  return Container(
                    constraints: BoxConstraints(
                        maxHeight: double.infinity, maxWidth: 1160),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 94,
                        ),
                        Obx(
                          () => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 307,
                                child: Column(
                                  children: [
                                    StepContainer(
                                      stepIndex: 0,
                                      title: '申請成為會員',
                                      isCurrentStep:
                                          controller.steps.value >= 0,
                                    ),
                                    StepContainer(
                                      stepIndex: 1,
                                      title: '填寫會員資料',
                                      isCurrentStep:
                                          controller.steps.value >= 1,
                                    ),
                                    StepContainer(
                                      stepIndex: 2,
                                      title: '驗證 E-mail',
                                      isCurrentStep:
                                          controller.steps.value >= 2,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 86,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Column(
                                    children: [
                                      [
                                        const SignUpContentOne(),
                                        SignUpContentTwo(),
                                        const SignUpContentThree(),
                                      ][controller.steps.value],
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Obx(
                                              () => Visibility(
                                                visible:
                                                    controller.steps.value == 1,
                                                child: SizedBox(
                                                  width: 208,
                                                  height: 65,
                                                  child: MyOutlinedButton(
                                                    label: '返回上一步',
                                                    style: MyOutlinedButton
                                                        .style1(),
                                                    onPressed: () {
                                                      controller.preStep();
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 32,
                                            ),
                                            Obx(
                                              () => Visibility(
                                                visible:
                                                    controller.steps.value != 2,
                                                child: SizedBox(
                                                  width: 208,
                                                  height: 65,
                                                  child: Obx(
                                                    () => MyFilledButton(
                                                      label: '下一步',
                                                      style: MyFilledButton
                                                          .style1(),
                                                      onPressed: controller
                                                              .nextStepsBtnStatus
                                                              .value
                                                          ? () {
                                                              controller
                                                                  .nextStep();
                                                            }
                                                          : null,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 120.0),
                child: Footer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///會員條款，步驟樣式
class StepContainer extends StatelessWidget {
  const StepContainer(
      {Key? key,
      required this.title,
      required this.stepIndex,
      this.isCurrentStep = false})
      : super(key: key);

  final String title;
  final int stepIndex;
  final bool isCurrentStep;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 307,
      height: 110,
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isCurrentStep ? MyStyles.tripTertiary : MyStyles.green3,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          '步驟${stepIndex + 1}\n$title',
          style: MyStyles.kTextStyleH3Bold.copyWith(
            color: Colors.white,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}

class DropdownTerm extends StatefulWidget {
  const DropdownTerm({
    Key? key,
    required this.checkState,
  }) : super(key: key);

  final TermsCheckState checkState;

  @override
  State<DropdownTerm> createState() => _DropdownTermState();
}

class _DropdownTermState extends State<DropdownTerm> {
  final ScrollController scrollController = ScrollController();
  bool checkable = false;
  scrollListener() {
    if (scrollController.position.atEdge) {
      bool isTop = scrollController.position.pixels == 0;
      if (isTop) {
        print('At the top');
      } else {
        print('At the bottom');
        if (checkable == false) {
          setState(() {
            checkable = true;
          });
        }
      }
    }
  }

  @override
  void initState() {
    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final checkState = widget.checkState;
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Get.find<SignUpController>()
                    .step1SelectCallback(checkState.index);
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: checkState.checked
                        ? Icon(
                            Icons.check_circle,
                            color: MyStyles.tripTertiary,
                          )
                        : Icon(Icons.check_circle_outline),
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        signupConsts.mapIndexToData[checkState.index]!['title']
                            as String,
                        style: checkState.isShowed
                            ? MyStyles.kTextStyleH2
                            : MyStyles.kTextStyleH2Normal,
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_up)
                ],
              ),
            ),
            if (checkState.isShowed)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  height: 172,
                  child: ListView(
                    controller: scrollController,
                    children: [
                      EasyRichText(
                        signupConsts
                                .mapIndexToData[checkState.index]!['content']
                            as String,
                        defaultStyle: MyStyles.kTextStyleBody1,
                        patternList: (signupConsts.mapIndexToData[
                                checkState.index]!['subtitles'] as List)
                            .map(
                              (e) => EasyRichTextPattern(
                                targetString: e,
                                style: MyStyles.kTextStyleH3,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            if (checkState.isShowed)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 77,
                    child: MyFilledButton(
                      style: MyFilledButton.style1(),
                      label: '同意',
                      onPressed: checkable
                          ? () {
                              Get.find<SignUpController>()
                                  .step0CheckCallback(checkState.index);
                            }
                          : null,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}