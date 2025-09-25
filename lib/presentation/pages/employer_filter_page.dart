import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:work_assistent_mob/presentation/pages/employer_profile_page.dart';
import 'package:work_assistent_mob/presentation/pages/employer_work_page.dart';
import 'package:work_assistent_mob/presentation/pages/my_advertisement_page.dart';
import 'package:work_assistent_mob/presentation/widgets/address_field.dart';
import 'package:work_assistent_mob/presentation/widgets/bottom_buttons.dart';
import 'package:work_assistent_mob/presentation/widgets/input_field.dart';
import 'package:work_assistent_mob/presentation/widgets/text_field.dart';

class EmployerFilterPage extends StatefulWidget {
  const EmployerFilterPage({super.key});

  @override
  State<EmployerFilterPage> createState() => _EmployerFilterPageState();
}

class _EmployerFilterPageState extends State<EmployerFilterPage> {
  bool _isSwitched = false;
  int _selectedIndex = 0;
  bool _isFormValid = false;

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  void _validateForm() {
    final isAddressValid = _addressController.text.trim().isNotEmpty;
    final isCityValid = _cityController.text.trim().isNotEmpty;

    setState(() {
      _isFormValid =
          isAddressValid &&
          isCityValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191A1F),
      appBar: AppBar(
        title: const Text(
          "Фильтр",
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
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: InputField(hintText: "Любая"),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30),
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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: AddressAutocompleteField(
                  controller: _addressController,
                  cityController: _cityController, 
                  hintText: "Введите адрес",
                  apiKey: "211d8c431dd6807b5f7201155b55a46629d3cf76",
                  secretKey: "16014d345ad918d0c0dbe7d8ed896232339d4abe",
                  onAddressSelected: (addressData) {
                    print('Получены данные адреса: $addressData');
                    _validateForm();
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30),
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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: CustomTextField(hintText: "От"),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: CustomTextField(hintText: "До"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30),
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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: CustomTextField(hintText: "Любая"),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30),
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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: CustomTextField(hintText: "От")),
                    SizedBox(width: 10),
                    Expanded(child: CustomTextField(hintText: "До")),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/lightning.svg',
                    width: 18,
                    height: 18,
                    color: Color(0xFFFFF024),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Срочно",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  SizedBox(width: 5),
                  Switch(
                    value: _isSwitched,
                    onChanged: (bool value) {
                      setState(() {
                        _isSwitched = value;
                      });
                    },
                    activeColor: Color(0xFF2DD498),
                    inactiveThumbColor: Color(0xFF35383F),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30),
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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: CustomTextField(hintText: "Без опыта"),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    icon: SvgPicture.asset(
                      _selectedIndex == 1
                          ? 'assets/icons/selected.svg'
                          : 'assets/icons/not_selected.svg',
                      width: 20,
                      height: 20,
                    ),
                    label: Text(
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
                      });
                    },
                    icon: SvgPicture.asset(
                      _selectedIndex == 2
                          ? 'assets/icons/selected.svg'
                          : 'assets/icons/not_selected.svg',
                      width: 20,
                      height: 20,
                    ),
                    label: Text(
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
                      });
                    },
                    icon: SvgPicture.asset(
                      _selectedIndex == 3
                          ? 'assets/icons/selected.svg'
                          : 'assets/icons/not_selected.svg',
                      width: 20,
                      height: 20,
                    ),
                    label: Text(
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
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmployerWorkPage(city: _cityController.text)),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Применить',
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
        child: BottomButtons(
          currentIndex: 0,
          onTabSelected: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const EmployerWorkPage()),
              );
            }
            if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyAdvertisementPage()),
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
