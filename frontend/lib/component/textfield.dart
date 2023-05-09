import 'package:flutter/material.dart';
import 'package:tripflutter/consts.dart';

class LoginTextField extends StatefulWidget {
  const LoginTextField({
    Key? key,
    this.controller,
    this.hint,
    this.validator,
    this.error,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hint;
  final String? error;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Colors.green,
              width: 20,
            )),
        hintText: widget.hint,
        errorText: widget.error,
        helperText: '',
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: MyStyles.tripTertiary,
                ),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              )
            : null,
      ),
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscureText ? !passwordVisible : false,
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
      style: MyStyles.kTextStyleSubtitle1,
      decoration: InputDecoration(
        isCollapsed: true,
        contentPadding: const EdgeInsets.all(12.0),
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
