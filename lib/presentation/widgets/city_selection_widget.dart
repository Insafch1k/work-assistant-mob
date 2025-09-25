import 'package:flutter/material.dart';

class CitySelectorWidget extends StatefulWidget {
  final List<String> cities;
  final Function(String) onCitySelected;
  final Function() onClose;
  final Function() onClearCity; // Добавляем callback для очистки
  final String? initialCity;

  const CitySelectorWidget({
    super.key,
    required this.cities,
    required this.onCitySelected,
    required this.onClose,
    required this.onClearCity, // Обязательный параметр
    this.initialCity,
  });

  @override
  State<CitySelectorWidget> createState() => _CitySelectorWidgetState();
}

class _CitySelectorWidgetState extends State<CitySelectorWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredCities = [];
  String? _selectedCity;
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _filteredCities = widget.cities;
    _selectedCity = widget.initialCity;
    _showClearButton =
        widget.initialCity != null && widget.initialCity!.isNotEmpty;

    if (widget.initialCity != null) {
      _searchController.text = widget.initialCity!;
    }
  }

  void _filterCities(String searchText) {
    if (searchText.isEmpty) {
      setState(() {
        _filteredCities = widget.cities;
      });
      return;
    }

    final searchLower = searchText.toLowerCase();
    setState(() {
      _filteredCities =
          widget.cities
              .where((city) => city.toLowerCase().contains(searchLower))
              .toList();
    });
  }

  void _selectCity(String city) {
    setState(() {
      _selectedCity = city;
      _searchController.text = city;
      _showClearButton = true;
    });
    widget.onCitySelected(city);
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _filteredCities = widget.cities;
    });
  }

  void _clearAll() {
    setState(() {
      _selectedCity = null;
      _searchController.clear();
      _filteredCities = widget.cities;
      _showClearButton = false;
    });

    widget.onClearCity();

    // Двойная гарантия - ждем и кадр и небольшую задержку
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 50), () {
        widget.onClose();
        print(_filteredCities);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF35383F),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF6849FF), width: 1),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 15,
                    right: 15,
                    bottom: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Выберите город",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _searchController,
                        onChanged: _filterCities,
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 14,
                          fontFamily: "Inter",
                        ),
                        decoration: InputDecoration(
                          hintText: "Поиск города...",
                          hintStyle: const TextStyle(color: Color(0xFF888888)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF6849FF),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF6849FF),
                              width: 2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 5,
                          ),
                          constraints: BoxConstraints(maxHeight: 50),
                          isDense: true,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 20,
                          ),
                          suffixIcon:
                              _searchController.text.isNotEmpty
                                  ? IconButton(
                                    icon: const Icon(Icons.clear, size: 18),
                                    color: Colors.white,
                                    onPressed: _clearSearch,
                                  )
                                  : null,
                        ),
                      ),
                      const SizedBox(height: 7),

                      // Список городов
                      if (_filteredCities.isNotEmpty)
                        Container(
                          constraints: const BoxConstraints(maxHeight: 105),
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: _filteredCities.length,
                            itemBuilder: (context, index) {
                              final city = _filteredCities[index];
                              return Column(
                                children: [
                                  ListTile(
                                    dense: true,
                                    visualDensity: const VisualDensity(
                                      vertical: -4,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 0,
                                    ),
                                    minVerticalPadding: 5,
                                    title: Text(
                                      city,
                                      style: const TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: "Inter",
                                        fontSize: 14,
                                      ),
                                    ),
                                    onTap: () => _selectCity(city),
                                  ),
                                  if (index < _filteredCities.length - 1)
                                    const Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Color(0xFF888888),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),

                      // Кнопка "Очистить" сразу под списком
                      if (_showClearButton)
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            const Divider(height: 1, color: Color(0xFF888888)),
                            ListTile(
                              dense: true,
                              visualDensity: const VisualDensity(vertical: -4),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 0,
                              ),
                              minVerticalPadding: 1,
                              title: const Text(
                                'Очистить',
                                style: TextStyle(
                                  color: Color(0XFFF56B68),
                                  fontFamily: "Inter",
                                  fontSize: 14,
                                ),
                              ),
                              onTap: _clearAll,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                Positioned(
                  top: 4,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                    onPressed: widget.onClose,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
