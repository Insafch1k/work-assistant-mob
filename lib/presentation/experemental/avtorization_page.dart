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

class AvtorizationPage extends StatefulWidget {
  const AvtorizationPage({Key? key}) : super(key: key);

  @override
  State<AvtorizationPage> createState() => _AvtorizationPageState();
}

class _AvtorizationPageState extends State<AvtorizationPage> {
  bool showChoice = false;
  String selected = "Выберите роль";
  String? selectedRole;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateFields() {
    if (_emailController.text.isEmpty) {
      _showSnackBar("Заполните все поля");
      return false;
    }
    if (!_validateEmail(_emailController.text)) {
      _showSnackBar("Введите корректный email адрес");
      return false;
    }
    if (_passwordController.text.isEmpty) {
      _showSnackBar("Заполните все поля");
      return false;
    }
    if (_passwordController.text.length < 8) {
      _showSnackBar("Пароль должен содержать не менее 8 символов");
      return false;
    }

    return true;
  }

  bool _validateEmail(String email) {
    return email.contains('@') && email.contains('.') && email.length > 5;
  }

  bool _validateCode(String receivedCode, String enteredCode) {
    if (receivedCode != enteredCode) {
      return false;
    }
    return true;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 16,
            color: Colors.red,
          ),
        ),
        backgroundColor: Color(0xFF35383F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(20),
        duration: Duration(seconds: 2),
      ),
    );
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
    if (!_validateFields()) {
      return;
    }

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    try {
      final Map<String, dynamic> result = await loginProvider.login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final serverRole = result['role'] as String;
      print("🎯 Роль с сервера для навигации: $serverRole");

      if (serverRole == 'employer') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => EmployerWorkPage()),
        );
      }

      if (serverRole == 'finder') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => WorkPage()),
        );
      }
    } catch (e) {
      print("Ошибка в авторизации $e");
      _showSnackBar("Неправльные данные");
    }
  }

  Future<void> _completeRegistration() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    try {
      final code = int.parse(_codeController.text);
      await loginProvider.confirmEmail(code: code);
      if (selectedRole == 'employer') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => EmployerWorkPage()),
        );
      } else if (selectedRole == 'finder') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => WorkPage()),
        );
      }
    } catch (e) {
      print("Ошибка в подтверждении почты $e");
      if (e.toString().contains("Неверный код")) {
        _showSnackBar("Неверный код");
      }
    }
  }

  Future<void> _showEmailConfirmationDialog(
    TextEditingController _codeController,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF191A1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Подтверждение почты',
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'На почту ${_emailController.text} отправлен код подтверждения. Введите его ниже:',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF35383F),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: _codeController,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w300,
                    fontSize: 16.0,
                    color: Color(0xFFFFFFFF),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Введите код из письма',
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0,
                      color: Color(0xFF71747B),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Отмена',
                style: TextStyle(fontFamily: "Inter", color: Colors.white70),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2DD498),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (_codeController.text.isEmpty) {
                  _showSnackBar("Введите код подтверждения");
                  return;
                }
                Navigator.of(context).pop();
                _completeRegistration();
              },
              child: Text(
                'Подтвердить',
                style: TextStyle(fontFamily: "Inter", color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
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
              SizedBox(height: 40),
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
              SizedBox(height: 30),
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

              ///email
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  "Почта",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              SizedBox(height: 5),
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
                    controller: _emailController,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0,
                      height: 1.0,
                      letterSpacing: 0.0,
                      color: Color(0xFFFFFFFF),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Ваша почта',
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

              ///password
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  "Пароль",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
              SizedBox(height: 5),
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
                    controller: _passwordController,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0,
                      height: 1.0,
                      letterSpacing: 0.0,
                      color: Color(0xFFFFFFFF),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Введите пароль',
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

              showChoice
                  ? Column(
                    children: [
                      const SizedBox(height: 5),
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
                      const SizedBox(height: 15),
                      AuthorizationButton(
                        visible: true,
                        onPressed: _handleLogin,
                      ),
                    ],
                  )
                  : Column(
                    children: [
                      const SizedBox(height: 15),
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
