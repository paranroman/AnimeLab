import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/theme_provider.dart';
import '../../core/providers/quiz_provider.dart';
import '../widgets/info_card.dart';
import '../widgets/custom_button.dart';
import 'settings_screen.dart';
import 'instruction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load saved name from provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final quizProvider = Provider.of<QuizProvider>(context, listen: false);
      if (quizProvider.userName.isNotEmpty) {
        _nameController.text = quizProvider.userName;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onNavigationTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final quizProvider = Provider.of<QuizProvider>(context);
    final size = MediaQuery.of(context).size;

    // Build pages for navigation
    final List<Widget> pages = [
      _buildHomePage(context, size, themeProvider, quizProvider),
      const SettingsScreen(),
    ];

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? const Color(0xFF0F1020)
          : const Color(0xFFFFFFFF),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavigationTap,
        backgroundColor: themeProvider.isDarkMode
            ? const Color(0xFF1A1B3D)
            : const Color(0xFFFFFFFF),
        selectedItemColor: themeProvider.isDarkMode
            ? const Color(0xFFFF7BA8)
            : const Color(0xFFFF6B9D),
        unselectedItemColor: themeProvider.isDarkMode
            ? const Color(0xFFE8ECF5).withOpacity(0.5)
            : const Color(0xFF1A1B4B).withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 28), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 28),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildHomePage(
    BuildContext context,
    Size size,
    ThemeProvider themeProvider,
    QuizProvider quizProvider,
  ) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                Text(
                  'Welcome to AnimeLab!',
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

                SizedBox(height: size.height * 0.025),

                // Info Card
                InfoCard(
                  text:
                      'Here we will test how "otaku" you are with a series of quizzes that will be presented later.\n\nBefore that, please fill in your name to see the test score at the end of the quiz.',
                  isDarkMode: themeProvider.isDarkMode,
                ),

                SizedBox(height: size.height * 0.025),

                // Name Input Field
                TextField(
                  controller: _nameController,
                  onChanged: (value) {
                    quizProvider.setUserName(value);
                  },
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w400,
                    color: themeProvider.isDarkMode
                        ? const Color(0xFFE8ECF5)
                        : const Color(0xFF1A1B4B),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.w400,
                      color: themeProvider.isDarkMode
                          ? const Color(0xFFE8ECF5).withOpacity(0.4)
                          : const Color(0xFF1A1B4B).withOpacity(0.4),
                    ),
                    filled: true,
                    fillColor: themeProvider.isDarkMode
                        ? const Color(0xFF1A1B3D)
                        : const Color(0xFFF8F9FF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: themeProvider.isDarkMode
                            ? const Color(0xFF1A1B3D)
                            : const Color(0xFF1A1B4B).withOpacity(0.1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: themeProvider.isDarkMode
                            ? const Color(0xFF1A1B3D)
                            : const Color(0xFF1A1B4B).withOpacity(0.1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: themeProvider.isDarkMode
                            ? const Color(0xFFFF7BA8)
                            : const Color(0xFFFF6B9D),
                        width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.018,
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                // I'm In Button
                Center(
                  child: CustomButton(
                    text: "I'm In!",
                    onPressed: () {
                      if (quizProvider.userName.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please enter your name first!',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            backgroundColor: const Color(0xFFFF4757),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                        return;
                      }
                      // Navigate to instruction screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InstructionScreen(),
                        ),
                      );
                    },
                    isEnabled: quizProvider.userName.trim().isNotEmpty,
                    isDarkMode: themeProvider.isDarkMode,
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
