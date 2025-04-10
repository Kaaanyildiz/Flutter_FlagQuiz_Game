import 'package:flutter/material.dart';

class FlagOptionButton extends StatelessWidget {
  final String text;
  final bool isCorrect;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback onTap;

  const FlagOptionButton({
    super.key,
    required this.text,
    required this.isCorrect,
    required this.isSelected,
    required this.isDisabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    if (!isDisabled) {
      color = Colors.blueGrey[50]!;
    } else if (isCorrect) {
      color = Colors.green;
    } else if (isSelected) {
      color = Colors.red;
    } else {
      color = Colors.grey[300]!;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: isDisabled ? null : onTap,
        child: Text(text),
      ),
    );
  }
}
