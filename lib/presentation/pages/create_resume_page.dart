import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:work_assistent_mob/presentation/pages/favorite_page.dart';
import 'package:work_assistent_mob/presentation/pages/profile_page.dart';
import 'package:work_assistent_mob/presentation/pages/view_history_page.dart';
import 'package:work_assistent_mob/presentation/pages/work_page.dart';
import 'package:work_assistent_mob/presentation/providers/resume_provider.dart';
import 'package:work_assistent_mob/presentation/widgets/bottom_buttons.dart';
import 'package:work_assistent_mob/presentation/widgets/skills.dart';

class CreateResumePage extends StatefulWidget {
  const CreateResumePage({super.key});

  @override
  State<CreateResumePage> createState() => _CreateResumePageState();
}

class _CreateResumePageState extends State<CreateResumePage> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _workXpController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  List<String> skillsList = [];
  String skills = '';

  void _addSkill() {
    String newSkill = _skillsController.text.trim();
    if (newSkill.isNotEmpty) {
      setState(() {
        skillsList.add(newSkill);
        skills = skillsList.join(', ');
      });
      _skillsController.clear();
    }
  }

  void _removeSkill(int index) {
    setState(() {
      skillsList.removeAt(index);
      skills = skillsList.join(', ');
    });
  }

  @override
  void dispose() {
    _jobTitleController.dispose();
    _educationController.dispose();
    _workXpController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resumeProvider = Provider.of<ResumeProvider>(context, listen: false);

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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 31),

            // Желаемая должность
            const Padding(
              padding: EdgeInsets.only(left: 30),
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _newResumeTextField(
                _jobTitleController,
                "Введите желаемую должность",
              ),
            ),
            const SizedBox(height: 20),

            // Образование
            const Padding(
              padding: EdgeInsets.only(left: 30),
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _newResumeTextField(
                _educationController,
                "Введите ваше образование",
              ),
            ),
            const SizedBox(height: 20),

            // Опыт работы
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Опыт работы",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF71747B),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _newResumeTextField(
                _workXpController,
                "Введите ваш опыт работы",
              ),
            ),
            const SizedBox(height: 20),

            // Навыки
            const Padding(
              padding: EdgeInsets.only(left: 30),
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                constraints: const BoxConstraints(minHeight: 60, maxHeight: 60),
                decoration: BoxDecoration(
                  color: Color(0xFF35383F),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          controller: _skillsController,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFFFFFF),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Напишите навыки',
                            hintStyle: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w300,
                              fontSize: 16.0,
                              color: Color(0xFF71747B),
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Color(0xFF6849FF),
                                width: 1,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _addSkill,
                      icon: SvgPicture.asset(
                        'assets/icons/plus.svg',
                        width: 20,
                        height: 20,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Wrap(
                children: [
                  // Используем asMap() чтобы получить индекс каждого элемента
                  ...skillsList.asMap().entries.map((entry) {
                    int index = entry.key;
                    String skill = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 8),
                      child: _skillChip(skill, index),
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Кнопка сохранения
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2DD498),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () async {
                    // Валидация полей (исправлено - проверяем skillsList вместо _skillsController)
                    if (_jobTitleController.text.isEmpty ||
                        _educationController.text.isEmpty ||
                        _workXpController.text.isEmpty ||
                        skillsList.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Пожалуйста, заполните все поля'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    print(skills);

                    try {
                      // Сохранение резюме (передаем собранную строку навыков)
                      await resumeProvider.sendResume(
                        jobTitle: _jobTitleController.text,
                        education: _educationController.text,
                        workXp: _workXpController.text,
                        skills: skills, // Используем собранную строку
                      );

                      // Успешное сохранение - переход на страницу профиля
                      if (!mounted) return;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                        (route) => false,
                      );
                    } catch (e) {
                      // Обработка ошибок
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Ошибка при сохранении: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Сохранить',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: BottomButtons(
          currentIndex: 4,
          onTabSelected: (index) {
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const WorkPage()),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoritePage()),
                );
                break;
              case 2:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewHistoryPage(),
                  ),
                );
                break;
              case 3:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
                break;
            }
          },
        ),
      ),
    );
  }

  Widget _skillChip(String skill, int index) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.6,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF35383F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 7, bottom: 7, right: 20),
            child: Text(
              skill,
              style: TextStyle(
                fontFamily: "Inter",
                color: Color(0xFFFFFFFF),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            right: 3,
            top: 3,
            child: Container(
              child: GestureDetector(
                onTap: () {
                  print('Удаление навыка: $index');
                  _removeSkill(index);
                },
                child: SvgPicture.asset(
                  "assets/icons/cross.svg",
                  width: 18,
                  height: 18,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _newResumeTextField(
    TextEditingController controller,
    String hintText, {
    bool isBorder = false,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 60, maxHeight: 240),
      decoration: BoxDecoration(
        color: const Color(0xFF35383F),
        borderRadius: BorderRadius.circular(15),
        border:
            isBorder
                ? Border.all(color: const Color(0xFFFFFFFF), width: 1.0)
                : null,
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          color: Color(0xFFFFFFFF),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
            color: Color(0xFF71747B),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 16.0,
          ),
        ),
      ),
    );
  }
}
