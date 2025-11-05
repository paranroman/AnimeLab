import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String text;
  final bool isDarkMode;

  const InfoCard({super.key, required this.text, this.isDarkMode = false});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(size.width * 0.05),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1A1B3D) : const Color(0xFFF8F9FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode
              ? const Color(0xFF1A1B3D)
              : const Color(0xFF1A1B4B).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: size.width * 0.038,
          fontWeight: FontWeight.w400,
          color: isDarkMode
              ? const Color(0xFFE8ECF5).withOpacity(0.8)
              : const Color(0xFF1A1B4B).withOpacity(0.7),
          height: 1.5,
        ),
      ),
    );
  }
}
