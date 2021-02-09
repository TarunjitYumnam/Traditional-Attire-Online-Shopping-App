import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final IconData textIcon;

  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPassword;
  final TextEditingController controller;

  CustomInput(
      {Key key,
        this.controller,
        this.hintText,
      this.textIcon,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.isPassword});

  @override
  Widget build(BuildContext context) {
    bool _isPassword = isPassword ?? false;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        controller: controller,
        obscureText: _isPassword,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          prefixIcon: Icon(
              textIcon,
          ),
          border: InputBorder.none,
          hintText: hintText ?? "Text Field......",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 18.0,
          ),
        ),
      ),
    );
  }
}
