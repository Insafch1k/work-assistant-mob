import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:work_assistent_mob/domain/entities/login.dart';
import 'package:work_assistent_mob/presentation/pages/employer_work_page.dart';
import 'package:work_assistent_mob/presentation/pages/work_page.dart';
import 'package:work_assistent_mob/presentation/providers/login_provider.dart';
import 'package:work_assistent_mob/presentation/widgets/authorization_button.dart';
import 'package:work_assistent_mob/presentation/widgets/choice_buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showChoice = false;
  String selected = "Выберите роль";
  String? selectedRole;
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void handleSelection(String value) {
    setState(() {
      selected = value;
      selectedRole = value == "Я работодатель" ? "employer" : "finder";
    });
  }

  void handleShowChoice(bool value) {
    setState(() {
      showChoice = value;
    });
  }

  Future<void> _handleLogin() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    try {
      await loginProvider.performLogin(
        Login(
          tg: '282',
          user_name: _nameController.text,
          user_role: selectedRole!,
          tg_username: '@282',
        ),
      );

      if (selectedRole == 'employer') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => EmployerWorkPage()),
        );
      }

      if (selectedRole == 'finder') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => WorkPage()),
        );
      }


    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191A1F),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 42),
              Center(
                child: Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    selected == "Выберите роль"
                        ? 'assets/images/together.png'
                        : selected == "Я работодатель"
                        ? 'assets/images/employer.png'
                        : 'assets/images/seeker.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: Text(
                  'Авторизация',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 40, left: 20),
                child: Text(
                  "Имя",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color(0xFF35383F),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: _nameController,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0,
                      height: 1.0,
                      letterSpacing: 0.0,
                      color: Color(0xFFFFFFFF),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Ваше имя',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w300,
                        fontSize: 16.0,
                        height: 1.0,
                        color: Color(0xFF71747B),
                        letterSpacing: 0.0,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                        top: 20,
                        bottom: 10.0,
                        left: 25.0,
                        right: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  "Роль в сервисе",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF35383F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 20,
                        top: 11,
                        bottom: 10,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        showChoice = !showChoice;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selected,
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        SvgPicture.asset(
                          showChoice
                              ? 'assets/icons/up.svg'
                              : 'assets/icons/down.svg',
                          width: 20,
                          height: 20,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              showChoice
                  ? Column(
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: ChoiceButtons(
                          selected: selected,
                          onSelected: handleSelection,
                          showChoice: showChoice,
                          onShowChoice: handleShowChoice,
                        ),
                      ),
                      const SizedBox(height: 20), // Добавьте отступ
                      AuthorizationButton(
                        visible: true,
                        onPressed: _handleLogin,
                      ),
                    ],
                  )
                  : Column(
                    children: [
                      const SizedBox(height: 40),
                      AuthorizationButton(
                        visible: true,
                        onPressed: _handleLogin,
                      ),
                    ],
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
