import 'package:flutter/material.dart';
import 'package:work_assistent/presentation/pages/filter_page.dart';
import 'package:work_assistent/presentation/pages/my_advertisement_page.dart';
import 'package:work_assistent/presentation/widgets/employer_bottom_buttons.dart';
import 'package:work_assistent/presentation/widgets/filter_button.dart';
import 'package:work_assistent/presentation/widgets/searchbar.dart';
import 'package:work_assistent/presentation/widgets/strangers_employer_advertisement.dart';

class EmployerWorkPage extends StatelessWidget {
  const EmployerWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191A1F),
      appBar: AppBar(
        title: const Text(
          "Работа",
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
              Row(
                children: [
                  MySearchBar(onChanged: (value) {}),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: FilterButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FilterPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              StrangersEmployerAdvertisement(
                discription:
                    "Срочно нужно сделать карточки маркетплейсов для вб",
                cost: "500 р. за штуку",
                time: "Сегодня",
                feedback: '4.5',
                location: "ул.Ямашева 12",
                hasNumber: true,
              ),
              SizedBox(height: 20),
              StrangersEmployerAdvertisement(
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
          currentIndex: 0,
          onTabSelected: (index) {
            if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyAdvertisementPage()),
              );
            }
          },
        ),
      ),
    );
  }
}
