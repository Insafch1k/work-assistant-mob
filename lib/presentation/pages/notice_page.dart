import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:work_assistent/presentation/pages/work_page.dart';
import 'package:work_assistent/presentation/widgets/bottom_buttons.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191A1F),
      appBar: AppBar(
        title: const Text(
          "Объявления",
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

      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 15),
        child: SizedBox(
          height: 40,
          width: 380,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF191A1F),
              side: BorderSide(color: Color(0XFF6849FF), width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {},
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
                  'Разместить объявление',
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
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: BottomButtons(
          currentIndex: 2,
          onTabSelected: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WorkPage()),
              );
            }
          },
        ),
      ),
    );
  }
}
