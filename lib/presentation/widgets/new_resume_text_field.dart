import 'package:flutter/material.dart';

class NewResumeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isBorder;
  final double minHeight;
  final double maxHeight;

  const NewResumeTextField({
    super.key,
    required this.controller,
    this.hintText = "",
    this.isBorder = false,
    this.minHeight = 60.0,
    this.maxHeight = 240.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: minHeight,
        maxHeight: maxHeight,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF35383F),
        borderRadius: BorderRadius.circular(15),
        border: isBorder
            ? Border.all(
                color: const Color(0xFFFFFFFF),
                width: 1.0,
              )
            : null,
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          color: Color(0xFFFFFFFF),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
            color: Color(0xFF71747B),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 16.0,
          ),
        ),
      ),
    );
  }
}