import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false); // false = light mode, true = dark mode

  void toggleTheme() {
    state = !state;
  }

  ThemeData getTheme() {
    return state
        ? ThemeData.dark().copyWith(
            primaryColor: Colors.blue[300],
            scaffoldBackgroundColor: Colors.blueGrey[900],
            cardColor: Colors.blueGrey[800],
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.grey),
              titleLarge: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[300],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            checkboxTheme: CheckboxThemeData(
              fillColor: WidgetStateProperty.all(Colors.blue[300]),
              checkColor: WidgetStateProperty.all(Colors.white),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.blue[300],
              foregroundColor: Colors.white,
              elevation: 4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.blueGrey[800],
              labelStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          )
        : ThemeData.light().copyWith(
            primaryColor: Colors.blue[300],
            scaffoldBackgroundColor: Colors.blue[50],
            cardColor: Colors.blue[50],
            textTheme: TextTheme(
              bodyLarge: TextStyle(color: Colors.blue[900]),
              bodyMedium: TextStyle(color: Colors.grey[700]),
              titleLarge: TextStyle(
                color: Colors.blue[900],
                fontWeight: FontWeight.w600,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[300],
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.black,
            ),
            checkboxTheme: CheckboxThemeData(
              fillColor: WidgetStateProperty.all(Colors.blue[300]),
              checkColor: WidgetStateProperty.all(Colors.black),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.blue[300],
              foregroundColor: Colors.black,
              elevation: 4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.blue[50],
              labelStyle: TextStyle(color: Colors.grey[700]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          );
  }
}
