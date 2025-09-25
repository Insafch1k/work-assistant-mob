import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final double minHeight;
  final double maxHeight;
  final bool? isBorder;
  final EdgeInsetsGeometry? padding;
  final String? hintText;
  final int? maxLines;
  final bool numbersOnly;
  final String? errorText;
  final bool dateFormat;
  final bool timeFormat;

  const CustomTextField({
    Key? key,
    this.onChanged,
    this.controller,
    this.minHeight = 40.0,
    this.maxHeight = 240.0,
    this.isBorder,
    this.padding,
    this.hintText,
    this.maxLines = 1,
    this.numbersOnly = false,
    this.errorText,
    this.dateFormat = false,
    this.timeFormat = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  final int _maxDateLength = 10;
  final int _maxTimeLength = 5;
  bool _isFormatting = false; // Флаг для предотвращения рекурсии

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_formatInput);
  }

  @override
  void dispose() {
    _controller.removeListener(_formatInput);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _formatInput() {
    if (_isFormatting) return; // Предотвращаем рекурсию

    if (widget.timeFormat && _controller.text.isNotEmpty) {
      _isFormatting = true;
      final text = _controller.text.replaceAll(RegExp(r'[^0-9]'), '');
      final formatted = _formatTime(text);

      if (_controller.text != formatted) {
        _controller.value = _controller.value.copyWith(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
      _isFormatting = false;
    } else if (widget.dateFormat && _controller.text.isNotEmpty) {
      _isFormatting = true;
      final text = _controller.text.replaceAll(RegExp(r'[^0-9]'), '');
      final formatted = _formatDate(text);

      if (_controller.text != formatted) {
        _controller.value = _controller.value.copyWith(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
      _isFormatting = false;
    } else if (widget.numbersOnly && _controller.text.isNotEmpty) {
      _isFormatting = true;
      final text = _controller.text.replaceAll(RegExp(r'[^0-9]'), '');
      if (_controller.text != text) {
        _controller.value = _controller.value.copyWith(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        );
      }
      _isFormatting = false;
    }
  }

  String _formatDate(String digits) {
    if (digits.isEmpty) return '';

    if (digits.length > 8) digits = digits.substring(0, 8);

    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      if (i == 2 || i == 4) {
        buffer.write('.');
      }
      buffer.write(digits[i]);
    }

    return buffer.toString();
  }

  String _formatTime(String digits) {
    if (digits.isEmpty) return '';

    if (digits.length > 4) digits = digits.substring(0, 4);

    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      if (i == 2) {
        buffer.write(':');
      }
      buffer.write(digits[i]);
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: widget.minHeight,
          maxHeight: widget.maxHeight,
        ),
        child: TextField(
          controller: _controller,
          onChanged: (value) {
            // Вызываем форматирование при каждом изменении
            if (!_isFormatting) {
              _formatInput();
            }
            widget.onChanged?.call(value);
          },
          maxLines: widget.maxLines,
          maxLength:
              widget.timeFormat
                  ? _maxTimeLength
                  : widget.dateFormat
                  ? _maxDateLength
                  : null,
          keyboardType:
              (widget.numbersOnly || widget.dateFormat || widget.timeFormat)
                  ? TextInputType.number
                  : TextInputType.multiline,
          inputFormatters:
              (widget.numbersOnly || widget.dateFormat || widget.timeFormat)
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : [],
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
            height: 1.25,
            color: Color(0xFFFFFFFF),
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              color: Color(0xFF71747B),
            ),
            border: _buildBorder(),
            enabledBorder: _buildBorder(),
            focusedBorder: _buildBorder(),
            filled: true,
            fillColor: const Color(0xFF35383F),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 11.0,
            ),
            errorText: widget.errorText,
            counterText: '',
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide:
          widget.isBorder == true
              ? const BorderSide(color: Color(0xFFFFFFFF), width: 1.0)
              : BorderSide.none,
    );
  }
}
