import 'package:flutter/material.dart';

class AuthorizationButton extends StatefulWidget {
  final bool visible;
  final VoidCallback onPressed;

  const AuthorizationButton({
    Key? key,
    required this.visible,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<AuthorizationButton> createState() => _AuthorizationButtonState();
}

class _AuthorizationButtonState extends State<AuthorizationButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.visible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant AuthorizationButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible != oldWidget.visible) {
      if (widget.visible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6849FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.center,
          ),
          onPressed: widget.onPressed,
          child: const Text(
            "Авторизоваться",
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}
