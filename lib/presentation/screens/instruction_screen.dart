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
    final isLandscape = size.width > size.height;
    final maxWidth = isLandscape ? size.width * 0.5 : size.width * 0.9;

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? const Color(0xFF0F1020)
          : const Color(0xFFFFFFFF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: maxWidth,
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isLandscape
                          ? size.width * 0.08
                          : size.width * 0.05,
                      vertical: isLandscape
                          ? size.height * 0.05
                          : size.width * 0.05,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Title
                        Text(
                          'Instruction',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: isLandscape
                                ? size.height * 0.08
                                : size.width * 0.08,
                            fontWeight: FontWeight.w800,
                            color: themeProvider.isDarkMode
                                ? const Color(0xFFE8ECF5)
                                : const Color(0xFF1A1B4B),
                          ),
                        ),

                        SizedBox(
                          height: isLandscape
                              ? size.height * 0.03
                              : size.height * 0.04,
                        ),

                        // Instruction Card
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(
                            isLandscape
                                ? size.height * 0.04
                                : size.width * 0.05,
                          ),
                          decoration: BoxDecoration(
                            color: themeProvider.isDarkMode
                                ? const Color(0xFF1A1B3D)
                                : const Color(0xFFF8F9FF),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: themeProvider.isDarkMode
                                  ? const Color(0xFF1A1B3D)
                                  : const Color(
                                      0xFF1A1B4B,
                                    ).withValues(alpha: 0.1),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildInstructionItem(
                                context,
                                size,
                                themeProvider,
                                isLandscape,
                                '1. There are 5 quiz questions in one play.',
                              ),
                              SizedBox(
                                height: isLandscape
                                    ? size.height * 0.02
                                    : size.height * 0.015,
                              ),
                              _buildInstructionItem(
                                context,
                                size,
                                themeProvider,
                                isLandscape,
                                '2. You will be given 4 answer choices, choose the correct one.',
                              ),
                              SizedBox(
                                height: isLandscape
                                    ? size.height * 0.02
                                    : size.height * 0.015,
                              ),
                              _buildInstructionItem(
                                context,
                                size,
                                themeProvider,
                                isLandscape,
                                '3. Each question will be given 30 seconds to answer.',
                              ),
                              SizedBox(
                                height: isLandscape
                                    ? size.height * 0.02
                                    : size.height * 0.015,
                              ),
                              _buildInstructionItem(
                                context,
                                size,
                                themeProvider,
                                isLandscape,
                                '4. GLHF!',
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: isLandscape
                              ? size.height * 0.03
                              : size.height * 0.04,
                        ),

                        // Arrow Button
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              // Initialize quiz and navigate to quiz screen
                              final quizProvider = Provider.of<QuizProvider>(
                                context,
                                listen: false,
                              );
                              quizProvider.initializeQuiz(questionCount: 5);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const QuizScreen(),
                                ),
                              );
                            },
                            child: Container(
                              width: isLandscape
                                  ? size.height * 0.12
                                  : size.width * 0.15,
                              height: isLandscape
                                  ? size.height * 0.12
                                  : size.width * 0.15,
                              decoration: BoxDecoration(
                                color: themeProvider.isDarkMode
                                    ? const Color(0xFFFF7BA8)
                                    : const Color(0xFFFF6B9D),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: isLandscape
                                    ? size.height * 0.06
                                    : size.width * 0.08,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInstructionItem(
    BuildContext context,
    Size size,
    ThemeProvider themeProvider,
    bool isLandscape,
    String text,
  ) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: isLandscape ? size.height * 0.045 : size.width * 0.04,
        fontWeight: FontWeight.w400,
        color: themeProvider.isDarkMode
            ? const Color(0xFFE8ECF5).withValues(alpha: 0.8)
            : const Color(0xFF1A1B4B).withValues(alpha: 0.7),
        height: 1.5,
      ),
    );
  }
}
