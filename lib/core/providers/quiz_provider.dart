import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  String _userName = '';
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _totalTime = 0; // in seconds
  List<int> _selectedQuestions = [];
  Map<int, int> _userAnswers = {}; // questionIndex: selectedAnswerIndex

  // Getters
  String get userName => _userName;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  int get totalTime => _totalTime;
  List<int> get selectedQuestions => _selectedQuestions;
  Map<int, int> get userAnswers => _userAnswers;

  // Setters
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setSelectedQuestions(List<int> questions) {
    _selectedQuestions = questions;
    notifyListeners();
  }

  void setCurrentQuestionIndex(int index) {
    _currentQuestionIndex = index;
    notifyListeners();
  }

  void incrementScore() {
    _score++;
    notifyListeners();
  }

  void addTime(int seconds) {
    _totalTime += seconds;
    notifyListeners();
  }

  void saveAnswer(int questionIndex, int answerIndex) {
    _userAnswers[questionIndex] = answerIndex;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _selectedQuestions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _totalTime = 0;
    _userAnswers.clear();
    _selectedQuestions.clear();
    notifyListeners();
  }

  void resetAll() {
    _userName = '';
    _currentQuestionIndex = 0;
    _score = 0;
    _totalTime = 0;
    _userAnswers.clear();
    _selectedQuestions.clear();
    notifyListeners();
  }
}