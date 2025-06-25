import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:work_assistent/presentation/pages/employer_work_page.dart';
import 'package:work_assistent/presentation/pages/new_advertisement_page.dart';
import 'package:work_assistent/presentation/widgets/employer_advertisement.dart';
import 'package:work_assistent/presentation/widgets/employer_bottom_buttons.dart';

class MyAdvertisementPage extends StatelessWidget {
  const MyAdvertisementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191A1F),
      appBar: AppBar(
        title: const Text(
          "Мои объявления",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Color(0xFFFFFFFF),
          ),
        ),
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ElevatedButton(
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
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewAdvertisementPage(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/plus.svg',
                        width: 20,
                        height: 20,
                        color: const Color(0xFFFFFFFF),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Новое объявление',
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
              EmployerAdvertisement(
                discription:
                    "Срочно нужно сделать карточки маркетплейсов для вб",
                cost: "500 р. за штуку",
                time: "Сегодня",
                feedback: '4.5',
                location: "ул.Ямашева 12",
                hasNumber: true,
              ),
              SizedBox(height: 20),
              EmployerAdvertisement(
                discription:
                    "Нужна крутая презентация для товара на вб! Быстро!",
                cost: "5000",
                time: "4 часа",
                feedback: '5',
                location: "ул.Чуйкова 35",
                hasNumber: true,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: EmployerBottomButtons(
          currentIndex: 1,
          onTabSelected: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => EmployerWorkPage()),
              );
            }
            if (index == 2) {
              // переход на юзера(работорадетль)
            }
          },
        ),
      ),
    );
  }
}
