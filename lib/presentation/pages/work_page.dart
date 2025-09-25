import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_assistent_mob/presentation/pages/favorite_page.dart';
import 'package:work_assistent_mob/presentation/pages/filter_page.dart';
import 'package:work_assistent_mob/presentation/pages/profile_page.dart';
import 'package:work_assistent_mob/presentation/pages/view_history_page.dart';
import 'package:work_assistent_mob/presentation/providers/advertisement_provider.dart';
import 'package:work_assistent_mob/presentation/widgets/advertisement.dart';
import 'package:work_assistent_mob/presentation/widgets/bottom_buttons.dart';
import 'package:work_assistent_mob/presentation/widgets/city_selection_widget.dart';
import 'package:work_assistent_mob/presentation/widgets/filter_button.dart';
import 'package:work_assistent_mob/presentation/widgets/filtered_advertisement.dart';
import 'package:work_assistent_mob/presentation/widgets/searchbar.dart';

class WorkPage extends StatefulWidget {
  final String city;
  const WorkPage({super.key, this.city = ''});

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  bool _showCitySelector = false;
  late String _currentCity; 

  @override
  void initState() {
    super.initState();
    _currentCity = widget.city;
    _loadAdvertisements();
  }

  @override
  void didUpdateWidget(WorkPage oldWidget) {
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
    final provider = context.read<AdvertisementProvider>();
    
    print('Все города в провайдере: ${provider.cities}');
    print('Все объявления: ${provider.advertisement.length}');
    
    // Посмотрите города в объявлениях
    for (var ad in provider.advertisement) {
      print('Объявление: ${ad.title}, Город: ${ad.city}');
    }
    
    if (_currentCity.isNotEmpty) {
      provider.fetchFilteredAdvertisements(_currentCity);
      print('Фильтруем по городу: $_currentCity');
    } else {
      provider.fetchAdvertisements();
      print('Загружаем все объявления');
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
    
    final citiesToUse = provider.cities.isNotEmpty 
        ? provider.cities 
        : ['нету','городов','в списке'];

    // Определяем цвет кнопки в зависимости от выбранного города
    final buttonColor = _currentCity.isNotEmpty 
        ? Color(0xFF6849FF) // Фиолетовый, если город выбран
        : (_showCitySelector ? Color(0xFF6849FF) : Color(0xFF35383F)); // Серый или фиолетовый при активации

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
                    Flexible(flex: 3, child: MySearchBar(onChanged: (value) {})),
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
                          child: Advertisement(ad: ad),
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
          child: BottomButtons(
            currentIndex: 0,
            onTabSelected: (index) {
              if (index == 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritePage()),
                );
              }
              if (index == 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ViewHistoryPage()),
                );
              }
              if (index == 3) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}