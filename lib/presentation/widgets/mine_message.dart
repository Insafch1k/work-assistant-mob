import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MineMessage extends StatefulWidget {
  const MineMessage({super.key});

  @override
  State<MineMessage> createState() => _MineMessageState();
}

class _MineMessageState extends State<MineMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.6,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF6346F1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 37),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 20),
                  child: Text(
                    'GKFKDGFPODGPSFOKPDSOKFGKFKDGFPODGPSFOKPDSOKFGKFKDGFPODGPSFOKPDSOKFGKFKDGFPODGPSFOKPDSOKF',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: -4,
            bottom: 0,
            child: SvgPicture.asset(
              'assets/icons/mine_tail_message.svg',
              width: 20,
              height: 20,
              color: const Color(0xFF6346F1),
            ),
          ),

          Positioned(
            right: 7,
            bottom: 2,
            child: Text(
              '11:11',
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 12,
                fontWeight: FontWeight.w100,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
