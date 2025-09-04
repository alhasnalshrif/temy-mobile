import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/services/notification_service.dart';
import 'package:temy_barber/core/services/permission_manager.dart';
import 'package:temy_barber/core/utils/notification_helper.dart';
import 'package:temy_barber/core/routing/app_router.dart';
import 'package:temy_barber/core/routing/routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';

bool isLoggedInUser = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  setupGetIt();
  await checkedIfUserLoggedIn();

  // Initialize Permission Manager
  try {
    log('🔐 Initializing Permission Manager...');
    await PermissionManager.instance.initialize();
    log('✅ Permission Manager initialized successfully');
  } catch (e) {
    log('❌ Permission Manager initialization failed: $e');
  }

  if (kDebugMode) {
    // Check OneSignal configuration in development
    NotificationHelper.checkConfiguration();
  }

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
      options.dsn =
          'https://60d5c02ce39df76817718e6ca4f61aa5@o4508048971792384.ingest.de.sentry.io/4509471265456208';
      options.environment = kDebugMode ? 'development' : 'production';
      options.debug = false; // Reduce debug logging noise
      options.tracesSampleRate = kDebugMode
          ? 1.0
          : 0.1; // 100% in debug, 10% in production
      options.attachStacktrace = true;
      options.enableAutoSessionTracking = true;
      options.autoAppStart = true;
      options.enableUserInteractionBreadcrumbs =
          false; // Disable UI interaction breadcrumbs
      options.captureFailedRequests = true;
      options.maxBreadcrumbs = 100;
    },
    appRunner: () => runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar'),
        startLocale: Locale(savedLanguage),
        child: TemyApp(appRouter: AppRouter()),
      ),
    ),
  );
}

Future<void> checkedIfUserLoggedIn() async {
  String? userToken = await SharedPrefHelper.getSecuredString(
    SharedPrefKeys.userToken,
  );
  isLoggedInUser = !userToken.isNullOrEmpty();
}

class TemyApp extends StatelessWidget {
  final AppRouter appRouter;
  const TemyApp({super.key, required this.appRouter});

  // Global navigator key for deep linking navigation
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // Set default status bar color to white with dark icons for all screens
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // Set navigator key for NotificationService
    NotificationService.setNavigatorKey(navigatorKey);

    return MaterialApp(
      navigatorKey: navigatorKey, // Add navigator key
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Temy Barber',
      theme: ThemeData(
        primaryColor: ColorsManager.mainBlue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Cairo',
        // Apply the white status bar style to the app theme
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedInUser
          ? Routes.dashboardScreen
          : Routes.loginScreen,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
