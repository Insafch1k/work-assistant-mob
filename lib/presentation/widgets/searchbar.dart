import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MySearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const MySearchBar({
    Key? key,
    this.hintText = 'Найти работу',
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 320,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w300,
          fontSize: 16.0,
          height: 1.0,
          letterSpacing: 0.0,
          color: Color(0xFFFFFFFF),
        ),
        decoration: InputDecoration(
          hintText: hintText,
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
              width: 18,
              height: 18,
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
              EdgeInsets.only(top: 11, bottom: 10.0, left: 42.0),
        ),
      ),
    );
  }
}