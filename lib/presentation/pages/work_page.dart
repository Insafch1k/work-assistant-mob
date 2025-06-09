import 'package:flutter/material.dart';
import 'package:work_assistent/presentation/pages/notice_page.dart';
import 'package:work_assistent/presentation/widgets/advertisement.dart';
import 'package:work_assistent/presentation/widgets/bottom_buttons.dart';
import 'package:work_assistent/presentation/widgets/filter_button.dart';
import 'package:work_assistent/presentation/widgets/searchbar.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({super.key});

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
        backgroundColor: Color(0xFF191A1F),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  MySearchBar(onChanged: (value) {}),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: FilterButton(onPressed: () {}),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Advertisement(
              discription: "Срочно нужно сделать карточки маркетплейсов для вб",
              cost: "500 р. за штуку",
              time: "Сегодня",
              feedback: '4.5',
            ),
            SizedBox(height: 20),
            Advertisement(
              discription: "Нужна крутая презентация для товара на вб! Быстро!",
              cost: "5000",
              time: "4 часа",
              feedback: '5',
            ),
            SizedBox(height: 20),
            Advertisement(
              discription: "Нужна крутая презентация для товара на вб! Быстро!",
              cost: "5000",
              time: "4 часа",
              feedback: '5',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: BottomButtons(
          currentIndex: 0,
          onTabSelected: (index) {
            if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NoticePage()),
              );
            }
          },
        ),
      ),
    );
  }
}
