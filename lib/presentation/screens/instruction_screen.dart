import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/theme_provider.dart';
import '../../core/providers/quiz_provider.dart';
import 'quiz_screen.dart';

class InstructionScreen extends StatelessWidget {
  const InstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? const Color(0xFF0F1020)
          : const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              Text(
                'Instruction',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: size.width * 0.08,
                  fontWeight: FontWeight.w800,
                  color: themeProvider.isDarkMode
                      ? const Color(0xFFE8ECF5)
                      : const Color(0xFF1A1B4B),
                ),
              ),

              SizedBox(height: size.height * 0.04),

              // Instruction Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(size.width * 0.05),
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? const Color(0xFF1A1B3D)
                      : const Color(0xFFF8F9FF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: themeProvider.isDarkMode
                        ? const Color(0xFF1A1B3D)
                        : const Color(0xFF1A1B4B).withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInstructionItem(
                      context,
                      size,
                      themeProvider,
                      '1. There are 2 quiz questions in one play.',
                    ),
                    SizedBox(height: size.height * 0.015),
                    _buildInstructionItem(
                      context,
                      size,
                      themeProvider,
                      '2. You will be given 4 answer choices, choose the correct one.',
                    ),
                    SizedBox(height: size.height * 0.015),
                    _buildInstructionItem(
                      context,
                      size,
                      themeProvider,
                      '3. Each question will be given 30 seconds to answer.',
                    ),
                    SizedBox(height: size.height * 0.015),
                    _buildInstructionItem(
                      context,
                      size,
                      themeProvider,
                      '4. GLHF!',
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.04),

              // Arrow Button
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // Initialize quiz and navigate to quiz screen
                    final quizProvider =
                        Provider.of<QuizProvider>(context, listen: false);
                    quizProvider.initializeQuiz(questionCount: 5);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: size.width * 0.15,
                    height: size.width * 0.15,
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode
                          ? const Color(0xFFFF7BA8)
                          : const Color(0xFFFF6B9D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: size.width * 0.08,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionItem(
    BuildContext context,
    Size size,
    ThemeProvider themeProvider,
    String text,
  ) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: size.width * 0.038,
        fontWeight: FontWeight.w400,
        color: themeProvider.isDarkMode
            ? const Color(0xFFE8ECF5).withOpacity(0.8)
            : const Color(0xFF1A1B4B).withOpacity(0.7),
        height: 1.5,
      ),
    );
  }
}
