import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:work_assistent_mob/domain/entities/advertisement.dart';
import 'package:work_assistent_mob/presentation/pages/detailed_advertisement_page.dart';
import 'package:work_assistent_mob/presentation/providers/advertisement_provider.dart';
import 'package:work_assistent_mob/presentation/providers/view_provider.dart';

class FilterAdvertisement extends StatefulWidget {
  final ResponseFilteredAdvertisement ad;

  const FilterAdvertisement({Key? key, required this.ad}) : super(key: key);

  @override
  State<FilterAdvertisement> createState() => _FilterAdvertisementState();
}

class _FilterAdvertisementState extends State<FilterAdvertisement> {
  bool _isLiked = false;
  bool _isUrgent = false;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.ad.is_favorite ?? false;
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
                              maxLines: 3,
                              style: const TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: "Inter",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
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
                      top: 4,
                      right: 4,
                      child: IconButton(
                        onPressed: () async {
                          try {
                            if (_isLiked) {
                              await advertisementProvider.deleteFromFavorite(
                                widget.ad.job_id!,
                              );
                            } else {
                              await advertisementProvider.addToFavorite(
                                widget.ad.job_id!,
                              );
                            }
                            setState(() {
                              _isLiked = !_isLiked;
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Ошибка: ${e.toString()}'),
                              ),
                            );
                            setState(() {
                              _isLiked = widget.ad.is_favorite ?? false;
                            });
                          }
                        },
                        icon: SvgPicture.asset(
                          _isLiked
                              ? 'assets/icons/favorite_true.svg'
                              : 'assets/icons/favorite_false.svg',
                          width: 20,
                          height: 20,
                        ),
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40,
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF191A1F),
                      side: const BorderSide(
                        color: Color(0XFF6849FF),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
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
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () async {
                      final viewProvider = Provider.of<ViewProvider>(
                        context,
                        listen: false,
                      );
                      try {
                        await viewProvider.createNewView(widget.ad.job_id!);
                      } catch (e) {
                        // Ошибка не критична
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => DetailedAdvertisementPage(
                                job_id: widget.ad.job_id!,
                              ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6849FF),
                      side: const BorderSide(
                        color: Color(0XFF6849FF),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Подробнее',
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
      },
    );
  }
}
