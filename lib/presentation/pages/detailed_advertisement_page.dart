import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_assistent_mob/presentation/pages/favorite_page.dart';
import 'package:work_assistent_mob/presentation/pages/profile_page.dart';
import 'package:work_assistent_mob/presentation/pages/view_history_page.dart';
import 'package:work_assistent_mob/presentation/pages/work_page.dart';
import 'package:work_assistent_mob/presentation/providers/advertisement_provider.dart';
import 'package:work_assistent_mob/presentation/widgets/bottom_buttons.dart';

class DetailedAdvertisementPage extends StatefulWidget {
  final int job_id;

  const DetailedAdvertisementPage({required this.job_id, Key? key})
    : super(key: key);

  @override
  State<DetailedAdvertisementPage> createState() =>
      _DetailedAdvertisementPageState();
}

class _DetailedAdvertisementPageState extends State<DetailedAdvertisementPage> {
  bool _isLiked = false;
  @override
  void initState() {
    super.initState();
    _loadDetails();
    final provider = context.read<AdvertisementProvider>();
    _isLiked = provider.currentDetailedAd?.is_favorite ?? false;
  }

  void _loadDetails() async {
    final provider = context.read<AdvertisementProvider>();
    await provider.fetchDetailedAdvertisement(widget.job_id);
    // Обновляем состояние после загрузки
    if (mounted) {
      setState(() {
        _isLiked = provider.currentDetailedAd?.is_favorite ?? false;
      });
    }
  }

  Future<void> _callPhone(String number) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Не удалось совершить звонок';
    }
  }

  void _showCallDialog(BuildContext context, String phoneNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF35383F),
          title: const Text(
            'Позвонить?',
            style: TextStyle(color: Colors.white, fontFamily: 'Inter'),
          ),
          content: Text(
            'Вы хотите позвонить по номеру $phoneNumber?',
            style: const TextStyle(
              color: Color(0xFF71747B),
              fontFamily: 'Inter',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Отмена',
                style: TextStyle(color: Color(0xFF71747B), fontFamily: 'Inter'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _callPhone(phoneNumber);
              },
              child: const Text(
                'Позвонить',
                style: TextStyle(color: Color(0xFF2DD498), fontFamily: 'Inter'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _noPhonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF35383F),
          content: Text(
            'У работодателя отсутствует номер телефона',
            style: const TextStyle(
              color: Color(0xFF71747B),
              fontFamily: 'Inter',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Ок',
                style: TextStyle(color: Color(0xFF71747B), fontFamily: 'Inter'),
              ),
            ),
            
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdvertisementProvider>();
    final ad = provider.currentDetailedAd;
    return Scaffold(
      backgroundColor: const Color(0xFF191A1F),
      appBar: AppBar(
        title: const Text(
          "Подробнее",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFFFFFFFF),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                final provider = context.read<AdvertisementProvider>();
                if (_isLiked) {
                  await provider.deleteFromFavorite(widget.job_id);
                } else {
                  await provider.addToFavorite(widget.job_id);
                }
                setState(() {
                  _isLiked = !_isLiked;
                });
              } catch (e) {
                setState(() {
                  _isLiked = !_isLiked;
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
        ],
        backgroundColor: const Color(0xFF191A1F),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(color: const Color(0xFF191A1F)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ad?.title ?? " ",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Категория подработки",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF71747B),
              ),
            ),
            SizedBox(height: 10),
            Text(
              ad?.wanted_job ?? " ",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Адрес подработки",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF71747B),
              ),
            ),
            SizedBox(height: 10),
            Text(
              ad?.address ?? " ",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Время подработки",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF71747B),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "${ad?.hours ?? " "}",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Дата подработки",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF71747B),
              ),
            ),
            SizedBox(height: 10),
            Text(
              ad?.time_start ?? " ",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Зарплата",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF71747B),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "${ad?.salary ?? " "}",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/star.svg',
                            width: 20,
                            height: 20,
                            color: const Color(0xFFFFFFFF),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "0",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        "0 отзывов",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF2DD498),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Image.asset(
                    "assets/images/ali.png",
                    color: Color(0xFFFFFFFF),
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    ad?.user_name ?? " ",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF191A1F),
                  side: const BorderSide(color: Color(0XFF6849FF), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  if(ad!.phone != ''){
                    _callPhone(ad!.phone ?? '');
                  }
                  else{
                    _noPhonDialog(context);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Позвонить',
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Опыт работы",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF71747B),
              ),
            ),
            SizedBox(height: 10),
            Text(
              ad?.xp ?? " ",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Возраст",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF71747B),
              ),
            ),
            SizedBox(height: 10),
            Text(
              ad?.age ?? " ",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Описание",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF71747B),
              ),
            ),
            SizedBox(height: 10),
            Text(
              ad?.description ?? " ",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: BottomButtons(
          currentIndex: 4,
          onTabSelected: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WorkPage()),
              );
            }
            if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FavoritePage()),
              );
            }
            if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ViewHistoryPage(),
                ),
              );
            }
            if (index == 3) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            }
          },
        ),
      ),
    );
  }
}
