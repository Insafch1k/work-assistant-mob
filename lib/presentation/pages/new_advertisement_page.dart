import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:work_assistent_mob/domain/entities/advertisement.dart';
import 'package:work_assistent_mob/presentation/pages/employer_profile_page.dart';
import 'package:work_assistent_mob/presentation/pages/employer_work_page.dart';
import 'package:work_assistent_mob/presentation/pages/my_advertisement_page.dart';
import 'package:work_assistent_mob/presentation/providers/advertisement_provider.dart';
import 'package:work_assistent_mob/presentation/widgets/address_field.dart';
import 'package:work_assistent_mob/presentation/widgets/double_text_field.dart';
import 'package:work_assistent_mob/presentation/widgets/employer_bottom_buttons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:work_assistent_mob/presentation/widgets/text_field.dart';

class NewAdvertisementPage extends StatefulWidget {
  const NewAdvertisementPage({super.key});

  @override
  State<NewAdvertisementPage> createState() => _NewAdvertisementPageState();
}

class _NewAdvertisementPageState extends State<NewAdvertisementPage> {
  bool _isUrgent = false;
  String wanted_job = "Выберите категорию";
  String job_xp = "Выберите опыт работы";
  bool _car = false;
  int _selectedIndex = 0;
  String _age = '';

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _timeStartController = TextEditingController();
  final TextEditingController _timeEndController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Переменная для отслеживания валидации
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    // Добавляем слушатели для проверки формы
    _titleController.addListener(_validateForm);
    _addressController.addListener(_validateForm);
    _cityController.addListener(_validateForm);
    _timeStartController.addListener(_validateForm);
    _timeEndController.addListener(_validateForm);
    _dateController.addListener(_validateForm);
    _salaryController.addListener(_validateForm);
    _descriptionController.addListener(_validateForm);
  }

  @override
  void dispose() {
    // Очищаем контроллеры при удалении виджета
    _titleController.removeListener(_validateForm);
    _addressController.removeListener(_validateForm);
    _cityController.dispose();
    _timeStartController.removeListener(_validateForm);
    _timeEndController.removeListener(_validateForm);
    _dateController.removeListener(_validateForm);
    _salaryController.removeListener(_validateForm);
    _descriptionController.removeListener(_validateForm);

    _titleController.dispose();
    _addressController.dispose();
    _timeStartController.dispose();
    _timeEndController.dispose();
    _dateController.dispose();
    _salaryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Метод для проверки валидности формы
  void _validateForm() {
    final isTitleValid = _titleController.text.trim().isNotEmpty;
    final isAddressValid = _addressController.text.trim().isNotEmpty;
    final isCityValid = _cityController.text.trim().isNotEmpty;
    final isTimeStartValid = _timeStartController.text.trim().isNotEmpty;
    final isTimeEndValid = _timeEndController.text.trim().isNotEmpty;
    final isDateValid = _dateController.text.trim().isNotEmpty;
    final isSalaryValid = _salaryController.text.trim().isNotEmpty;
    final isDescriptionValid = _descriptionController.text.trim().isNotEmpty;
    final isXpValid = job_xp != 'Выберите опыт работы';
    final isCategoryValid = wanted_job != "Выберите категорию";
    final isAgeSelected = _age.isNotEmpty;

    setState(() {
      _isFormValid =
          isTitleValid &&
          isAddressValid &&
          isCityValid &&
          isTimeStartValid &&
          isTimeEndValid &&
          isDateValid &&
          isSalaryValid &&
          isDescriptionValid &&
          isCategoryValid &&
          isAgeSelected;
    });
  }

  String _getAddressWithoutCity() {
    final fullAddress = _addressController.text;
    final city = _cityController.text;

    if (city.isEmpty) return fullAddress;

    // Удаляем город из начала адреса
    if (fullAddress.startsWith('$city,')) {
      return fullAddress.substring(city.length + 1).trim();
    }
    if (fullAddress.startsWith('г. $city,')) {
      return fullAddress.substring(city.length + 3).trim();
    }
    if (fullAddress.startsWith('город $city,')) {
      return fullAddress.substring(city.length + 6).trim();
    }

    return fullAddress;
  }

  Future<void> _createAdvertisement() async {
    // Проверяем форму еще раз перед отправкой
    if (!_isFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заполните все обязательные поля')),
      );
      return;
    }

    // Получаем провайдер из контекста
    final advertisementProvider = Provider.of<AdvertisementProvider>(
      context,
      listen: false,
    );

    try {
      // Создаем запрос на основе введенных данных
      final request = RequestCreateAdvertisement(
        title: _titleController.text,
        wanted_job: wanted_job,
        description: _descriptionController.text,
        salary: int.tryParse(_salaryController.text) ?? 0,
        date: _dateController.text,
        time_start: _timeStartController.text,
        time_end: _timeEndController.text,
        address: _getAddressWithoutCity(),
        is_urgent: _isUrgent,
        xp: job_xp,
        age: _age,
        car: _car,
        city: _cityController.text,
      );

      // Вызываем метод создания объявления
      final message = await advertisementProvider.createAdv(request);

      // Показываем сообщение об успехе
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));

      // Переходим на страницу моих объявлений
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyAdvertisementPage()),
      );
    } catch (e) {
      // Показываем сообщение об ошибке
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191A1F),
      appBar: AppBar(
        title: const Text(
          "Новое объявление",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 24,
            fontWeight: FontWeight.w600,
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
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Категория подработки ",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField2<String>(
                value: wanted_job,
                dropdownStyleData: DropdownStyleData(
                  width: MediaQuery.of(context).size.width - 40,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: const Color(0xFF35383F),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  height: 1.25,
                  color: const Color(0xFFFFFFFF),
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF35383F),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 14.0,
                  ),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(Icons.arrow_drop_down, color: Color(0xFFFFFFFF)),
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Выберите категорию",
                    child: Text(
                      "Выберите категорию",
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
                  ),
                  DropdownMenuItem(value: "Шабашка", child: Text("Шабашка")),
                  DropdownMenuItem(value: "Общепит", child: Text("Общепит")),
                  DropdownMenuItem(value: "Услуги", child: Text("Услуги")),
                  DropdownMenuItem(
                    value: "Образование",
                    child: Text("Образование"),
                  ),
                  DropdownMenuItem(
                    value: "IT и программирование",
                    child: Text("IT и программирование"),
                  ),
                  DropdownMenuItem(
                    value: "Транспорт и логистика",
                    child: Text("Транспорт и логистика"),
                  ),
                  DropdownMenuItem(value: "Торговля", child: Text("Торговля")),
                  DropdownMenuItem(
                    value: "Здоровье и красота",
                    child: Text("Здоровье и красота"),
                  ),
                  DropdownMenuItem(
                    value: "Креативные профессии",
                    child: Text("Креативные профессии"),
                  ),
                  DropdownMenuItem(
                    value: "Обслуживание и сервис",
                    child: Text("Обслуживание и сервис"),
                  ),
                  DropdownMenuItem(
                    value: "Фриланс и удаленная работа",
                    child: Text("Фриланс и удаленная работа"),
                  ),
                  DropdownMenuItem(
                    value: "Домашние услуги",
                    child: Text("Домашние услуги"),
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    wanted_job = value ?? 'Выберите категорию';
                    _validateForm();
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Название подработки ",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: CustomTextField(
                  controller: _titleController,
                  hintText: "Напишите название подработки",
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Адрес подработки",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: AddressAutocompleteField(
                  controller: _addressController,
                  cityController: _cityController, // Передаем контроллер города
                  hintText: "Введите адрес",
                  apiKey: "211d8c431dd6807b5f7201155b55a46629d3cf76",
                  secretKey: "16014d345ad918d0c0dbe7d8ed896232339d4abe",
                  onAddressSelected: (addressData) {
                    // addressData содержит {'address': 'ул. Ленина, 10', 'city': 'Казань'}
                    print('Получены данные адреса: $addressData');
                    _validateForm();
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Время подработки",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DoubleTextField(
                firstController: _timeStartController,
                secondController: _timeEndController,
                firstHintText: "ЧЧ:ММ",
                secondHintText: "ЧЧ:ММ",
                spacing: 15,
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Дата подработки",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: CustomTextField(
                  controller: _dateController,
                  hintText: "ДД.ММ.ГГГГ",
                  dateFormat: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Зарплата",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: CustomTextField(
                  controller: _salaryController,
                  hintText: "Укажите заработную плату",
                  numbersOnly: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/lightning.svg',
                    width: 18,
                    height: 18,
                    color:
                        _isUrgent
                            ? const Color(0xFFFFF024)
                            : const Color(0xFF5F5A21),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "Срочно",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Switch(
                    value: _isUrgent,
                    onChanged: (bool value) {
                      setState(() {
                        _isUrgent = value;
                      });
                    },
                    activeColor: const Color(0xFF2DD498),
                    inactiveThumbColor: const Color(0xFF35383F),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/car.svg',
                    width: 18,
                    height: 18,
                    color:
                        _car
                            ? const Color(0xFFFF2A69)
                            : const Color(0xFF5E2035),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "Требуется авто",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Switch(
                    value: _car,
                    onChanged: (bool value) {
                      setState(() {
                        _car = value;
                      });
                    },
                    activeColor: const Color(0xFF2DD498),
                    inactiveThumbColor: const Color(0xFF35383F),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Опыт работы",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField2<String>(
                value: job_xp,
                dropdownStyleData: DropdownStyleData(
                  width: MediaQuery.of(context).size.width - 40,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: const Color(0xFF35383F),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  height: 1.25,
                  color: const Color(0xFFFFFFFF),
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF35383F),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 14.0,
                  ),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(Icons.arrow_drop_down, color: Color(0xFFFFFFFF)),
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Выберите опыт работы",
                    child: Text(
                      "Выберите опыт работы",
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Нет опыта",
                    child: Text("Нет опыта"),
                  ),
                  DropdownMenuItem(
                    value: "От 1 года",
                    child: Text("От 1 года"),
                  ),
                  DropdownMenuItem(value: "От 3 лет", child: Text("От 3 лет")),
                ],
                onChanged: (String? value) {
                  setState(() {
                    job_xp = value ?? 'Выберите опыт работы';
                    _validateForm();
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                        _age = 'старше 14 лет';
                        _validateForm();
                      });
                    },
                    icon: SvgPicture.asset(
                      _selectedIndex == 1
                          ? 'assets/icons/selected.svg'
                          : 'assets/icons/not_selected.svg',
                      width: 20,
                      height: 20,
                    ),
                    label: const Text(
                      "Старше 14 лет",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 2;
                        _age = 'старше 16 лет';
                        _validateForm();
                      });
                    },
                    icon: SvgPicture.asset(
                      _selectedIndex == 2
                          ? 'assets/icons/selected.svg'
                          : 'assets/icons/not_selected.svg',
                      width: 20,
                      height: 20,
                    ),
                    label: const Text(
                      "Старше 16 лет",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 3;
                        _age = 'старше 18 лет';
                        _validateForm();
                      });
                    },
                    icon: SvgPicture.asset(
                      _selectedIndex == 3
                          ? 'assets/icons/selected.svg'
                          : 'assets/icons/not_selected.svg',
                      width: 20,
                      height: 20,
                    ),
                    label: const Text(
                      "Старше 18 лет",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Описание работы",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: CustomTextField(
                  controller: _descriptionController,
                  hintText: "Напишите описание подработки",
                  maxLines: 3,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF2DD498), // Всегда зеленый
                    side: BorderSide(
                      color: const Color(
                        0XFF2DD498,
                      ), // Такая же зеленая граница
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    if (_isFormValid) {
                      _createAdvertisement();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Заполните все поля'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Разместить объявление',
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
        child: EmployerBottomButtons(
          currentIndex: 1,
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
            if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmployerProfilePage(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
