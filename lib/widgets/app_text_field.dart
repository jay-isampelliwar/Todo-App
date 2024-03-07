import 'package:flutter/material.dart';

import '../res/colors.dart';

class AppTextField extends StatefulWidget {
  AppTextField({
    super.key,
    this.showLabel = false,
    required this.hintText,
    required this.onChanged,
    required this.controller,
  });

  bool showLabel;
  Function(String)? onChanged;
  String hintText;
  TextEditingController controller;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        hintText: widget.hintText,
        label: widget.showLabel ? Text(widget.hintText) : null,
      ),
      cursorColor: kPrimaryColor,
    );
  }
}
