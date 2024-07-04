import 'package:flutter/material.dart';

// Warna-warna custom yang digunakan dalam aplikasi
const Color primaryColor = Color(0xFF313D5A);
const Color secondaryColor = Color(0xFF73628A);
const Color backgroundColor = Color(0xFFF0F0F0);
const Color textColor = Color(0xFF1A1A1A);
const Color lightColor = Color(0xFFFBFEF9);
const Color dangerColor = Color(0xFFA63446);
const Color warningColor = Color(0xFFFB8500);
const Color successColor = Color(0xFF41C841);
const Color infoColor = Color(0xFF0C6291);

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      secondaryHeaderColor: secondaryColor,
      scaffoldBackgroundColor: backgroundColor,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 48.0,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        displayMedium: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        displaySmall: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        headlineLarge: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        headlineSmall: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 18.0,
          color: textColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          color: textColor,
        ),
        bodySmall: TextStyle(
          fontSize: 12.0,
          color: textColor,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all<Size>(Size(double.infinity, 48)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all<Size>(Size(double.infinity, 48)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 5,
        color: lightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      colorScheme: const ColorScheme(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: backgroundColor,
        error: dangerColor,
        errorContainer: warningColor,
        tertiary: infoColor,
        onPrimary: lightColor,
        onSecondary: lightColor,
        onSurface: textColor,
        onError: lightColor,
        onErrorContainer: successColor,
        brightness: Brightness.light,
      ),
    );
  }

  // Styles for FilledButton
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: lightColor,
    minimumSize: Size(double.infinity, 48),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: secondaryColor,
    foregroundColor: lightColor,
    minimumSize: Size(double.infinity, 48),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  // Styles for OutlinedButton
  static ButtonStyle primaryOutlinedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: primaryColor,
    side: BorderSide(color: primaryColor),
    minimumSize: Size(double.infinity, 48),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  static ButtonStyle secondaryOutlinedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: secondaryColor,
    side: BorderSide(color: secondaryColor),
    minimumSize: Size(double.infinity, 48),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );
}
