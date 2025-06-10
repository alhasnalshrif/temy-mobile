import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/services/notification_service.dart';
import 'package:temy_barber/core/utils/notification_helper.dart';
import 'package:temy_barber/temy_app.dart';
import 'package:easy_localization/easy_localization.dart';

import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  setupGetIt();
  await checkedIfUserLoggedIn();
  // Development-specific notification checks
  if (kDebugMode) {
    // Check OneSignal configuration in development
    NotificationHelper.checkConfiguration();
    
    // Uncomment for testing notifications in development
    // await NotificationHelper.testNotifications();
  }

  // Initialize OneSignal notifications with error handling
  try {
    log('🚀 Starting OneSignal initialization...');
    await getIt<NotificationService>().initialize();
    log('✅ OneSignal initialization completed');
  } catch (e) {
    log('❌ OneSignal initialization failed: $e');
    // Continue app execution even if OneSignal fails
  }

  // Handle language preference (production behavior)
  String savedLanguage = 'ar'; // Default to Arabic
  if (!kDebugMode) {
    // In production, load saved language preference
    savedLanguage = await SharedPrefHelper.getString(SharedPrefKeys.language);
    if (savedLanguage.isEmpty) {
      savedLanguage = 'ar'; // Default to Arabic if no language is saved
      await SharedPrefHelper.setData(SharedPrefKeys.language, savedLanguage);
    }
  }
  // Initialize Sentry for error tracking and monitoring
  await SentryFlutter.init(
    (options) {
      // TODO: Replace with your actual Sentry DSN from sentry.io
      options.dsn = 'https://60d5c02ce39df76817718e6ca4f61aa5@o4508048971792384.ingest.de.sentry.io/4509471265456208';
      options.environment = kDebugMode ? 'development' : 'production';
      options.debug = kDebugMode;
      
      // Performance monitoring
      options.tracesSampleRate = kDebugMode ? 1.0 : 0.1; // 100% in debug, 10% in production
      
      // Error tracking options
      options.attachStacktrace = true;
      options.enableAutoSessionTracking = true;
      options.autoAppStart = true;
      
      // Capture options
      options.captureFailedRequests = true;
      options.maxBreadcrumbs = 100;
    },
    appRunner: () => runApp(
      EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path: 'assets/translations',
          fallbackLocale: const Locale('ar'),
          startLocale: Locale(savedLanguage),
          child: TemyApp(
            appRouter: AppRouter(),
          )),
    ),
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
