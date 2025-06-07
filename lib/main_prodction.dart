import 'package:flutter/material.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/services/notification_service.dart';
import 'package:temy_barber/temy_app.dart';
import 'package:easy_localization/easy_localization.dart';

import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  setupGetIt();
  await checkedIfUserLoggedIn();

  // Initialize OneSignal notifications
  await getIt<NotificationService>().initialize();

  // Load saved language preference
  String savedLanguage =
      await SharedPrefHelper.getString(SharedPrefKeys.language);
  if (savedLanguage.isEmpty) {
    savedLanguage = 'ar'; // Default to Arabic if no language is saved
    await SharedPrefHelper.setData(SharedPrefKeys.language, savedLanguage);
  }

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar'),
        startLocale: Locale(savedLanguage), // Use the saved language
        child: TemyApp(
          appRouter: AppRouter(),
        )),
  );
}

checkedIfUserLoggedIn() async {
  String? userToken =
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);

  if (!userToken.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}
