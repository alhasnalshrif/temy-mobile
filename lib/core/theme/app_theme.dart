import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/font_weight_helper.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Cairo',
      primaryColor: ColorsManager.mainBlue,
      scaffoldBackgroundColor: Colors.white,

      colorScheme: const ColorScheme.light(
        primary: ColorsManager.mainBlue,
        secondary: ColorsManager.secondMain,
        tertiary: ColorsManager.thirdfMain,
        error: ColorsManager.red,
        onSecondary: Colors.white,
        onSurface: ColorsManager.darkBlue,
        outline: ColorsManager.lightGray,
      ),

      appBarTheme: const AppBarThemeData(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(size: 24, color: Colors.white),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeightHelper.bold,
          fontFamily: 'Cairo',
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeightHelper.bold,
          color: ColorsManager.mainBlue,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeightHelper.bold,
          color: ColorsManager.mainBlue,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeightHelper.bold,
          color: ColorsManager.mainBlue,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeightHelper.bold,
          color: ColorsManager.darkBlue,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeightHelper.bold,
          color: ColorsManager.darkBlue,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeightHelper.bold,
          color: ColorsManager.darkBlue,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeightHelper.semiBold,
          color: ColorsManager.darkBlue,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeightHelper.semiBold,
          color: ColorsManager.darkBlue,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeightHelper.semiBold,
          color: ColorsManager.darkBlue,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeightHelper.regular,
          color: ColorsManager.darkBlue,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeightHelper.regular,
          color: ColorsManager.gray,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeightHelper.regular,
          color: ColorsManager.gray,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeightHelper.semiBold,
          color: ColorsManager.mainBlue,
        ),
        labelMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeightHelper.medium,
          color: ColorsManager.mainBlue,
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeightHelper.medium,
          color: ColorsManager.gray,
        ),
      ),

      iconTheme: const IconThemeData(color: ColorsManager.gray, size: 24),

      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: ColorsManager.lighterGray.withOpacity(0.5)),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: ColorsManager.mainBlue,
          foregroundColor: Colors.white,
          disabledBackgroundColor: ColorsManager.lightGray,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeightHelper.semiBold,
            fontFamily: 'Cairo',
          ),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorsManager.mainBlue,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: const BorderSide(color: ColorsManager.mainBlue, width: 1.5),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeightHelper.semiBold,
            fontFamily: 'Cairo',
          ),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorsManager.mainBlue,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeightHelper.semiBold,
            fontFamily: 'Cairo',
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorsManager.moreLighterGray,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: ColorsManager.mainBlue,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: ColorsManager.red, width: 1.5),
        ),
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeightHelper.regular,
          color: ColorsManager.gray,
          fontFamily: 'Cairo',
        ),
        prefixIconColor: ColorsManager.gray,
        suffixIconColor: ColorsManager.gray,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorsManager.mainBlue,
        unselectedItemColor: ColorsManager.gray,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeightHelper.semiBold,
          fontFamily: 'Cairo',
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeightHelper.regular,
          fontFamily: 'Cairo',
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorsManager.mainBlue,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: CircleBorder(),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: ColorsManager.thirdfMain,
        selectedColor: ColorsManager.mainBlue,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeightHelper.medium,
          color: ColorsManager.mainBlue,
          fontFamily: 'Cairo',
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeightHelper.bold,
          color: ColorsManager.darkBlue,
          fontFamily: 'Cairo',
        ),
        contentTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeightHelper.regular,
          color: ColorsManager.gray,
          fontFamily: 'Cairo',
        ),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: ColorsManager.lighterGray,
        thickness: 1,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? Colors.white
              : ColorsManager.lightGray,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? ColorsManager.mainBlue
              : ColorsManager.lighterGray,
        ),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? ColorsManager.mainBlue
              : Colors.transparent,
        ),
        checkColor: WidgetStateProperty.all(Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? ColorsManager.mainBlue
              : ColorsManager.gray,
        ),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ColorsManager.mainBlue,
        linearTrackColor: ColorsManager.lighterGray,
      ),

      tabBarTheme: const TabBarThemeData(
        labelColor: ColorsManager.mainBlue,
        unselectedLabelColor: ColorsManager.gray,
        indicatorColor: ColorsManager.mainBlue,
        indicatorSize: TabBarIndicatorSize.label,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: ColorsManager.darkBlue,
        contentTextStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontFamily: 'Cairo',
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),

      listTileTheme: const ListTileThemeData(
        iconColor: ColorsManager.gray,
        textColor: ColorsManager.darkBlue,
        selectedTileColor: ColorsManager.thirdfMain,
        selectedColor: ColorsManager.mainBlue,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeightHelper.medium,
          color: ColorsManager.darkBlue,
          fontFamily: 'Cairo',
        ),
        subtitleTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeightHelper.regular,
          color: ColorsManager.gray,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}
