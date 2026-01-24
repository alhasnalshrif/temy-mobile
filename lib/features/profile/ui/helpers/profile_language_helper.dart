import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';

/// Helper class for handling language changes in profile
class ProfileLanguageHelper {
  ProfileLanguageHelper._();

  /// Load saved language from preferences, defaults to 'ar' if not found
  static Future<String> loadSavedLanguage() async {
    final savedLanguage = await SharedPrefHelper.getString(
      SharedPrefKeys.language,
    );
    return savedLanguage.isNotEmpty ? savedLanguage : 'ar';
  }

  /// Change app language and save to preferences
  static Future<void> changeLanguage(
    BuildContext context,
    String languageCode,
  ) async {
    await SharedPrefHelper.setData(SharedPrefKeys.language, languageCode);
    if (context.mounted) {
      await context.setLocale(Locale(languageCode));
    }
  }

  /// Get current language code from context
  static String getCurrentLanguage(BuildContext context) {
    return context.locale.languageCode;
  }

  /// Check if current language is Arabic
  static bool isArabic(BuildContext context) {
    return getCurrentLanguage(context) == 'ar';
  }

  /// Check if current language is English
  static bool isEnglish(BuildContext context) {
    return getCurrentLanguage(context) == 'en';
  }
}
