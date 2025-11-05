import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                          'Settings',
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
                              : size.height * 0.03,
                        ),

                        // Theme toggle card
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(
                            isLandscape
                                ? size.height * 0.04
                                : size.width * 0.04,
                          ),
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
                                    size: isLandscape
                                        ? size.height * 0.06
                                        : size.width * 0.06,
                                  ),
                                  SizedBox(
                                    width: isLandscape
                                        ? size.height * 0.03
                                        : size.width * 0.03,
                                  ),
                                  Text(
                                    'Dark Mode',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: isLandscape
                                          ? size.height * 0.045
                                          : size.width * 0.045,
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
                                activeTrackColor: themeProvider.isDarkMode
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
              ),
            );
          },
        ),
      ),
    );
  }
}
