import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StrangersEmployerAdvertisement extends StatefulWidget {
  final String discription;
  final String cost;
  final String time;
  final String feedback;
  final String location;
  final bool hasNumber;

  const StrangersEmployerAdvertisement({
    Key? key,
    required this.discription,
    required this.cost,
    required this.time,
    required this.feedback,
    required this.location,
    required this.hasNumber,
  }) : super(key: key);

  @override
  State<StrangersEmployerAdvertisement> createState() => _AdvertisementState();
}

class _AdvertisementState extends State<StrangersEmployerAdvertisement> {
  bool _isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 165,
          width: double.infinity,
          child: Card(
            color: Color(0xFF35383F),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 10,
                    right: 10,
                    bottom: 11,
                  ),
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
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SvgPicture.asset(
                              'assets/icons/location.svg',
                              width: 20,
                              height: 20,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              widget.location,
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
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _isLiked = !_isLiked;
                      });
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/lightning.svg',
                      width: 20,
                      height: 20,
                      color: Color(0xFFFFF024),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
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
                          icon: Image.asset("assets/images/ronaldo.png", height: 40, width: 40),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
