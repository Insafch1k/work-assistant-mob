import 'package:flutter/material.dart';
import 'package:work_assistent_mob/presentation/widgets/text_field.dart';

class DoubleTextField extends StatelessWidget {
  final TextEditingController firstController;
  final TextEditingController secondController;
  final String firstHintText;
  final String secondHintText;
  final double spacing;

  const DoubleTextField({
    Key? key,
    required this.firstController,
    required this.secondController,
    required this.firstHintText,
    required this.secondHintText,
    this.spacing = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: firstController,
            hintText: firstHintText,
            timeFormat: true,
          ),
        ),
        SizedBox(width: spacing),
        Expanded(
          child: CustomTextField(
            controller: secondController,
            hintText: secondHintText,
            timeFormat: true,
          ),
        ),
      ],
    );
  }
}