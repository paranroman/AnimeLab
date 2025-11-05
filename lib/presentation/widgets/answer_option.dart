import 'package:flutter/material.dart';

class AnswerOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;
  final bool isDisabled;
  final VoidCallback onTap;
  final bool isDarkMode;

  const AnswerOption({
    super.key,
    required this.text,
    required this.onTap,
    this.isSelected = false,
    this.isCorrect = false,
    this.isWrong = false,
    this.isDisabled = false,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Color getBackgroundColor() {
      if (isCorrect) return const Color(0xFF4CAF50);
      if (isWrong) return const Color(0xFFFF4757);
      if (isDisabled) {
        return isDarkMode ? const Color(0xFF1A1B3D) : const Color(0xFFF8F9FF);
      }
      return isDarkMode ? const Color(0xFF1A1B3D) : const Color(0xFFF8F9FF);
    }

    Color getTextColor() {
      if (isCorrect || isWrong) return Colors.white;
      if (isDisabled) {
        return isDarkMode
            ? const Color(0xFFE8ECF5).withOpacity(0.4)
            : const Color(0xFF1A1B4B).withOpacity(0.4);
      }
      return isDarkMode ? const Color(0xFFE8ECF5) : const Color(0xFF1A1B4B);
    }

    Color getBorderColor() {
      if (isCorrect) return const Color(0xFF4CAF50);
      if (isWrong) return const Color(0xFFFF4757);
      if (isDisabled) {
        return isDarkMode
            ? const Color(0xFF1A1B3D)
            : const Color(0xFF1A1B4B).withOpacity(0.1);
      }
      return isDarkMode
          ? const Color(0xFF1A1B3D)
          : const Color(0xFF1A1B4B).withOpacity(0.1);
    }

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.018,
        ),
        decoration: BoxDecoration(
          color: getBackgroundColor(),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: getBorderColor(), width: 1.5),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.w400,
            color: getTextColor(),
          ),
        ),
      ),
    );
  }
}
