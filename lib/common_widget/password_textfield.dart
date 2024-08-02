
import 'package:flutter/material.dart';
import 'package:gym/common_widget/round_textfield.dart';


class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;

  const PasswordTextField({Key? key, this.controller}) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RoundTextField(
      hintText: "Password",
      icon: Icons.password_outlined,
      obscureText: _obscureText,
      controller: widget.controller,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: _togglePasswordVisibility,
      ),
    );
  }
}
