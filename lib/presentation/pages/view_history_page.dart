import 'package:flutter/material.dart';
import 'package:work_assistent/presentation/pages/favorite_page.dart';
import 'package:work_assistent/presentation/pages/profile_page.dart';
import 'package:work_assistent/presentation/pages/work_page.dart';
import 'package:work_assistent/presentation/widgets/advertisement.dart';
import 'package:work_assistent/presentation/widgets/bottom_buttons.dart';

class ViewHistoryPage extends StatelessWidget {
  const ViewHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191A1F),
      appBar: AppBar(
        title: const Text(
          "История просмотра",
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
          decoration: BoxDecoration(
            color: const Color(0xFF191A1F), 
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              Advertisement(
                discription:
                    "Нужно сыграть заменой в финале Лиги Наций. Я заболел.",
                cost: "1 000 000р.",
                time: "2 часа",
                feedback: '5',
                location: "Германия",
                hasNumber: false,
              ),
              SizedBox(height: 20),
              Advertisement(
                discription:
                    "Нужна крутая презентация для товара на вб! Быстро!",
                cost: "5000",
                time: "4 часа",
                feedback: '5',
                location: "ул.Чуйкова 35",
                hasNumber: true,

              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: BottomButtons(
          currentIndex: 2,
          onTabSelected: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WorkPage()),
              );
            }
            if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => FavoritePage()),
              );
            }
            if (index == 3) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            }
          },
        ),
      ),
    );
  }
}
