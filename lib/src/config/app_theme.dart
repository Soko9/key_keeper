import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/utils.dart';

abstract class AppTheme {
  static final TextStyle _fontStyle = GoogleFonts.jetBrainsMono();

  static ThemeData get lightTheme => ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryLight,
          primary: AppColors.primaryLight,
          primaryContainer: AppColors.containerLight,
          error: AppColors.errorLight,
          inverseSurface: AppColors.scaffoldDark,
          secondary: AppColors.senderLight,
        ),
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(
          Typography.blackRedwoodCity,
        ).copyWith(
          bodyLarge: _fontStyle.copyWith(
            color: Colors.black,
          ),
          headlineLarge: _fontStyle.copyWith(
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: AppColors.scaffoldLight,
        outlinedButtonTheme: _outlinedButtonThemeData(false),
        elevatedButtonTheme: _elevatedButtonThemeData(false),
        inputDecorationTheme: _inputDecorationTheme(false),
        appBarTheme: _appBarTheme(false),
        floatingActionButtonTheme: _floatingActionButtonThemeData(false),
        dropdownMenuTheme: _dropdownMenuThemeData(false),
        iconButtonTheme: _iconButtonThemeData(false),
        iconTheme: _iconThemeData(false),
        bottomNavigationBarTheme: _bottomNavigationBarThemeData(false),
      );

  static ThemeData get darkTheme => ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryDark,
          primary: AppColors.primaryDark,
          primaryContainer: AppColors.containerDark,
          error: AppColors.errorDark,
          inverseSurface: AppColors.scaffoldLight,
          secondary: AppColors.senderDark,
        ),
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(
          Typography.whiteRedwoodCity,
        ).copyWith(
          bodyLarge: _fontStyle.copyWith(
            color: Colors.white,
          ),
          headlineLarge: _fontStyle.copyWith(
            color: Colors.black,
          ),
        ),
        scaffoldBackgroundColor: AppColors.scaffoldDark,
        outlinedButtonTheme: _outlinedButtonThemeData(true),
        elevatedButtonTheme: _elevatedButtonThemeData(true),
        inputDecorationTheme: _inputDecorationTheme(true),
        appBarTheme: _appBarTheme(true),
        floatingActionButtonTheme: _floatingActionButtonThemeData(true),
        dropdownMenuTheme: _dropdownMenuThemeData(true),
        iconButtonTheme: _iconButtonThemeData(true),
        iconTheme: _iconThemeData(true),
        bottomNavigationBarTheme: _bottomNavigationBarThemeData(true),
      );

  static OutlinedButtonThemeData _outlinedButtonThemeData(
    bool isDark,
  ) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          side: BorderSide(
            color: isDark ? AppColors.primaryDark : AppColors.primaryLight,
            width: 2.0,
          ),
          textStyle: _fontStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      );

  static ElevatedButtonThemeData _elevatedButtonThemeData(
    bool isDark,
  ) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              isDark ? AppColors.primaryDark : AppColors.primaryLight,
          foregroundColor:
              isDark ? AppColors.scaffoldDark : AppColors.scaffoldLight,
          textStyle: _fontStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      );

  static InputDecorationTheme _inputDecorationTheme(
    bool isDark,
  ) =>
      InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.containerDark : AppColors.containerLight,
        hintStyle: _fontStyle.copyWith(
          color: isDark
              ? AppColors.containerLight.withValues(alpha: 0.6)
              : AppColors.containerDark.withValues(alpha: 0.6),
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
        suffixIconColor: isDark
            ? AppColors.containerLight.withValues(alpha: 0.6)
            : AppColors.containerDark.withValues(alpha: 0.6),
        enabledBorder: const UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: isDark ? AppColors.primaryDark : AppColors.primaryLight,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: isDark ? AppColors.errorDark : AppColors.errorLight,
          ),
        ),
        errorMaxLines: 2,
        errorStyle: _fontStyle.copyWith(
          color: isDark ? AppColors.errorDark : AppColors.errorLight,
          fontWeight: FontWeight.bold,
          fontSize: 10.0,
        ),
      );

  static AppBarTheme _appBarTheme(
    bool isDark,
  ) =>
      AppBarTheme(
        elevation: 0,
        titleTextStyle: _fontStyle.copyWith(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.scaffoldLight : AppColors.scaffoldDark,
        ),
        backgroundColor:
            isDark ? AppColors.scaffoldDark : AppColors.scaffoldLight,
      );

  static FloatingActionButtonThemeData _floatingActionButtonThemeData(
    bool isDark,
  ) =>
      FloatingActionButtonThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        iconSize: 18.0,
        backgroundColor:
            isDark ? AppColors.primaryDark : AppColors.primaryLight,
        foregroundColor:
            isDark ? AppColors.scaffoldDark : AppColors.scaffoldLight,
      );

  static DropdownMenuThemeData _dropdownMenuThemeData(
    bool isDark,
  ) =>
      DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: isDark ? AppColors.primaryDark : AppColors.primaryLight,
          enabledBorder: const UnderlineInputBorder(),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
              color: isDark ? AppColors.primaryDark : AppColors.primaryLight,
            ),
          ),
          suffixIconColor:
              isDark ? AppColors.scaffoldDark : AppColors.scaffoldLight,
        ),
        textStyle: _fontStyle.copyWith(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.scaffoldDark : AppColors.scaffoldLight,
        ),
        menuStyle: MenuStyle(
          elevation: const WidgetStatePropertyAll(0),
          shape: const WidgetStatePropertyAll(RoundedRectangleBorder()),
          backgroundColor: isDark
              ? const WidgetStatePropertyAll(AppColors.primaryDark)
              : const WidgetStatePropertyAll(AppColors.primaryLight),
        ),
      );

  static IconButtonThemeData _iconButtonThemeData(
    bool isDark,
  ) =>
      IconButtonThemeData(
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          elevation: 0,
          iconSize: 22.0,
          padding: const EdgeInsets.all(10.0),
          backgroundColor:
              isDark ? AppColors.primaryDark : AppColors.primaryLight,
          foregroundColor:
              isDark ? AppColors.scaffoldDark : AppColors.scaffoldLight,
        ),
      );

  static IconThemeData _iconThemeData(bool isDark) => IconThemeData(
      color: isDark ? AppColors.scaffoldDark : AppColors.scaffoldLight);

  static BottomNavigationBarThemeData _bottomNavigationBarThemeData(
    bool isDark,
  ) =>
      BottomNavigationBarThemeData(
        backgroundColor:
            isDark ? AppColors.containerDark : AppColors.containerLight,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: _fontStyle.copyWith(
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
        ),
        showUnselectedLabels: false,
      );
}
