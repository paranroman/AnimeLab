import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Settings',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: size.width * 0.08,
                  fontWeight: FontWeight.w800,
                  color: themeProvider.isDarkMode
                      ? const Color(0xFFE8ECF5)
                      : const Color(0xFF1A1B4B),
                ),
              ),
              SizedBox(height: size.height * 0.03),

              // Theme toggle card
              Container(
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? const Color(0xFF1A1B3D)
                      : const Color(0xFFF8F9FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.dark_mode,
                          color: themeProvider.isDarkMode
                              ? const Color(0xFFE8ECF5)
                              : const Color(0xFF1A1B4B),
                          size: size.width * 0.06,
                        ),
                        SizedBox(width: size.width * 0.03),
                        Text(
                          'Dark Mode',
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
                    Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                      activeColor: themeProvider.isDarkMode
                          ? const Color(0xFFFF7BA8)
                          : const Color(0xFFFF6B9D),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
