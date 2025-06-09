import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Advertisement extends StatefulWidget {
  final String discription;
  final String cost;
  final String time;
  final String feedback;

  const Advertisement({
    Key? key,
    required this.discription,
    required this.cost,
    required this.time,
    required this.feedback,
  }) : super(key: key);

  @override
  State<Advertisement> createState() => _AdvertisementState();
}

class _AdvertisementState extends State<Advertisement> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          width: 380,
          child: Card(
            color: Color(0xFF35383F),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 8, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 320,
                        child: Text(
                          widget.discription,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SvgPicture.asset(
                              'assets/icons/ruble.svg',
                              width: 20,
                              height: 20,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              widget.cost,
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 16,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w100,
                                letterSpacing: 0,
                                height: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SvgPicture.asset(
                              'assets/icons/time.svg',
                              width: 20,
                              height: 20,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              widget.time,
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 16,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w100,
                                letterSpacing: 0,
                                height: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/icons/favorite_false.svg',
                      width: 20,
                      height: 20,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                Positioned(
                  top: 85,
                  right: 4,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/icons/star.svg',
                          width: 20,
                          height: 20,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      Text(
                        widget.feedback,
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                          fontFamily: "Inter",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/icons/dinar.svg',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 40,
              width: 170,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF191A1F),
                  side: BorderSide(color: Color(0XFF6849FF), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Позвонить',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: "Inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 40,
              width: 170,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6849FF),
                  side: BorderSide(color: Color(0XFF6849FF), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Отликнуться',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: "Inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
