import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../core/providers/theme_provider.dart';
import '../../core/providers/quiz_provider.dart';
import '../widgets/timer_widget.dart';
import '../widgets/answer_option.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? _selectedAnswerIndex;
  bool _hasAnswered = false;
  bool _isTimerActive = true;
  Timer? _delayTimer;

  @override
  void dispose() {
    _delayTimer?.cancel();
    super.dispose();
  }

  void _handleAnswer(int answerIndex, QuizProvider quizProvider) {
    if (_hasAnswered) return;

    setState(() {
      _selectedAnswerIndex = answerIndex;
      _hasAnswered = true;
      _isTimerActive = false;
    });

    // Submit answer
    quizProvider.submitAnswer(answerIndex);

    // Delay before moving to next question
    _delayTimer = Timer(const Duration(seconds: 2), () {
      _moveToNextQuestion(quizProvider);
    });
  }

  void _handleTimerEnd(QuizProvider quizProvider) {
    if (_hasAnswered) return;

    setState(() {
      _hasAnswered = true;
      _isTimerActive = false;
    });

    // Auto-submit as unanswered (no answer selected)
    _delayTimer = Timer(const Duration(seconds: 1), () {
      _moveToNextQuestion(quizProvider);
    });
  }

  void _moveToNextQuestion(QuizProvider quizProvider) {
    if (quizProvider.currentQuestionIndex < quizProvider.totalQuestions - 1) {
      quizProvider.nextQuestion();
      setState(() {
        _selectedAnswerIndex = null;
        _hasAnswered = false;
        _isTimerActive = true;
      });
    } else {
      // Quiz completed - navigate to result screen
      // TODO: Navigate to result screen in next step
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Quiz completed! Score: ${quizProvider.score}/${quizProvider.totalQuestions}',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: const Color(0xFF4CAF50),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Quit Quiz?',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            content: const Text(
              'Are you sure you want to quit? Your progress will be lost.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Provider.of<QuizProvider>(context, listen: false).resetQuiz();
                },
                child: const Text(
                  'Quit',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFF4757),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final quizProvider = Provider.of<QuizProvider>(context);
    final size = MediaQuery.of(context).size;
    final currentQuestion = quizProvider.currentQuestion;

    if (currentQuestion == null) {
      return Scaffold(
        backgroundColor: themeProvider.isDarkMode
            ? const Color(0xFF0F1020)
            : const Color(0xFFFFFFFF),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: themeProvider.isDarkMode
            ? const Color(0xFF0F1020)
            : const Color(0xFFFFFFFF),
        body: SafeArea(
          child: Column(
            children: [
              // Header with back button, question counter, and timer
              Padding(
                padding: EdgeInsets.all(size.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    IconButton(
                      onPressed: () async {
                        final shouldPop = await _onWillPop();
                        if (shouldPop && mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: Icon(
                        Icons.chevron_left,
                        color: themeProvider.isDarkMode
                            ? const Color(0xFFE8ECF5)
                            : const Color(0xFF1A1B4B),
                        size: size.width * 0.08,
                      ),
                    ),

                    // Question counter
                    Text(
                      'Question ${quizProvider.currentQuestionIndex + 1} of ${quizProvider.totalQuestions}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w600,
                        color: themeProvider.isDarkMode
                            ? const Color(0xFFE8ECF5)
                            : const Color(0xFF1A1B4B),
                      ),
                    ),

                    // Timer
                    TimerWidget(
                      duration: 30,
                      isActive: _isTimerActive,
                      onTimerEnd: () => _handleTimerEnd(quizProvider),
                    ),
                  ],
                ),
              ),

              // Quiz content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          currentQuestion.imageAsset,
                          width: double.infinity,
                          height: size.height * 0.3,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: size.height * 0.3,
                              decoration: BoxDecoration(
                                color: themeProvider.isDarkMode
                                    ? const Color(0xFF1A1B3D)
                                    : const Color(0xFFF8F9FF),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                Icons.image_not_supported,
                                size: size.width * 0.15,
                                color: themeProvider.isDarkMode
                                    ? const Color(0xFFE8ECF5).withOpacity(0.3)
                                    : const Color(0xFF1A1B4B).withOpacity(0.3),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: size.height * 0.03),

                      // Question text
                      Text(
                        currentQuestion.questionText,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.w600,
                          color: themeProvider.isDarkMode
                              ? const Color(0xFFE8ECF5)
                              : const Color(0xFF1A1B4B),
                        ),
                      ),

                      SizedBox(height: size.height * 0.025),

                      // Answer options
                      ...List.generate(
                        currentQuestion.options.length,
                        (index) {
                          final isCorrectAnswer =
                              index == currentQuestion.correctAnswerIndex;
                          final isSelectedByUser = index == _selectedAnswerIndex;
                          final isWrongAnswer =
                              _hasAnswered && isSelectedByUser && !isCorrectAnswer;
                          final shouldShowCorrect =
                              _hasAnswered && isCorrectAnswer;

                          return Padding(
                            padding: EdgeInsets.only(bottom: size.height * 0.015),
                            child: AnswerOption(
                              text: currentQuestion.options[index],
                              onTap: () => _handleAnswer(index, quizProvider),
                              isCorrect: shouldShowCorrect,
                              isWrong: isWrongAnswer,
                              isDisabled: _hasAnswered,
                              isDarkMode: themeProvider.isDarkMode,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
