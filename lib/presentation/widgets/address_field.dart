import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:work_assistent_mob/domain/entities/address_suggestion.dart';

class AddressAutocompleteField extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController cityController;
  final String hintText;
  final ValueChanged<Map<String, String>>? onAddressSelected;
  final String apiKey;
  final String secretKey;
  final bool onlyCity;

  const AddressAutocompleteField({
    Key? key,
    required this.controller,
    required this.cityController,
    required this.hintText,
    required this.apiKey,
    required this.secretKey,
    this.onAddressSelected,
    this.onlyCity = false
  }) : super(key: key);

  @override
  _AddressAutocompleteFieldState createState() =>
      _AddressAutocompleteFieldState();
}

class _AddressAutocompleteFieldState extends State<AddressAutocompleteField> {
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();

  List<AddressSuggestion> _suggestions = [];
  OverlayEntry? _overlayEntry;
  bool _hasResults = false;

  Timer? _debounceTimer;
  String _lastQuery = '';
  String _currentText = '';
  int _lastTextLength = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChange);
    _currentText = widget.controller.text;
    _lastTextLength = _currentText.length;
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    widget.controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _removeOverlay();
    }
  }

  void _onTextChanged() {
    final String newText = widget.controller.text;
    final int newLength = newText.length;

    final bool isInput = newLength > _lastTextLength;
    final bool isDeletion = newLength < _lastTextLength;

    _currentText = newText;
    _lastTextLength = newLength;

    _debounceTimer?.cancel();

    if (newText.length > 2) {
      _showMatchesImmediately(newText);

      _debounceTimer = Timer(const Duration(milliseconds: 200), () {
        if (newText != _lastQuery) {
          _lastQuery = newText;
          _fetchSuggestions(newText);
        }
      });
    } else {
      _removeOverlay();
      setState(() {
        _suggestions = [];
        _hasResults = false;
        _lastQuery = '';
      });
    }

    if (isInput) {
      print('Пользователь ввел новый символ. Текущий текст: "$newText"');
    } else if (isDeletion) {
      print('Пользователь стер символ. Текущий текст: "$newText"');
    }
  }

  void _showMatchesImmediately(String query) {
    if (_suggestions.isNotEmpty && query.isNotEmpty) {
      final filteredSuggestions = _suggestions
          .where((suggestion) =>
              suggestion.value.toLowerCase().contains(query.toLowerCase()))
          .toList();

      final bool hasMatches = filteredSuggestions.isNotEmpty;

      print(
        'Текущий текст "$query" ${hasMatches ? 'СОВПАДАЕТ' : 'НЕ СОВПАДАЕТ'} с загруженных адресов',
      );

      setState(() {
        _suggestions = filteredSuggestions;
        _hasResults = hasMatches;
      });

      if (_hasResults) {
        _showOverlay();
      } else {
        _removeOverlay();
      }
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    if (_overlayEntry != null || _suggestions.isEmpty) return;

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          _removeOverlay();
          _focusNode.unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                width: size.width,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: Offset(0, size.height + 4),
                  child: MouseRegion(
                    onEnter: (_) {},
                    child: _buildSuggestionsList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Future<void> _fetchSuggestions(String query) async {
    if (query.length < 3) return;

    print('Выполняем запрос для: "$query"');

    try {
      final suggestions = await _suggestAddress(query);

      if (widget.controller.text != query) {
        print('Запрос устарел, текущий текст: "${widget.controller.text}"');
        return;
      }

      // Фильтруем только города если onlyCity = true
      final filteredSuggestions = widget.onlyCity
          ? suggestions.where((suggestion) => suggestion.isCityOnly()).toList()
          : suggestions.toList();

      final limitedSuggestions = filteredSuggestions.take(5).toList();

      setState(() {
        _suggestions = limitedSuggestions;
        _hasResults = limitedSuggestions.isNotEmpty;
      });

      print('Найдено ${limitedSuggestions.length} совпадений для "$query"');

      if (_suggestions.isNotEmpty) {
        _showOverlay();
      } else {
        _removeOverlay();
      }
    } catch (e) {
      setState(() {
        _suggestions = [];
        _hasResults = false;
      });
      _removeOverlay();
      print('Ошибка при поиске адресов: $e');
    }
  }

  Future<List<AddressSuggestion>> _suggestAddress(String query) async {
    const String _baseUrl = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs';

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token ${widget.apiKey}',
      'X-Secret': widget.secretKey,
    };

    // Модифицируем запрос для поиска только городов если onlyCity = true
    final Map<String, dynamic> requestBody = {
      'query': query,
      'count': 10,
    };

    if (widget.onlyCity) {
      requestBody['from_bound'] = {'value': 'city'};
      requestBody['to_bound'] = {'value': 'city'};
      requestBody['locations'] = [
        {'country': 'Россия'}
      ];
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/suggest/address'),
      headers: headers,
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final suggestions = List<Map<String, dynamic>>.from(data['suggestions'] ?? []);
      return suggestions
          .map((suggestion) => AddressSuggestion.fromJson(suggestion))
          .toList();
    } else {
      throw Exception('Ошибка DaData: ${response.statusCode}');
    }
  }

  void _selectAddress(AddressSuggestion suggestion) {
    if (widget.onlyCity) {
      // Для режима только города используем название города как адрес
      widget.controller.text = suggestion.city;
      widget.cityController.text = suggestion.city;
      
      widget.onAddressSelected?.call({
        'address': suggestion.city, // Город как адрес
        'city': suggestion.city,
      });

      print('Выбран город: "${suggestion.city}"');
    } else {
      // Обычный режим с полным адресом
      widget.controller.text = suggestion.value;
      widget.cityController.text = suggestion.city;
      
      widget.onAddressSelected?.call({
        'address': suggestion.value,
        'city': suggestion.city,
      });

      print('Выбран полный адрес: "${suggestion.value}"');
      print('Город: "${suggestion.city}"');
    }

    _removeOverlay();
    _focusNode.unfocus();
    _lastQuery = widget.controller.text;
    _currentText = widget.controller.text;
    _lastTextLength = widget.controller.text.length;
  }

  Widget _buildSuggestionsList() {
    if (!_hasResults && _suggestions.isEmpty) {
      return Material(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF35383F),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            widget.onlyCity ? 'Город не найден' : 'Неизвестный адрес',
            style: const TextStyle(
              color: Color(0xFFFF6B6B),
              fontSize: 14,
              fontFamily: 'Inter',
            ),
          ),
        ),
      );
    }

    if (_suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF35383F),
          borderRadius: BorderRadius.circular(15),
        ),
        constraints: const BoxConstraints(maxHeight: 250),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF35383F),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Text(
                widget.onlyCity 
                  ? 'Выберите город или продолжите ввод'
                  : 'Выберите вариант или продолжите ввод',
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = _suggestions[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: index < _suggestions.length - 1
                          ? const Border(
                              bottom: BorderSide(
                                color: Color(0xFF2A2D33),
                                width: 1,
                              ),
                            )
                          : null,
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      title: Text(
                        widget.onlyCity ? suggestion.city : suggestion.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                      onTap: () => _selectAddress(suggestion),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          height: 1.25,
          color: Color(0xFFFFFFFF),
        ),
        decoration: InputDecoration(
          hintText: widget.onlyCity ? 'Введите название города' : widget.hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
            color: Color(0xFF71747B),
          ),
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
            borderSide: const BorderSide(color: Color(0xFFFFFFFF), width: 1.0),
          ),
          filled: true,
          fillColor: const Color(0xFF35383F),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 11.0,
          ),
        ),
      ),
    );
  }
}