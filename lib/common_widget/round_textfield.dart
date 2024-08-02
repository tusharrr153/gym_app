import 'package:flutter/material.dart';

class RoundTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final VoidCallback? onTap;

  const RoundTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
        ),
        child: AbsorbPointer(
          absorbing: onTap != null, // Prevents manual text entry when onTap is provided
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              hintText: hintText,
              prefixIcon: Icon(icon, color: Colors.grey),
              suffixIcon: suffixIcon,
              hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              fillColor: Colors.grey.shade200,
              filled: true,
            ),
          ),
        ),
      ),
    );
  }
}
