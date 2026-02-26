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
import 'package:temy_barber/core/theme/app_theme.dart';
import 'package:temy_barber/core/utils/notification_helper.dart';
import 'package:temy_barber/core/routing/app_router_go.dart';
import 'package:temy_barber/core/ui/maintenance_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/settings/data/repos/settings_repo.dart';
import 'package:temy_barber/features/settings/data/models/settings_response.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:temy_barber/core/ui/update_modal.dart';

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

  if (settingsData?.maintenance == true) {
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar'),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MaintenanceScreen(
            message: settingsData?.maintenanceMessage,
            logo: settingsData?.logo,
            about: settingsData?.about,
            phone: settingsData?.phone,
            address: settingsData?.address,
            onRefresh: () async {
              // Re-fetch settings to check if maintenance is still active
              final settingsRepo = getIt<SettingsRepo>();
              final response = await settingsRepo.getSettings();

              response.when(
                success: (data) {
                  if (data.data?.maintenance == false) {
                    // Maintenance is over, restart the app
                    main();
                  }
                },
                failure: (error) {
                  log('Refresh failed: $error');
                },
              );
            },
          ),
        ),
      ),
    );
    return;
  }

  await checkedIfUserLoggedIn();

  try {
    await PermissionManager.instance.initialize();
  } catch (e) {
    log(' Permission Manager initialization failed: $e');
  }

  if (kDebugMode) {
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
        child: TemyApp(settingsData: settingsData),
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
  final SettingsData? settingsData;
  const TemyApp({super.key, this.settingsData});

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

    if (widget.settingsData != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _checkUpdate(widget.settingsData!);
      });
    }
  }

  Future<void> _checkUpdate(SettingsData settings) async {
    if (settings.appVersion == null || settings.appVersion!.isEmpty) return;

    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;

    if (_isUpdateRequired(currentVersion, settings.appVersion!)) {
      final context = AppRouterGo.navigatorKey.currentContext;
      if (context != null) {
        UpdateModal.show(
          context,
          forceUpdate: settings.forceUpdate ?? false,
          androidUrl: settings.androidUrl ?? '',
          iphoneUrl: settings.iphoneUrl ?? '',
        );
      }
    }
  }

  bool _isUpdateRequired(String current, String remote) {
    final currentParts = current
        .split('.')
        .map((e) => int.tryParse(e) ?? 0)
        .toList();
    final remoteParts = remote
        .split('.')
        .map((e) => int.tryParse(e) ?? 0)
        .toList();

    for (var i = 0; i < 3; i++) {
      final c = i < currentParts.length ? currentParts[i] : 0;
      final r = i < remoteParts.length ? remoteParts[i] : 0;
      if (r > c) return true;
      if (r < c) return false;
    }
    return false;
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
      theme: AppTheme.theme,
      themeMode: ThemeMode.light,

      debugShowCheckedModeBanner: false,
    );
  }
}
