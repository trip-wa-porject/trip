import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/consts.dart';

import 'consts.dart';
import 'signup_controller.dart';
import 'utils.dart';

class SignUpContentTwo extends GetView<SignUpController> {
  SignUpContentTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          InputCard(
            title: '帳號密碼',
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _MyInputTitle(title: 'E-mail 帳號*'),
                  Expanded(
                    child: _MyInputField(
                      hintText: 'abe233@gmail.com',
                      onSave: (value) {
                        controller.formData.email = value;
                      },
                      validator: (value) {
                        return validateInput(value) ?? validateEmail(value);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _MyInputTitle(title: '密碼*'),
                  Expanded(
                    child: _MyInputField(
                      hintText: 'abd1234erewrwrwe',
                      helperText: '至少8個字，同時需要包含大小寫和數字',
                      onSave: (value) {
                        controller.formData.password = value;
                      },
                      validator: (value) {
                        return validateInput(value) ?? validatePassword(value);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          InputCard(
            title: '個人資料',
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _MyInputTitle(title: '中文姓名*'),
                  Expanded(
                    child: _MyInputField(
                      hintText: '陳筱珊',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _MyInputTitle(title: '出生年月日*'),
                  Expanded(
                    child: _MyInputField(
                      hintText: '1980/07/13',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _MyInputTitle(title: '身分證字號*'),
                  Expanded(
                    child: _MyInputField(
                      hintText: 'A139403924',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _MyInputTitle(title: '電話*'),
                  Expanded(
                    child: _MyInputField(
                      hintText: ' 0910901884',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _MyInputTitle(title: '地址*'),
                  Expanded(
                    child: _MyInputField(
                      hintText: ' 完整地址',
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          InputCard(
            title: '緊急聯絡資訊',
            children: [
              Row(
                children: [
                  _MyInputTitle(title: '緊急聯絡人*'),
                  Expanded(
                    child: _MyInputField(
                      hintText: '陳筱珊',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _MyInputTitle(title: '聯絡人關係*'),
                  Expanded(
                    child: _MyInputField(
                      hintText: ' 關係',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _MyInputTitle(title: '聯絡人電話*'),
                  Expanded(
                    child: _MyInputField(
                      hintText: '0910901884',
                    ),
                  ),
                ],
              ),
              Obx(
                () => Column(
                  children: (controller.step1CheckedStates
                      .map(
                        (element) => Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Row(
                            children: [
                              Checkbox(
                                onChanged: (value) {
                                  controller.step1CheckCallback(element.index);
                                },
                                value: element.checked,
                              ),
                              Expanded(
                                child: Text(
                                  step2MapIndexToStr[element.index]!,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MyInputTitle extends StatelessWidget {
  const _MyInputTitle({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 37),
      width: 98,
      padding: const EdgeInsets.only(bottom: 25),
      child: EasyRichText(
        '$title',
        textAlign: TextAlign.end,
        defaultStyle: MyStyles.kTextStyleSubtitle1,
        maxLines: 1,
        patternList: [
          EasyRichTextPattern(
            targetString: '*',
            style: MyStyles.kTextStyleSubtitle1.copyWith(
              color: MyStyles.redC80000,
            ),
            hasSpecialCharacters: true,
          ),
        ],
      ),
    );
  }
}

class _MyInputField extends StatelessWidget {
  const _MyInputField({
    Key? key,
    this.textEditingController,
    this.helperText,
    this.hintText,
    this.validator,
    this.onSave,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final String? hintText;
  final String? helperText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSave;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            helperText: helperText ?? '',
            hintText: hintText),
        onSaved: onSave,
        validator: validator,
      ),
    );
  }
}

class InputCard extends StatelessWidget {
  const InputCard({Key? key, required this.title, required this.children})
      : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: MyStyles.green3,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 65,
            decoration: const BoxDecoration(
              color: MyStyles.green1,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  title,
                  style: MyStyles.kTextStyleH3Bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          ...(children.map((e) {
            return FractionallySizedBox(
              widthFactor: .7,
              child: e,
            );
          }).toList()),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
