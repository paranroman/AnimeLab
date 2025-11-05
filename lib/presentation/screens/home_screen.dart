import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/theme_provider.dart';
import '../../core/providers/quiz_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final quizProvider = Provider.of<QuizProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Home Screen',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: themeProvider.isDarkMode
                      ? const Color(0xFFE8ECF5)
                      : const Color(0xFF1A1B4B),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Theme: ${themeProvider.isDarkMode ? "Dark" : "Light"}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: themeProvider.isDarkMode
                      ? const Color(0xFFE8ECF5)
                      : const Color(0xFF1A1B4B),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  themeProvider.toggleTheme();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeProvider.isDarkMode
                      ? const Color(0xFFFF7BA8)
                      : const Color(0xFFFF6B9D),
                ),
                child: Text(
                  'Toggle Theme',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  quizProvider.setUserName(value);
                },
              ),
              const SizedBox(height: 10),
              Text(
                'Current name: ${quizProvider.userName}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: themeProvider.isDarkMode
                      ? const Color(0xFFE8ECF5)
                      : const Color(0xFF1A1B4B),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '(Full UI coming in next step)',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: themeProvider.isDarkMode
                      ? const Color(0xFFE8ECF5).withValues(alpha: 0.6)
                      : const Color(0xFF1A1B4B).withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}