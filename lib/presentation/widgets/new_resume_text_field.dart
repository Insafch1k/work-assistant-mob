import 'package:flutter/material.dart';

class NewResumeTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final double minHeight;
  final double maxHeight;
  final bool? isBorder;
  final EdgeInsetsGeometry? padding;
  final String? hintText;

  const NewResumeTextField({
    Key? key,
    this.onChanged,
    this.controller,
    this.minHeight = 40.0,
    this.maxHeight = 240.0,
    this.isBorder,
    this.padding,
    this.hintText,
  }) : super(key: key);

  @override
  State<NewResumeTextField> createState() => _NewResumeTextFieldState();
}

class _NewResumeTextFieldState extends State<NewResumeTextField> {
  late TextEditingController _controller;
  final GlobalKey _textFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_updateHeight);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateHeight);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _updateHeight() {
    if (_textFieldKey.currentContext == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final renderBox =
          _textFieldKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      final newHeight = renderBox.size.height;
      final minHeight = widget.minHeight;
      final maxHeight = widget.maxHeight;

      if (newHeight > minHeight && newHeight < maxHeight) {
        setState(() {});
      }
    });
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
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: IntrinsicHeight(
            child: TextField(
              key: _textFieldKey,
              controller: _controller,
              onChanged: widget.onChanged,
              maxLines: null,
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
