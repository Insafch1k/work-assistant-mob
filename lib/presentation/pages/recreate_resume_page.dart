import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:work_assistent_mob/presentation/pages/favorite_page.dart';
import 'package:work_assistent_mob/presentation/pages/profile_page.dart';
import 'package:work_assistent_mob/presentation/pages/view_history_page.dart';
import 'package:work_assistent_mob/presentation/pages/work_page.dart';
import 'package:work_assistent_mob/presentation/providers/resume_provider.dart';
import 'package:work_assistent_mob/presentation/widgets/bottom_buttons.dart';
import 'package:work_assistent_mob/presentation/widgets/new_resume_text_field.dart';

class RecreateResumePage extends StatefulWidget {
  const RecreateResumePage({super.key});

  @override
  State<RecreateResumePage> createState() => _RecreateResumePageState();
}

class _RecreateResumePageState extends State<RecreateResumePage> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _workXpController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<ResumeProvider>(context, listen: false);
      await provider.fetchResumes();
    });
  }

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

  void _showAnimatedDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: double.infinity,
                height: 168,
                decoration: BoxDecoration(
                  color: const Color(0xFF35383F),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Вы уверены, что хотите удалить резюме?",
                              style: TextStyle(
                                fontFamily: "Inter",
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0XFFF56B68),
                                      side: const BorderSide(
                                        color: Color(0XFFF56B68),
                                        width: 1.5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(
                                        context,
                                      ); // Закрываем диалог
                                      try {
                                        final provider =
                                            Provider.of<ResumeProvider>(
                                              context,
                                              listen: false,
                                            );
                                        await provider.deleteResume();
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    const ProfilePage(),
                                          ),
                                        );
                                      } catch (e) {}
                                    },
                                    child: const Text(
                                      'Удалить',
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 20,
                          height: 20,
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/cross.svg',
                              width: 20,
                              height: 20,
                              color: const Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(scale: anim, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final resumeProvider = Provider.of<ResumeProvider>(context, listen: false);

    final currentResume = resumeProvider.currentResume;

    return Scaffold(
      backgroundColor: const Color(0xFF191A1F),
      appBar: AppBar(
        title: const Text(
          "Редактирование",
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
          decoration: const BoxDecoration(color: Color(0xFF191A1F)),
        ),
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
              child: NewResumeTextField(
                controller: _jobTitleController,
                hintText: currentResume?.job_title ?? '',
              ),
            ),
            const SizedBox(height: 10),
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
              child: NewResumeTextField(
                controller: _educationController,
                hintText: currentResume?.education ?? '',
              ),
            ),
            const SizedBox(height: 10),
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
              child: NewResumeTextField(
                controller: _workXpController,
                hintText: currentResume?.work_xp ?? '',
              ),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:  20),
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
            const SizedBox(height: 20),
            // Кнопка сохранения
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF2DD498),
                    side: const BorderSide(
                      color: Color(0XFF2DD498),
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () async {
                    if (_jobTitleController.text.isEmpty ||
                        _educationController.text.isEmpty ||
                        _workXpController.text.isEmpty ||
                        _skillsController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Пожалуйста, заполните все поля'),
                        ),
                      );
                      return;
                    }

                    try {
                      await resumeProvider.redoResume(
                        jobTitle: _jobTitleController.text,
                        education: _educationController.text,
                        workXp: _workXpController.text,
                        skills: _skillsController.text,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Ошибка при сохранении: ${e.toString()}',
                          ),
                        ),
                      );
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
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
            const SizedBox(height: 20),
            // Кнопка удаления
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFFF56B68),
                    side: const BorderSide(
                      color: Color(0XFFF56B68),
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    _showAnimatedDialog(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Удалить',
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

  Widget _skillChip(String skill, int index) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.9,
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
}
