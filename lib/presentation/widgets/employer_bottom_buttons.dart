import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmployerBottomButtons extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const EmployerBottomButtons({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFFFFFFF), width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildIconButton(0, 'assets/icons/bag.svg')),
          Expanded(child: _buildIconButton(1, 'assets/icons/megaphone.svg')),
          Expanded(child: _buildIconButton(2, 'assets/icons/user.svg')),
        ],
      ),
    );
  }

  Widget _buildIconButton(int index, String iconPath) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Container(
        width: 90,
        height: 50,
        decoration: BoxDecoration(
          border:
              isSelected
                  ? Border.all(color: const Color(0xFFFFFFFF), width: 1)
                  : null,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: 40,
            height: 40,
            color: const Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
