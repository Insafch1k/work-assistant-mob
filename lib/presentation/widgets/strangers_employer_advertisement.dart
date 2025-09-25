import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:work_assistent_mob/domain/entities/advertisement.dart';
import 'package:work_assistent_mob/presentation/providers/advertisement_provider.dart';

class StrangersEmployerAdvertisement extends StatefulWidget {
  final ResponseAdvertisement ad;

  const StrangersEmployerAdvertisement({Key? key, required this.ad})
    : super(key: key);

  @override
  State<StrangersEmployerAdvertisement> createState() => _AdvertisementState();
}

class _AdvertisementState extends State<StrangersEmployerAdvertisement> {
  @override
  Widget build(BuildContext context) {
    final advertisementProvider = Provider.of<AdvertisementProvider>(
      context,
      listen: false,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth = constraints.maxWidth - 60;

        return Column(
          children: [
            SizedBox(
              child: Card(
                color: const Color(0xFF35383F),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 8,
                        right: 40,
                        bottom: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: contentWidth - 40,
                            child: Text(
                              widget.ad.title ?? " ",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: "Inter",
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0,
                                height: 1.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/ruble.svg',
                                width: 20,
                                height: 20,
                                color: const Color(0xFFFFFFFF),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${widget.ad.salary}",
                                style: const TextStyle(
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
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/time.svg',
                                width: 20,
                                height: 20,
                                color: const Color(0xFFFFFFFF),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${widget.ad.time_hours}",
                                style: const TextStyle(
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
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/location.svg',
                                width: 20,
                                height: 20,
                                color: const Color(0xFFFFFFFF),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: contentWidth - 110,
                                child: Text(
                                  widget.ad.address ?? " ",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
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
                      bottom: 10,
                      right: 10,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/star.svg',
                            width: 20,
                            height: 20,
                            color: const Color(0xFFFFFFFF),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.ad.rating ?? " ",
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                              fontFamily: "Inter",
                            ),
                          ),
                          const SizedBox(width: 6),
                          Image.asset(
                            "assets/images/ali.png",
                            color: Color(0xFFFFFFFF),
                            height: 40,
                            width: 40,
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
      },
    );
  }
}
