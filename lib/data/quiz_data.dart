import 'models/question_model.dart';

class QuizData {
  // Static list of all quiz questions
  static final List<Question> allQuestions = [
    Question(
      id: 1,
      imageAsset: 'assets/images/quiz_1.jpg',
      questionText: 'Who is this character?',
      options: [
        'Naruto Uzumaki',
        'Monkey D Luffy',
        'Ichigo Kurosaki',
        'Son Goku',
      ],
      correctAnswerIndex: 3,
    ),
    Question(
      id: 2,
      imageAsset: 'assets/images/quiz_2.jpg',
      questionText: 'Who is this character?',
      options: [
        'Haruhi',
        'Nezuko', 
        'Fujimiya', 
        'Karen',
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 3,
      imageAsset: 'assets/images/quiz_3.jpg',
      questionText: 'Name this character',
      options: [
        'Iruka', 
        'Zoro', 
        'Inuyasha', 
        'Yamato',
      ],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 4,
      imageAsset: 'assets/images/quiz_4.jpg',
      questionText: 'Name this character',
      options: [
        'Haruhi',
        'Kawaii',
        'Sakura',
        'Alya',
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      id: 5,
      imageAsset: 'assets/images/quiz_5.jpg',
      questionText: 'Who is this character?',
      options: [
        'Tanjiro', 
        'Kuroko', 
        'Gohan', 
        'Deku',
      ],
      correctAnswerIndex: 3,
    ),
    Question(
      id: 6,
      imageAsset: 'assets/images/quiz_6.jpg',
      questionText: 'What anime is this from?',
      options: [
        'Death Note',
        'One Punch Man',
        'Mob Psycho 100',
        'Fire Force',
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      id: 7,
      imageAsset: 'assets/images/quiz_7.jpg',
      questionText: 'What anime is this from?',
      options: [
        'Kekkai Sensen', 
        'One Piece', 
        'Cowboy Bebop', 
        'Demon Slayer',
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 8,
      imageAsset: 'assets/images/quiz_8.jpg',
      questionText: 'Which anime is this from?',
      options: [
        'Jujutsu Kaisen', 
        'Re:Zero', 
        'Overlord', 
        'Konosuba',
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      id: 9,
      imageAsset: 'assets/images/quiz_9.jpg',
      questionText: 'Which anime is this from?',
      options: [
        'The Promise Neverland', 
        '91 Days', 
        'Attack on Titan', 
        'Soul Eater',
      ],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 10,
      imageAsset: 'assets/images/quiz_10.jpg',
      questionText: 'What anime is this scene from?',
      options: [
        'Tokyo Ghoul', 
        'Parasyte', 
        'Sword Art Online', 
        'Chainsaw Man',
      ],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 11,
      imageAsset: 'assets/images/quiz_11.jpg',
      questionText: 'Which anime this item belong to?',
      options: [
        'Jujutsu Kaisen',
        'Inuyashiki',
        'One Piece',
        'Attack on Titan',
      ],
      correctAnswerIndex: 3,
    ),
    Question(
      id: 12,
      imageAsset: 'assets/images/quiz_12.jpg',
      questionText: 'Who does this weapon belong to?',
      options: [
        'Kakashi',
        'Zabuza',
        'Haku',
        'Sasuke',
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 13,
      imageAsset: 'assets/images/quiz_13.jpg',
      questionText: 'Which anime this item belong to?',
      options: [
        'Black Clover', 
        'Demon Slayer', 
        'Tensura', 
        'No Game No Life',
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      id: 14,
      imageAsset: 'assets/images/quiz_14.jpg',
      questionText: 'Who does this weapon belong to?',
      options: [
        'Zoro', 
        'Zabuza', 
        'Trunks', 
        'Ichigo',
      ],
      correctAnswerIndex: 3,
    ),
    Question(
      id: 15,
      imageAsset: 'assets/images/quiz_15.jpg',
      questionText: 'Who does this weapon belong to?',
      options: [
        'Kid', 
        'Genos', 
        'Dazai', 
        'Leonardo',
        ],
      correctAnswerIndex: 0,
    ),
    Question(
      id: 16,
      imageAsset: 'assets/images/quiz_16.jpg',
      questionText: 'What is the name of the move above?',
      options: [
        'Rasengan', 
        'Detroit Smash', 
        'Kamehameha', 
        'Water Breathing',
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 17,
      imageAsset: 'assets/images/quiz_17.jpg',
      questionText: 'What is the name of the move above?',
      options: [
        'Rasengan', 
        'Detroit Smash', 
        'Kamehameha', 
        'Water Breathing',
      ],
      correctAnswerIndex: 2,
    ),
    Question(
      id: 18,
      imageAsset: 'assets/images/quiz_18.jpg',
      questionText: 'What is the name of the move above?',
      options: [
        'Detroit Smash', 
        'Rasengan', 
        'Kamehameha', 
        'Domain Expansion',
      ],
      correctAnswerIndex: 3,
    ),
    Question(
      id: 19,
      imageAsset: 'assets/images/quiz_19.jpg',
      questionText: 'What is the name of the move above?',
      options: [
        'Rasengan', 
        'Gomu Gomu no Pistol', 
        'Kamehameha', 
        'Domain Expansion',
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      id: 20,
      imageAsset: 'assets/images/quiz_20.jpg',
      questionText: 'What is the name of the move above?',
      options: [
        'Rasengan', 
        'Gomu Gomu no Pistol', 
        'Kamehameha', 
        'Domain Expansion',
      ],
      correctAnswerIndex: 0,
    ),
  ];

  // Get random questions for a quiz session
  static List<Question> getRandomQuestions(int count) {
    final shuffled = List<Question>.from(allQuestions)..shuffle();
    return shuffled.take(count).toList();
  }

  // Get question by ID
  static Question? getQuestionById(int id) {
    try {
      return allQuestions.firstWhere((q) => q.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get total number of questions
  static int get totalQuestions => allQuestions.length;
}
