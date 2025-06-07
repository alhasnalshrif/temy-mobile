import 'package:flutter/material.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/services/notification_service.dart';
import 'package:temy_barber/core/utils/notification_helper.dart';
import 'package:temy_barber/temy_app.dart';

import 'core/routing/app_router.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  setupGetIt();
  await checkedIfUserLoggedIn();

  // Check OneSignal configuration
  NotificationHelper.checkConfiguration();

  // Initialize OneSignal notifications
  await getIt<NotificationService>().initialize();

  // Uncomment for testing notifications in development
  // await NotificationHelper.testNotifications();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('ar'),
        startLocale: const Locale('ar'), // <-- force Arabic as default
        child: TemyApp(
          appRouter: AppRouter(),
        )),
  );
}

checkedIfUserLoggedIn() async {
  // check if user is logged in or not
  // if user is logged in then set isLoggedInUser = true
  // else set isLoggedInUser = false

  String? userToken =
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);

  if (!userToken.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}
