import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/routing/app_router.dart';
import 'package:temy_barber/core/services/notification_service.dart';
import 'package:temy_barber/core/theme/colors.dart';

import 'core/routing/routes.dart';

class TemyApp extends StatelessWidget {
  final AppRouter appRouter;
  const TemyApp({super.key, required this.appRouter});

  // Global navigator key for deep linking navigation
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // Set default status bar color to white with dark icons for all screens
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

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
      initialRoute:
          isLoggedInUser ? Routes.dashboardScreen : Routes.loginScreen,
      // initialRoute: Routes.onBoardingScreen,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
