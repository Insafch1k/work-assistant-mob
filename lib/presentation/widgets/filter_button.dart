import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FilterButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF35383F),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(
                  'assets/icons/filters.svg',
                  width: 15.42,
                  height: 14.65,
                  color: Color(0xFFFFFFFF),
                ),
          ),
        ),
      ),
    );
  }
}