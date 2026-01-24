import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:temy_barber/core/auth/auth_service.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/services/notification_service.dart';
import 'package:temy_barber/core/services/permission_manager.dart';
import 'package:temy_barber/core/utils/notification_helper.dart';
import 'package:temy_barber/core/routing/app_router_go.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/ui/maintenance_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/settings/data/repos/settings_repo.dart';
import 'package:temy_barber/features/settings/data/models/settings_response.dart';
import 'package:url_strategy/url_strategy.dart'; // Import url_strategy

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await EasyLocalization.ensureInitialized();

  setupGetIt();

  SettingsData? settingsData;
  try {
    final settingsRepo = getIt<SettingsRepo>();
    final settingsResponse = await settingsRepo.getSettings();

    settingsResponse.when(
      success: (data) {
        settingsData = data.data;
      },
      failure: (error) {
        log(' Failed to fetch settings: $error');
      },
    );
  } catch (e) {
    log('Error checking settings: $e');
  }

  // If maintenance mode is active, show MaintenanceScreen
  if (settingsData?.maintenance == true) {
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar'),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MaintenanceScreen(
            logo: settingsData?.logo,
            about: settingsData?.about,
            phone: settingsData?.phone,
            address: settingsData?.address,
          ),
        ),
      ),
    );
    return;
  }

  await checkedIfUserLoggedIn();

  // Initialize Permission Manager
  try {
    await PermissionManager.instance.initialize();
  } catch (e) {
    log(' Permission Manager initialization failed: $e');
  }

  if (kDebugMode) {
    // Check OneSignal configuration in development
    NotificationHelper.checkConfiguration();
  }

  try {
    if (!kIsWeb) {
      await getIt<NotificationService>().initialize();
      log(' OneSignal initialization completed');
    }
  } catch (e) {
    log('OneSignal initialization failed: $e');
  }

  String savedLanguage = 'ar';
  if (!kDebugMode) {
    savedLanguage = await SharedPrefHelper.getString(SharedPrefKeys.language);
    if (savedLanguage.isEmpty) {
      savedLanguage = 'ar';
      await SharedPrefHelper.setData(SharedPrefKeys.language, savedLanguage);
    }
  }

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://60d5c02ce39df76817718e6ca4f61aa5@o4508048971792384.ingest.de.sentry.io/4509471265456208';
      options.environment = kDebugMode ? 'development' : 'production';
      options.debug = false;
      options.tracesSampleRate = kDebugMode ? 1.0 : 0.1;
      options.attachStacktrace = true;
      options.enableAutoSessionTracking = true;
      options.enableUserInteractionBreadcrumbs = false;
      options.captureFailedRequests = true;
      options.maxBreadcrumbs = 100;
    },
    appRunner: () => runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar'),
        startLocale: Locale(savedLanguage),
        child: const TemyApp(),
      ),
    ),
  );
}

Future<void> checkedIfUserLoggedIn() async {
  log('🔐 Checking user authentication status...');

  try {
    final isAuthenticated = await AuthService.instance.isAuthenticated();

    if (isAuthenticated) {
      isLoggedInUser = true;

      final userId = await AuthService.instance.getUserId();
      if (userId != null) {
        log(' User ID: $userId');
      }
    } else {
      isLoggedInUser = false;

      await AuthService.instance.clearAuthentication();
    }
  } catch (e) {
    isLoggedInUser = false;

    try {
      await AuthService.instance.clearAuthentication();
    } catch (clearError) {
      log(' Error clearing authentication data: $clearError');
    }
  }
}

class TemyApp extends StatefulWidget {
  const TemyApp({super.key});

  @override
  State<TemyApp> createState() => _TemyAppState();
}

class _TemyAppState extends State<TemyApp> {
  late final GoRouter _goRouter;

  @override
  void initState() {
    super.initState();
    _goRouter = AppRouterGo.createRouter(isLoggedIn: isLoggedInUser);
    NotificationService.setNavigatorKey(AppRouterGo.navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp.router(
      routerConfig: _goRouter,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Temy Barber',
      theme: ThemeData(
        primaryColor: ColorsManager.mainBlue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Cairo',
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
