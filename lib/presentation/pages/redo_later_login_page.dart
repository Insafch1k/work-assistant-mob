// class LoginPage extends StatefulWidget {
//   final SaveUserNameUseCase saveUserNameUseCase;
//   final GetUserNameUseCase getUserNameUseCase;
//   final HasUserNameUseCase hasUserNameUseCase;

//   const LoginPage({
//     Key? key,
//     required this.saveUserNameUseCase,
//     required this.getUserNameUseCase,
//     required this.hasUserNameUseCase,
//   }) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool showChoice = false;
//   String selected = "Выберите роль";
//   String? selectedRole;
//   final TextEditingController _nameController = TextEditingController();
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadCachedData();
//   }

//   Future<void> _loadCachedData() async {
//     try {
//       final hasUserName = await widget.hasUserNameUseCase();
//       if (hasUserName) {
//         final userName = await widget.getUserNameUseCase();
//         if (userName != null) {
//           setState(() {
//             _nameController.text = userName;
//           });
//         }
//       }
//     } catch (e) {
//       print('Ошибка загрузки кэшированных данных: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void handleSelection(String value) {
//     setState(() {
//       selected = value;
//       selectedRole = value == "Я работодатель" ? "employer" : "finder";
//     });
//   }

//   void handleShowChoice(bool value) {
//     setState(() {
//       showChoice = value;
//     });
//   }

//   Future<void> _handleLogin() async {
//     if (_nameController.text.isEmpty || selectedRole == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Заполните все поля')),
//       );
//       return;
//     }

//     final loginProvider = Provider.of<LoginProvider>(context, listen: false);

//     try {
//       // Сохраняем имя пользователя
//       await widget.saveUserNameUseCase(_nameController.text);

//       await loginProvider.performLogin(
//         Login(
//           tg: '269',
//           user_name: _nameController.text,
//           user_role: selectedRole!,
//           tg_username: '@269',
//         ),
//       );

//       if (selectedRole == 'employer') {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => EmployerWorkPage()),
//         );
//       } else if (selectedRole == 'finder') {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => WorkPage()),
//         );
//       }

//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Ошибка авторизации: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return Scaffold(
//         backgroundColor: Color(0xFF191A1F),
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }



//     в других местах использование 
//     final getUserNameUseCase = getIt<GetUserNameUseCase>();

// // Использовать
// String? userName = await getUserNameUseCase();
