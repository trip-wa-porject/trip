import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({Key? key, this.controller}) : super(key: key);

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Colors.green,
              width: 20,
            )),
      ),
      controller: controller,
    );
  }
}
