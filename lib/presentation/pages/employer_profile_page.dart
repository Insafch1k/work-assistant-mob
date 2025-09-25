import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:work_assistent_mob/domain/entities/resume.dart';
import 'package:work_assistent_mob/presentation/pages/employer_work_page.dart';
import 'package:work_assistent_mob/presentation/pages/my_advertisement_page.dart';
import 'package:work_assistent_mob/presentation/providers/resume_provider.dart';
import 'package:work_assistent_mob/presentation/widgets/employer_bottom_buttons.dart';

class EmployerProfilePage extends StatefulWidget {
  const EmployerProfilePage({super.key});

  @override
  State<EmployerProfilePage> createState() => _EmployerProfilePageState();
}

class _EmployerProfilePageState extends State<EmployerProfilePage> {
  late TextEditingController _phoneController;
  late TextEditingController _nameController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _nameController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<ResumeProvider>(context, listen: false);
      await provider.fetchEmployerResumes();
      _updateControllers(provider.currentEmployerResume);
    });
  }

  void _updateControllers(ResponseEmployerResume? resume) {
    if (resume != null) {
      _phoneController.text = resume.phone ?? '';
      _nameController.text = resume.user_name ?? '';
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
      if (_isEditing) {
        _phoneController.clear();
        _nameController.clear();
      } else {
        _saveChanges();
      }
    });
  }

  Future<void> _saveChanges() async {
    try {
      final provider = Provider.of<ResumeProvider>(context, listen: false);
      await provider.redoEmployerResume(
        user_name:
            _nameController.text.isNotEmpty ? _nameController.text : null,
        phone: _phoneController.text.isNotEmpty ? _phoneController.text : null,
        photo: "",
        organization_name: "",
      );

      setState(() => _isEditing = false);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final resumeProvider = Provider.of<ResumeProvider>(context);
    final currentResume = resumeProvider.currentEmployerResume;

    return Scaffold(
      backgroundColor: const Color(0xFF191A1F),
      appBar: AppBar(
        title: const Text(
          "Профиль",
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
        child: Column(
          children: [
            const SizedBox(height: 20),
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
                          const SizedBox(width: 5),
                          Text(
                            currentResume?.rating.toString() ?? "",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${currentResume?.review_count.toString()} отзывов",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF2DD498),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    "assets/images/ali.png",
                    height: 60,
                    width: 60,
                    color: Color(0xFFFFFFFF),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    currentResume?.user_name ?? 'null',
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
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color(0xFF35383F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Номер телефона",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF71747B),
                            ),
                          ),
                          const SizedBox(height: 5),
                          _isEditing
                              ? TextField(
                                controller: _phoneController,
                                style: const TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFFFFFF),
                                ),
                                decoration: InputDecoration(
                                  hintText:
                                      currentResume?.phone ??
                                      'Введите свой номер',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF71747B),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFF454850),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  constraints: BoxConstraints(maxHeight: 35),
                                ),
                                keyboardType: TextInputType.phone,
                              )
                              : Text(
                                currentResume?.phone ?? 'Не указан',
                                style: const TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                          const SizedBox(height: 12),
                          const Text(
                            "Имя пользователя",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF71747B),
                            ),
                          ),
                          const SizedBox(height: 5),
                          _isEditing
                              ? TextField(
                                controller: _nameController,
                                style: const TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFFFFFF),
                                ),
                                decoration: InputDecoration(
                                  hintText:
                                      currentResume?.user_name ??
                                      'Введите свое имя пользователя',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF71747B),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFF454850),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  constraints: BoxConstraints(maxHeight: 35),
                                ),
                              )
                              : Text(
                                currentResume?.tg_username ?? '',
                                style: const TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                          const SizedBox(height: 12),
                          const Text(
                            "Роль в сервисе",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF71747B),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            currentResume?.user_role == 'employer'
                                ? 'Работодатель'
                                : 'Соискатель',
                            style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: _toggleEditing,
                      icon: SvgPicture.asset(
                        'assets/icons/reduct.svg',
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_isEditing)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6849FF),
                    minimumSize: const Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text(
                    'Сохранить изменения',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: EmployerBottomButtons(
          currentIndex: 2,
          onTabSelected: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmployerWorkPage(),
                ),
              );
            }
            if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyAdvertisementPage(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
