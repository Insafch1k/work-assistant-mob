import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Skills extends StatefulWidget {
  final String skill;
  final VoidCallback? onPressed;
  const Skills({super.key, required this.skill, this.onPressed});

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.6,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF191A1F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              widget.skill,
              style: TextStyle(
                fontFamily: "Inter",
                color: Color(0xFFFFFFFF),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/arrow_up.svg',
                height: 20,
                width: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
