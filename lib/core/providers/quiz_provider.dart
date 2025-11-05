import 'package:flutter/material.dart';
import '../../data/models/question_model.dart';
import '../../data/quiz_data.dart';

class QuizProvider extends ChangeNotifier {
  String _userName = '';
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _totalTime = 0;
  List<Question> _selectedQuestions = [];
  Map<int, int> _userAnswers = {};
  bool _isQuizActive = false;

  // Getters
  String get userName => _userName;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  int get totalTime => _totalTime;
  List<Question> get selectedQuestions => _selectedQuestions;
  Map<int, int> get userAnswers => _userAnswers;
  bool get isQuizActive => _isQuizActive;

  // Get current question
  Question? get currentQuestion {
    if (_selectedQuestions.isEmpty ||
        _currentQuestionIndex >= _selectedQuestions.length) {
      return null;
    }
    return _selectedQuestions[_currentQuestionIndex];
  }

  // Get total questions in current quiz
  int get totalQuestions => _selectedQuestions.length;

  // Check if quiz is completed
  bool get isQuizCompleted =>
      _currentQuestionIndex >= _selectedQuestions.length;

  // Setters
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  // Initialize quiz with random questions
  void initializeQuiz({int questionCount = 5}) {
    _selectedQuestions = QuizData.getRandomQuestions(questionCount);
    _currentQuestionIndex = 0;
    _score = 0;
    _totalTime = 0;
    _userAnswers.clear();
    _isQuizActive = true;
    notifyListeners();
  }

  void setCurrentQuestionIndex(int index) {
    _currentQuestionIndex = index;
    notifyListeners();
  }

  // Save user answer and check if correct
  void submitAnswer(int answerIndex) {
    if (currentQuestion == null) return;

    _userAnswers[_currentQuestionIndex] = answerIndex;

    // Check if answer is correct
    if (answerIndex == currentQuestion!.correctAnswerIndex) {
      _score++;
    }

    notifyListeners();
  }

  void addTime(int seconds) {
    _totalTime += seconds;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _selectedQuestions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    } else {
      _isQuizActive = false;
      notifyListeners();
    }
  }

  // Check if user has answered current question
  bool get hasAnsweredCurrentQuestion {
    return _userAnswers.containsKey(_currentQuestionIndex);
  }

  // Get user's answer for current question
  int? get currentUserAnswer {
    return _userAnswers[_currentQuestionIndex];
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _totalTime = 0;
    _userAnswers.clear();
    _selectedQuestions.clear();
    _isQuizActive = false;
    notifyListeners();
  }

  void resetAll() {
    _userName = '';
    _currentQuestionIndex = 0;
    _score = 0;
    _totalTime = 0;
    _userAnswers.clear();
    _selectedQuestions.clear();
    _isQuizActive = false;
    notifyListeners();
  }
}
