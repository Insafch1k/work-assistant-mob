import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? hintText;

  const InputField({
    Key? key,
    this.onChanged,
    this.controller,
    this.hintText,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w300,
          fontSize: 16.0,
          height: 1.0,
          letterSpacing: 0.0,
          color: Color(0xFFFFFFFF),
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
            height: 1.0,
            color: Color(0xFF71747B),
            letterSpacing: 0.0,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 20,
              height: 20,
              color: Color(0xFFFFFFFF),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Color(0xFF35383F),
          contentPadding:
              EdgeInsets.only(top: 11, bottom: 10.0, left: 42.0, right: 10.0),
        ),
      ),
    );
  }
}