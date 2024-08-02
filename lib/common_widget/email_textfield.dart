
import 'package:flutter/material.dart';
import 'package:gym/common_widget/round_textfield.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController? controller;

  const EmailTextField({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundTextField(
      hintText: "Email",
      icon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      controller: controller,
    );
  }
}
