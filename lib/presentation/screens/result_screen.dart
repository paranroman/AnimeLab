import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/theme_provider.dart';
import '../../core/providers/quiz_provider.dart';
import 'quiz_screen.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;

    // Capture values to prevent issues during navigation
    final score = quizProvider.score;
    final totalQuestions = quizProvider.totalQuestions;
    final userName = quizProvider.userName;
    final totalTime = quizProvider.totalTime;
    
    final scorePercentage = totalQuestions > 0
        ? (score / totalQuestions * 100).round()
        : 0;

    return WillPopScope(
      onWillPop: () async {
        // Prevent back button, user must use provided buttons
        return false;
      },
      child: Scaffold(
        backgroundColor: themeProvider.isDarkMode
            ? const Color(0xFF0F1020)
            : const Color(0xFFFFFFFF),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(size.width * 0.05),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),

                // Congratulations Image
                Image.asset(
                  'assets/images/congratulations.png',
                  width: size.width * 0.5,
                  height: size.width * 0.5,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.emoji_events,
                      size: size.width * 0.3,
                      color: themeProvider.isDarkMode
                          ? const Color(0xFFFF7BA8)
                          : const Color(0xFFFF6B9D),
                    );
                  },
                ),

                SizedBox(height: size.height * 0.02),

                // Title
                Text(
                  'Quiz Completed!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: size.width * 0.08,
                    fontWeight: FontWeight.w800,
                    color: themeProvider.isDarkMode
                        ? const Color(0xFFE8ECF5)
                        : const Color(0xFF1A1B4B),
                  ),
                ),

                SizedBox(height: size.height * 0.01),

                // User name - Enhanced display
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w400,
                      color: themeProvider.isDarkMode
                          ? const Color(0xFFE8ECF5).withOpacity(0.7)
                          : const Color(0xFF1A1B4B).withOpacity(0.7),
                    ),
                    children: [
                      const TextSpan(text: 'Great job, '),
                      TextSpan(
                        text: userName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: themeProvider.isDarkMode
                              ? const Color(0xFFFF7BA8)
                              : const Color(0xFFFF6B9D),
                        ),
                      ),
                      const TextSpan(text: '!'),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                // Score Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(size.width * 0.06),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? const Color(0xFF1A1B3D)
                        : const Color(0xFFF8F9FF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: themeProvider.isDarkMode
                          ? const Color(0xFF1A1B3D)
                          : const Color(0xFF1A1B4B).withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Score title
                      Text(
                        'Your Score',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w700,
                          color: themeProvider.isDarkMode
                              ? const Color(0xFFE8ECF5)
                              : const Color(0xFF1A1B4B),
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),

                      // Score number
                      Text(
                        '$score/$totalQuestions',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: size.width * 0.15,
                          fontWeight: FontWeight.w800,
                          color: themeProvider.isDarkMode
                              ? const Color(0xFFFF7BA8)
                              : const Color(0xFFFF6B9D),
                        ),
                      ),

                      SizedBox(height: size.height * 0.01),

                      // Percentage
                      Text(
                        '$scorePercentage% Correct',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.w600,
                          color: themeProvider.isDarkMode
                              ? const Color(0xFFE8ECF5).withOpacity(0.7)
                              : const Color(0xFF1A1B4B).withOpacity(0.7),
                        ),
                      ),

                      SizedBox(height: size.height * 0.03),

                      // Divider
                      Divider(
                        color: themeProvider.isDarkMode
                            ? const Color(0xFFE8ECF5).withOpacity(0.1)
                            : const Color(0xFF1A1B4B).withOpacity(0.1),
                        thickness: 1,
                      ),

                      SizedBox(height: size.height * 0.02),

                      // Time taken
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: themeProvider.isDarkMode
                                ? const Color(0xFFFFBD6E)
                                : const Color(0xFFFFB366),
                            size: size.width * 0.06,
                          ),
                          SizedBox(width: size.width * 0.02),
                          Text(
                            'Time: ${_formatTime(totalTime)}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: size.width * 0.045,
                              fontWeight: FontWeight.w600,
                              color: themeProvider.isDarkMode
                                  ? const Color(0xFFE8ECF5)
                                  : const Color(0xFF1A1B4B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                // Try Again Button
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      // Reset and start new quiz
                      quizProvider.initializeQuiz(questionCount: 5);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeProvider.isDarkMode
                          ? const Color(0xFF5DB8FF)
                          : const Color(0xFF70C7FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Try Again',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.015),

                // Back to Home Button
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.06,
                  child: OutlinedButton(
                    onPressed: () {
                      // Don't reset the user name, only reset quiz data
                      quizProvider.resetQuiz();
                      quizProvider.setUserName(userName);
                      
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: themeProvider.isDarkMode
                            ? const Color(0xFFE8ECF5).withOpacity(0.3)
                            : const Color(0xFF1A1B4B).withOpacity(0.3),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Back to Home',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.w700,
                        color: themeProvider.isDarkMode
                            ? const Color(0xFFE8ECF5)
                            : const Color(0xFF1A1B4B),
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
  }
}
