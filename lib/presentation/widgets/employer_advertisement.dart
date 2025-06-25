import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:work_assistent/presentation/pages/reduct_advertisement_page.dart';

class EmployerAdvertisement extends StatefulWidget {
  final String discription;
  final String cost;
  final String time;
  final String feedback;
  final String location;
  final bool hasNumber;

  const EmployerAdvertisement({
    Key? key,
    required this.discription,
    required this.cost,
    required this.time,
    required this.feedback,
    required this.location,
    required this.hasNumber,
  }) : super(key: key);

  @override
  State<EmployerAdvertisement> createState() => _EmployerAdvertisementState();
}

class _EmployerAdvertisementState extends State<EmployerAdvertisement> {
  bool _isUrgent = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 145,
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
                          SvgPicture.asset(
                            'assets/icons/time.svg',
                            width: 20,
                            height: 20,
                            color: Color(0xFFFFFFFF),
                          ),
                          SizedBox(width: 10),
                          Text(
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
                          SizedBox(width: 10),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/location.svg',
                                width: 20,
                                height: 20,
                                color: Color(0xFFFFFFFF),
                              ),
                              SizedBox(width: 10),
                              Text(
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
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/ruble.svg',
                            width: 20,
                            height: 20,
                            color: Color(0xFFFFFFFF),
                          ),
                          SizedBox(width: 10),
                          Text(
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
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child:
                      !_isUrgent
                          ? IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => ReductAdvertisementPage(),
                                ),
                              );
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/reduct.svg',
                              width: 20,
                              height: 20,
                              color: const Color(0xFFFFFFFF),
                            ),
                          )
                          : Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              ReductAdvertisementPage(),
                                    ),
                                  );
                                },
                                icon: SvgPicture.asset(
                                  'assets/icons/reduct.svg',
                                  width: 20,
                                  height: 20,
                                  color: const Color(0xFFFFFFFF),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'assets/icons/lightning.svg',
                                  width: 20,
                                  height: 20,
                                  color: const Color(0xFFFFF024),
                                ),
                              ),
                            ],
                          ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
