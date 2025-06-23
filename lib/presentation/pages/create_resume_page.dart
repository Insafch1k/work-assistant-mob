import 'package:flutter/material.dart';
import 'package:work_assistent/presentation/pages/notice_page.dart';
import 'package:work_assistent/presentation/pages/profile_page.dart';
import 'package:work_assistent/presentation/widgets/bottom_buttons.dart';
import 'package:work_assistent/presentation/widgets/new_resume_text_field.dart';

class CreateResumePage extends StatefulWidget {
  final bool hasResume;
  final ValueChanged<bool> onhasResume;

  const CreateResumePage({
    required this.hasResume,
    required this.onhasResume,
    super.key
    });

  @override
  State<CreateResumePage> createState() => _CreateResumePageState();
}

class _CreateResumePageState extends State<CreateResumePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191A1F),
      appBar: AppBar(
        title: const Text(
          "Новое резюме",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 31),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Желаемая должность",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF71747B),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: NewResumeTextField(),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Образование",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF71747B),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: NewResumeTextField(),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Опыт рыботы",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF71747B),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: NewResumeTextField(),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Навыки",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF71747B),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: NewResumeTextField(isBorder: true),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFF2DD498),
                    side: BorderSide(color: Color(0XFF2DD498), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    widget.onhasResume(true);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Сохранить',
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
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: BottomButtons(
          currentIndex: 0,
          onTabSelected: (index) {
            if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const NoticePage()),
              );
            }
          },
        ),
      ),
    );
  }
}
