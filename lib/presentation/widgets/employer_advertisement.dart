import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:work_assistent_mob/domain/entities/advertisement.dart';
import 'package:work_assistent_mob/presentation/pages/reduct_advertisement_page.dart';
import 'package:work_assistent_mob/presentation/providers/advertisement_provider.dart';

class EmployerAdvertisement extends StatefulWidget {
  final ResponseEmployerAdvertisement ad;

  const EmployerAdvertisement({Key? key, required this.ad}) : super(key: key);

  @override
  State<EmployerAdvertisement> createState() => _EmployerAdvertisementState();
}

class _EmployerAdvertisementState extends State<EmployerAdvertisement> {
  bool _isUrgent = false;

  @override
  void initState() {
    super.initState();
    _isUrgent = widget.ad.is_urgent ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final advertisementProvider = Provider.of<AdvertisementProvider>(
      context,
      listen: false,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // Рассчитываем ширину для кнопок (минус отступы)
        final buttonWidth = (constraints.maxWidth - 20) / 2;
        // Ширина для текстового контента (минус отступы и иконки)
        final contentWidth = constraints.maxWidth - 60;
        return Column(
          children: [
            SizedBox(
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
                        bottom: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: contentWidth - 40,
                            child: Text(
                              widget.ad.title ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: "Inter",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0,
                                height: 1.0,
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
                                '${widget.ad.time_hours}',
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
                                '${widget.ad.salary ?? 0}',
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
                                          (context) =>
                                              ReductAdvertisementPage(widget.ad.job_id ?? 0),
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
                                                  ReductAdvertisementPage(widget.ad.job_id ?? 0),
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
      },
    );
  }
}
