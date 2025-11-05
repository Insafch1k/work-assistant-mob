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

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  
  // Текущий шаг процесса восстановления
  int _currentStep = 1; // 1 - ввод email, 2 - ввод кода, 3 - новый пароль

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  bool _validateEmail(String email) {
    return email.contains('@') && email.contains('.') && email.length > 5;
  }

  void _showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 16,
            color: isError ? Colors.red : Colors.green,
          ),
        ),
        backgroundColor: Color(0xFF35383F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(20),
        duration: Duration(seconds: 3),
      ),
    );
  }

  // Шаг 1: Запрос кода восстановления
  Future<void> _requestRecoveryCode() async {
    if (_emailController.text.isEmpty) {
      _showSnackBar("Введите email");
      return;
    }

    if (!_validateEmail(_emailController.text)) {
      _showSnackBar("Введите корректный email адрес");
      return;
    }

    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    try {
      await loginProvider.forgotPassword(email: _emailController.text);
      _showSnackBar("Код отправлен на вашу почту", isError: false);
      
      // Переходим к шагу 2 - вводу кода
      setState(() {
        _currentStep = 2;
      });
      
    } catch (e) {
      _showSnackBar("Ошибка: $e");
    }
  }

  // Шаг 2: Проверка кода восстановления
  Future<void> _verifyRecoveryCode() async {
    if (_codeController.text.isEmpty) {
      _showSnackBar("Введите код из письма");
      return;
    }

    try {
      final code = int.parse(_codeController.text);
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      
      final isValid = await loginProvider.verifyRecoveryCode(code: code);
      
      if (isValid) {
        _showSnackBar("Код подтвержден!", isError: false);
        
        // Переходим к шагу 3 - вводу нового пароля
        setState(() {
          _currentStep = 3;
        });
      } else {
        _showSnackBar("Неверный код");
      }
      
    } on FormatException {
      _showSnackBar("Код должен состоять из цифр");
    } catch (e) {
      _showSnackBar("Ошибка: $e");
    }
  }

  // Шаг 3: Установка нового пароля
  Future<void> _resetPassword() async {
    if (_newPasswordController.text.isEmpty) {
      _showSnackBar("Введите новый пароль");
      return;
    }

    if (_newPasswordController.text.length < 8) {
      _showSnackBar("Пароль должен содержать не менее 8 символов");
      return;
    }

    try {
      final code = int.parse(_codeController.text);
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      
      await loginProvider.recoverPassword(
        newPassword: _newPasswordController.text,
        code: code,
      );
      
      _showSnackBar("Пароль успешно изменен!", isError: false);
      
      // Переходим на главный экран
      _navigateToMainPage(loginProvider.userRole);
      
    } on FormatException {
      _showSnackBar("Код должен состоять из цифр");
    } catch (e) {
      _showSnackBar("Ошибка смены пароля: $e");
    }
  }

  void _navigateToMainPage(String? role) {
    if (role == 'employer') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => EmployerWorkPage()),
      );
    } else if (role == 'finder') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => WorkPage()),
      );
    } else {
      // Если роль не определена, переходим на экран логина
      Navigator.pop(context);
    }
  }

  void _goBack() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepCircle(1, "Email"),
        _buildStepLine(),
        _buildStepCircle(2, "Код"),
        _buildStepLine(),
        _buildStepCircle(3, "Пароль"),
      ],
    );
  }

  Widget _buildStepCircle(int stepNumber, String label) {
    final isActive = _currentStep == stepNumber;
    final isCompleted = _currentStep > stepNumber;
    
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isActive || isCompleted ? Color(0xFF2DD498) : Color(0xFF71747B),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted 
                ? Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    stepNumber.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Color(0xFF71747B),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine() {
    return Container(
      width: 40,
      height: 2,
      color: Color(0xFF71747B),
      margin: EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 1:
        return _buildEmailStep();
      case 2:
        return _buildCodeStep();
      case 3:
        return _buildPasswordStep();
      default:
        return _buildEmailStep();
    }
  }

  Widget _buildEmailStep() {
    return Column(
      children: [
        /// Email field
        Padding(
          padding: EdgeInsets.only(top: 30, left: 20),
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
        SizedBox(height: 30),
        AuthorizationButton(
          visible: true,
          onPressed: _requestRecoveryCode,
        ),
      ],
    );
  }

  Widget _buildCodeStep() {
    return Column(
      children: [
        Text(
          'На почту ${_emailController.text} отправлен код подтверждения',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        
        /// Code field
        Padding(
          padding: EdgeInsets.only(top: 10, left: 20),
          child: Text(
            "Код подтверждения",
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
              controller: _codeController,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300,
                fontSize: 16.0,
                height: 1.0,
                letterSpacing: 0.0,
                color: Color(0xFFFFFFFF),
              ),
              decoration: InputDecoration(
                hintText: 'Введите код из письма',
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
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        SizedBox(height: 30),
        AuthorizationButton(
          visible: true,
          onPressed: _verifyRecoveryCode,
        ),
      ],
    );
  }

  Widget _buildPasswordStep() {
    return Column(
      children: [
        /// New password field
        Padding(
          padding: EdgeInsets.only(top: 10, left: 20),
          child: Text(
            "Новый пароль",
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
              controller: _newPasswordController,
              obscureText: true,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300,
                fontSize: 16.0,
                height: 1.0,
                letterSpacing: 0.0,
                color: Color(0xFFFFFFFF),
              ),
              decoration: InputDecoration(
                hintText: 'Введите новый пароль',
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
        SizedBox(height: 30),
        AuthorizationButton(
          visible: true,
          onPressed: _resetPassword,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191A1F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _goBack,
        ),
        title: Text(
          'Восстановление пароля',
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              
              // Индикатор шагов
              _buildStepIndicator(),
              SizedBox(height: 40),
              
              // Контент текущего шага
              _buildStepContent(),
            ],
          ),
        ),
      ),
    );
  }
}