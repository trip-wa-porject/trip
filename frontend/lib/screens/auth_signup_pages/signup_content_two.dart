import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripflutter/consts.dart';

import '../schedule_selector/schedule_options/check_box_group.dart';
import '../schedule_selector/schedule_options/date_selector.dart';
import 'consts.dart';
import 'utils.dart';
import 'package:tripflutter/screens/auth_signup_pages/signup_controller.dart';

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
                      initialValue: '',
                      hintText: 'abc@mail.com',
                      onSave: (value) {
                        controller.formData.email = value;
                      },
                      validator: (value) {
                        return validateEmail(value);
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
                      initialValue: '',
                      hintText: '密碼',
                      helperText: '至少8個字，同時需要包含大小寫和數字',
                      onSave: (value) {
                        controller.formData.password = value;
                      },
                      obscureText: true,
                      validator: (value) {
                        return validatePassword(value);
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
                      initialValue: '',
                      hintText: '姓名',
                      onSave: (value) {
                        controller.formData.name = value;
                      },
                      validator: (value) {
                        return validateUserName(value);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _MyInputTitle(title: '出生年月日*'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Obx(
                      () => ScheduleOptionDateSelector(
                        title: "出生日期",
                        width: 320,
                        selectedDate: controller.birthdayDateTime.value,
                        lastDate: controller.birthdayDateTime.value,
                        isClockwise: false,
                        borderColor: MyStyles.greyScale9E9E9E,
                        onDateChangeCallback: (DateTime dateTime) {
                          controller.selectBirthdayDate(dateTime);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _MyInputTitle(title: '身分證字號*'),
                  Expanded(
                    child: _MyInputField(
                      initialValue: '',
                      hintText: '身分證字號',
                      onSave: (value) {
                        controller.formData.idno = value;
                      },
                      onChanged: (value) {
                        controller.saveIdNoSexual(value!);
                      },
                      validator: (value) {
                        return validateTaiwanId(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 25.0),
                    child: Obx(
                        () => _customTextField(controller.idNoSexual.value)),
                  ),
                ],
              ),
              Row(
                children: [
                  _MyInputTitle(title: '電話*'),
                  Expanded(
                    child: _MyInputField(
                      initialValue: '',
                      hintText: ' 0912345678',
                      onSave: (value) {
                        controller.formData.mobile = value;
                      },
                      validator: (value) {
                        return validatePhoneNumber(value);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _MyInputTitle(title: '地址*'),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Obx(() =>
                                _customTextField(controller.zipOptions.value)),
                            const SizedBox(
                              width: 16,
                            ),
                            Obx(
                              () => ScheduleOptionCheckSelector<String>(
                                title: "縣市",
                                width: 99,
                                allItems: controller.cityOptions
                                    .map((entry) => entry.name)
                                    .toList(),
                                selectedItems:
                                    controller.citySelectOptions.toList(),
                                borderColor: MyStyles.greyScale9E9E9E,
                                mode: CheckBoxOptionMode.single,
                                onChangeCallback: (value) {
                                  controller.selectCityOption(value);
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Obx(
                              () => ScheduleOptionCheckSelector<String>(
                                title: "區",
                                width: 99,
                                allItems: controller.districtOptions.value
                                    .map((entry) => entry.name)
                                    .toList(),
                                selectedItems:
                                    controller.districtSelectOptions.toList(),
                                borderColor: MyStyles.greyScale9E9E9E,
                                mode: CheckBoxOptionMode.single,
                                onChangeCallback: (value) {
                                  controller.selectDistrictOption(value);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        _MyInputField(
                          initialValue: '',
                          hintText: ' 地址',
                          onSave: (value) {
                            controller.formData.address =
                                controller.zipOptions.value +
                                    controller.citySelectOptions.value[0] +
                                    controller.districtSelectOptions.value[0] +
                                    value!;
                          },
                        ),
                      ],
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
                      initialValue: '',
                      hintText: '緊急聯絡人姓名',
                      onSave: (value) {
                        controller.formData.emergentContactor = value;
                      },
                      validator: (value) {
                        return validateUserName(value);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _MyInputTitle(title: '聯絡人關係*'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Obx(
                      () => ScheduleOptionCheckSelector<RelationOption>(
                        title: "關係",
                        width: 113,
                        allItems: RelationOption.values,
                        selectedItems: controller.relationOptions.toList(),
                        borderColor: MyStyles.greyScale9E9E9E,
                        mode: CheckBoxOptionMode.single,
                        onChangeCallback: (value) {
                          controller.selectRelationOption(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _MyInputTitle(title: '聯絡人電話*'),
                  Expanded(
                    child: _MyInputField(
                      initialValue: '',
                      hintText: '0912345678',
                      onSave: (value) {
                        controller.formData.emergentContactTel = value;
                      },
                      validator: (value) {
                        return validatePhoneNumber(value);
                      },
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
        title,
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
  _MyInputField({
    Key? key,
    this.textEditingController,
    this.initialValue,
    this.helperText,
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.onSave,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final String? initialValue;
  final String? hintText;
  final String? helperText;
  bool obscureText;
  bool isVisible = false;
  final String? Function(String?)? validator;
  final void Function(String?)? onSave;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    isVisible = obscureText;
    return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            height: 60,
            child: TextFormField(
              initialValue: initialValue,
              controller: textEditingController,
              onChanged: onChanged,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  fillColor: Colors.deepPurpleAccent,
                  suffixIcon: isVisible ? IconButton(
                      onPressed: () => setState(() {
                        obscureText = !obscureText;
                      }),
                      icon: Icon(obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined)) : null,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: MyStyles.greyScale9E9E9E, width: 1.0),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: MyStyles.greyScale757575, width: 1.0),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  helperText: helperText ?? '',
                  hintText: hintText),
              onSaved: onSave,
              obscureText: obscureText,
              obscuringCharacter: '*',
              cursorColor: MyStyles.greyScale9E9E9E,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
            ),
          );
        });
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
          const SizedBox(
            height: 25,
          ),
          ...(children.map((e) {
            return FractionallySizedBox(
              widthFactor: .7,
              child: e,
            );
          }).toList()),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}

Widget _customTextField(String label) {
  return SizedBox(
    child: Container(
      // margin: const EdgeInsets.only(right: 0, left: 0, top: 0, bottom: 0),
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
      decoration: BoxDecoration(
          border: Border.all(color: MyStyles.greyScaleF4F4F4),
          borderRadius: BorderRadius.circular(5.0),
          color: MyStyles.greyScaleF4F4F4),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          label,
          style: MyStyles.kTextStyleBody1.copyWith(color: Colors.black),
        ),
      ),
    ),
  );
}
