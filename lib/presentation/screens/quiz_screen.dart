import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../core/providers/theme_provider.dart';
import '../../core/providers/quiz_provider.dart';
import '../widgets/timer_widget.dart';
import '../widgets/answer_option.dart';
import 'result_screen.dart';
import 'home_screen.dart';

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
  Timer? _timeTracker;
  int _elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimeTracking();
  }

  void _startTimeTracking() {
    _timeTracker = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedSeconds++;
    });
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _timeTracker?.cancel();
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
      // Quiz completed - save total time and navigate to result screen
      _timeTracker?.cancel();
      quizProvider.addTime(_elapsedSeconds);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ResultScreen()),
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
                  Navigator.of(context).pop(false);
                  Provider.of<QuizProvider>(context, listen: false).resetQuiz();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
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
    final isLandscape = size.width > size.height;

    if (currentQuestion == null) {
      return Scaffold(
        backgroundColor: themeProvider.isDarkMode
            ? const Color(0xFF0F1020)
            : const Color(0xFFFFFFFF),
        body: const Center(child: CircularProgressIndicator()),
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
                padding: EdgeInsets.all(
                  isLandscape ? size.height * 0.02 : size.width * 0.04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    IconButton(
                      onPressed: () async {
                        await _onWillPop();
                      },
                      icon: Icon(
                        Icons.chevron_left,
                        color: themeProvider.isDarkMode
                            ? const Color(0xFFE8ECF5)
                            : const Color(0xFF1A1B4B),
                        size: isLandscape
                            ? size.height * 0.06
                            : size.width * 0.08,
                      ),
                    ),

                    // Question counter
                    Flexible(
                      child: Text(
                        'Question ${quizProvider.currentQuestionIndex + 1} of ${quizProvider.totalQuestions}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: isLandscape
                              ? size.height * 0.04
                              : size.width * 0.04,
                          fontWeight: FontWeight.w600,
                          color: themeProvider.isDarkMode
                              ? const Color(0xFFE8ECF5)
                              : const Color(0xFF1A1B4B),
                        ),
                      ),
                    ),

                    // Timer
                    TimerWidget(
                      key: ValueKey(quizProvider.currentQuestionIndex),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: isLandscape
                        ? size.width * 0.05
                        : size.width * 0.05,
                    vertical: isLandscape ? size.height * 0.02 : 0,
                  ),
                  child: isLandscape
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left side - Image
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: size.height * 0.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.1,
                                          ),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        currentQuestion.imageAsset,
                                        width: double.infinity,
                                        height: size.height * 0.5,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                width: double.infinity,
                                                height: size.height * 0.5,
                                                decoration: BoxDecoration(
                                                  color:
                                                      themeProvider.isDarkMode
                                                      ? const Color(0xFF1A1B3D)
                                                      : const Color(0xFFF8F9FF),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Icon(
                                                  Icons.image_not_supported,
                                                  size: size.height * 0.1,
                                                  color:
                                                      themeProvider.isDarkMode
                                                      ? const Color(
                                                          0xFFE8ECF5,
                                                        ).withValues(alpha: 0.3)
                                                      : const Color(
                                                          0xFF1A1B4B,
                                                        ).withValues(
                                                          alpha: 0.3,
                                                        ),
                                                ),
                                              );
                                            },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: size.width * 0.03),

                            // Right side - Question and answers
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentQuestion.questionText,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: size.height * 0.045,
                                      fontWeight: FontWeight.w600,
                                      color: themeProvider.isDarkMode
                                          ? const Color(0xFFE8ECF5)
                                          : const Color(0xFF1A1B4B),
                                    ),
                                  ),

                                  SizedBox(height: size.height * 0.02),

                                  // Answer options
                                  ...List.generate(
                                    currentQuestion.options.length,
                                    (index) {
                                      final isCorrectAnswer =
                                          index ==
                                          currentQuestion.correctAnswerIndex;
                                      final isSelectedByUser =
                                          index == _selectedAnswerIndex;
                                      final isWrongAnswer =
                                          _hasAnswered &&
                                          isSelectedByUser &&
                                          !isCorrectAnswer;
                                      final shouldShowCorrect =
                                          _hasAnswered && isCorrectAnswer;

                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: size.height * 0.015,
                                        ),
                                        child: AnswerOption(
                                          text: currentQuestion.options[index],
                                          onTap: () => _handleAnswer(
                                            index,
                                            quizProvider,
                                          ),
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
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Question image
                            Container(
                              width: double.infinity,
                              height: size.height * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  currentQuestion.imageAsset,
                                  width: double.infinity,
                                  height: size.height * 0.25,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: double.infinity,
                                      height: size.height * 0.25,
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
                                            ? const Color(
                                                0xFFE8ECF5,
                                              ).withValues(alpha: 0.3)
                                            : const Color(
                                                0xFF1A1B4B,
                                              ).withValues(alpha: 0.3),
                                      ),
                                    );
                                  },
                                ),
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
                            ...List.generate(currentQuestion.options.length, (
                              index,
                            ) {
                              final isCorrectAnswer =
                                  index == currentQuestion.correctAnswerIndex;
                              final isSelectedByUser =
                                  index == _selectedAnswerIndex;
                              final isWrongAnswer =
                                  _hasAnswered &&
                                  isSelectedByUser &&
                                  !isCorrectAnswer;
                              final shouldShowCorrect =
                                  _hasAnswered && isCorrectAnswer;

                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: size.height * 0.015,
                                ),
                                child: AnswerOption(
                                  text: currentQuestion.options[index],
                                  onTap: () =>
                                      _handleAnswer(index, quizProvider),
                                  isCorrect: shouldShowCorrect,
                                  isWrong: isWrongAnswer,
                                  isDisabled: _hasAnswered,
                                  isDarkMode: themeProvider.isDarkMode,
                                ),
                              );
                            }),
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
