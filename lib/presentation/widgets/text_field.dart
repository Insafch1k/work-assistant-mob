import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final double minHeight;
  final double maxHeight;
  final bool? isBorder;
  final EdgeInsetsGeometry? padding;
  final String? hintText;
  final int? maxLines;

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
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
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
          onChanged: widget.onChanged,
          maxLines: widget.maxLines,
          keyboardType: TextInputType.multiline,
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
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: widget.isBorder == true
          ? const BorderSide(color: Color(0xFFFFFFFF), width: 1.0)
          : BorderSide.none,
    );
  }
}