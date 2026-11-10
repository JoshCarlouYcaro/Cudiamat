import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF2196F3), // Deep Black/Charcoal
        primaryColor: const Color(0xFFFF2A85), // Vibrant Pink
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF2A85),
          secondary: Color(0xFFFF66B2),
          surface: Color(0xFF1E1E1E),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A1A),
          elevation: 0,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}