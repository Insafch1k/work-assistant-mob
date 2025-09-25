import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_assistent_mob/presentation/pages/employer_filter_page.dart';
import 'package:work_assistent_mob/presentation/pages/employer_profile_page.dart';
import 'package:work_assistent_mob/presentation/pages/filter_page.dart';
import 'package:work_assistent_mob/presentation/pages/my_advertisement_page.dart';
import 'package:work_assistent_mob/presentation/providers/advertisement_provider.dart';
import 'package:work_assistent_mob/presentation/widgets/city_selection_widget.dart';
import 'package:work_assistent_mob/presentation/widgets/employer_bottom_buttons.dart';
import 'package:work_assistent_mob/presentation/widgets/filter_button.dart';
import 'package:work_assistent_mob/presentation/widgets/filtered_advertisement.dart';
import 'package:work_assistent_mob/presentation/widgets/searchbar.dart';
import 'package:work_assistent_mob/presentation/widgets/strangers_employer_advertisement.dart';

class EmployerWorkPage extends StatefulWidget {
  final String city;
  const EmployerWorkPage({super.key, this.city = ''});

  @override
  State<EmployerWorkPage> createState() => _EmployerWorkPageState();
}

class _EmployerWorkPageState extends State<EmployerWorkPage> {
  bool _showCitySelector = false;
  late String _currentCity;

  @override
  void initState() {
    super.initState();
    _currentCity = widget.city;
    _loadAdvertisements();
  }

  @override
  void didUpdateWidget(EmployerWorkPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.city != oldWidget.city) {
      setState(() {
        _currentCity = widget.city;
      });
      _loadAdvertisements();
    }
  }

  void _loadAdvertisements() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_currentCity.isNotEmpty) {
        context.read<AdvertisementProvider>().fetchFilteredAdvertisements(
          _currentCity,
        );
        print('fetchFilteredAdvertisements: ${_currentCity}');
      } else {
        context.read<AdvertisementProvider>().fetchAdvertisements();
        print('fetchAdvertisements: ');
      }
    });
  }

  void _handleCitySelected(String city) {
    setState(() {
      _showCitySelector = false;
      _currentCity = city;
    });
    _loadAdvertisements();
  }

  void _handleClearCity() {
    setState(() {
      _currentCity = '';
      _showCitySelector = false;
    });
    context.read<AdvertisementProvider>().fetchAdvertisements();
  }

  void _toggleCitySelector() {
    setState(() {
      _showCitySelector = !_showCitySelector;
    });
  }

  void _hideCitySelector() {
    if (_showCitySelector) {
      setState(() {
        _showCitySelector = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Выбранный город $_currentCity");
    final provider = context.watch<AdvertisementProvider>();

    final citiesToUse =
        provider.cities.isNotEmpty
            ? provider.cities
            : ['нету', 'городов', 'в списке'];

    // Определяем цвет кнопки в зависимости от выбранного города
    final buttonColor =
        _currentCity.isNotEmpty
            ? Color(0xFF6849FF) // Фиолетовый, если город выбран
            : (_showCitySelector
                ? Color(0xFF6849FF)
                : Color(0xFF35383F)); // Серый или фиолетовый при активации

    return GestureDetector(
      onTap: _hideCitySelector,
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: Color(0xFF191A1F),
        appBar: AppBar(
          title: Text(
            "Работа",
            style: const TextStyle(
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: MySearchBar(onChanged: (value) {}),
                    ),
                    SizedBox(width: 10),
                    FilterButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FilterPage()),
                        );
                      },
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _toggleCitySelector();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: buttonColor, // Используем вычисленный цвет
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.location_on,
                            color: Color(0xFFFFFFFF),
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                if (_showCitySelector) ...[
                  // Убираем GestureDetector отсюда, так как он не нужен
                  CitySelectorWidget(
                    cities: citiesToUse,
                    onCitySelected: _handleCitySelected,
                    onClose: _toggleCitySelector,
                    onClearCity: _handleClearCity,
                    initialCity: _currentCity,
                  ),
                  SizedBox(height: 10),
                ],

                SizedBox(height: 20),

                if (_currentCity.isEmpty)
                  ...provider.advertisement
                      .map(
                        (ad) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: StrangersEmployerAdvertisement(ad: ad),
                        ),
                      )
                      .toList()
                else
                  ...provider.filteredAdv
                      .map(
                        (ad) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: FilterAdvertisement(ad: ad),
                        ),
                      )
                      .toList(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: EmployerBottomButtons(
            currentIndex: 0,
            onTabSelected: (index) {
              if (index == 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyAdvertisementPage(),
                  ),
                );
              }
              if (index == 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmployerProfilePage(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
