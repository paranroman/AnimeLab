import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool isDarkMode;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.4,
      height: size.height * 0.06,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? (isDarkMode ? const Color(0xFFFF7BA8) : const Color(0xFFFF6B9D))
              : const Color(0xFFE8EEFF),
          disabledBackgroundColor: const Color(0xFFE8EEFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: size.width * 0.045,
            fontWeight: FontWeight.w700,
            color: isEnabled ? Colors.white : const Color(0xFFA8B2D1),
          ),
        ),
      ),
    );
  }
}
