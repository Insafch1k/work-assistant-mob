import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StrangerMessage extends StatefulWidget {
  const StrangerMessage({super.key});

  @override
  State<StrangerMessage> createState() => _StrangerMessageState();
}

class _StrangerMessageState extends State<StrangerMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.6,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF434B5D),
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
                    'GKFKDGFPODGPSFOKPDSOKFGKFKDGFPODGPSFOKPDSOKF',
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
            left: -4,
            bottom: 0,
            child: SvgPicture.asset(
              'assets/icons/stranger_tail_message.svg',
              width: 20,
              height: 20,
              color: const Color(0xFF434B5D),
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
