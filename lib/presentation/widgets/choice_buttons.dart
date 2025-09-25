import 'package:flutter/material.dart';

class ChoiceButtons extends StatefulWidget {
  final String selected;
  final ValueChanged<String> onSelected;
  final bool showChoice;
  final ValueChanged<bool> onShowChoice;

  const ChoiceButtons({
    required this.selected,
    required this.onSelected,
    required this.showChoice,
    required this.onShowChoice,
    super.key,
  });

  @override
  State<ChoiceButtons> createState() => _ChoiceButtonsState();
}

class _ChoiceButtonsState extends State<ChoiceButtons>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -0.4),
      end: Offset(0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.showChoice) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant ChoiceButtons oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.showChoice != oldWidget.showChoice) {
      if (widget.showChoice) {
        _slideAnimation = Tween<Offset>(
          begin: const Offset(0, -0.4),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        _controller.forward();
      } else {
        _slideAnimation = Tween<Offset>(
          begin: const Offset(0, 0),
          end: const Offset(0, -0.4),
        ).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
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
      opacity: _opacityAnimation,
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFF35383F),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      widget.selected == "Я соискатель"
                                          ? Color(0xFF21242B)
                                          : Color(0xFF35383F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 0,
                                  padding: const EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                ),
                                onPressed: () {
                                  widget.onSelected("Я соискатель");
                                  widget.onShowChoice(false);
                                },
                                child: const Text(
                                  "Я соискатель",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      widget.selected == "Я работодатель"
                                          ? Color(0xFF21242B)
                                          : Color(0xFF35383F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 0,
                                  padding: const EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                ),
                                onPressed: () {
                                  widget.onSelected("Я работодатель");
                                  widget.onShowChoice(false);
                                },
                                child: const Text(
                                  "Я работодатель",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 60,
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: const Color(0xFF6849FF),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //       alignment: Alignment.center,
                    //     ),
                    //     onPressed: () {},
                    //     child: Text(
                    //       "Авторизоваться",
                    //       style: TextStyle(
                    //         fontFamily: "Inter",
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w500,
                    //         color: Color(0xFFFFFFFF),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
