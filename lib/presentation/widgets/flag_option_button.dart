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
    // Renk belirleme
    Color backgroundColor;
    Color textColor;
    IconData? icon;
    
    if (!isDisabled) {
      backgroundColor = Colors.white;
      textColor = Colors.black87;
      icon = null;
    } else if (isCorrect) {
      backgroundColor = Colors.green[100]!;
      textColor = Colors.green[800]!;
      icon = Icons.check_circle;
    } else if (isSelected) {
      backgroundColor = Colors.red[100]!;
      textColor = Colors.red[800]!;
      icon = Icons.cancel;
    } else {
      backgroundColor = Colors.grey[100]!;
      textColor = Colors.grey[800]!;
      icon = null;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: isDisabled ? 0 : 4,
        ),
        onPressed: isDisabled ? null : onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (icon != null)
              Icon(
                icon,
                color: textColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
