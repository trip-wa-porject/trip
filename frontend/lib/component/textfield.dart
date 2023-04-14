import 'package:flutter/material.dart';
import 'package:tripflutter/consts.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    Key? key,
    this.controller,
    this.hint,
    this.validator,
    this.error,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final String? error;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.green,
              width: 20,
            )),
        hintText: hint,
        errorText: error,
        helperText: '',
      ),
      controller: controller,
      validator: validator,
    );
  }
}

class PayTextField extends StatelessWidget {
  const PayTextField({
    Key? key,
    this.controller,
    this.validator,
    this.error,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? error;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: MyStyles.primary,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: MyStyles.primary,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        errorText: error,
      ),
      controller: controller,
      validator: validator,
    );
  }
}
