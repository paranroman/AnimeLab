import 'package:flutter/material.dart';

class AppTextStyles {
  static const String fontFamily = 'Poppins';
  
  // Heading/Titles - ExtraBold (28-32px)
  static TextStyle heading(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w800,
    fontSize: 28,
    color: color,
  );
  
  // Section Headers - Bold (20-24px)
  static TextStyle sectionHeader(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: color,
  );
  
  // Quiz Questions - SemiBold (18-20px)
  static TextStyle quizQuestion(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: color,
  );
  
  // Answer Options - Regular (16-18px)
  static TextStyle answerOption(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: color,
  );
  
  // Buttons - Bold (16-18px)
  static TextStyle button(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: color,
  );
  
  // Small Text & Labels - SemiBold (12-14px)
  static TextStyle smallText(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: color,
  );
  
  // Numbers & Scores - ExtraBold (32-48px)
  static TextStyle score(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w800,
    fontSize: 40,
    color: color,
  );
  
  // Body Text - Regular (14-16px)
  static TextStyle bodyText(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: color,
  );
}