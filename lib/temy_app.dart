import 'package:flutter/material.dart';
import 'package:flutter_complete_project/core/helpers/constants.dart';
import 'package:flutter_complete_project/core/routing/app_router.dart';
import 'package:flutter_complete_project/core/theme/colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/routing/routes.dart';

class TemyApp extends StatelessWidget {
  final AppRouter appRouter;
  const TemyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor',
      theme: ThemeData(
        primaryColor: ColorsManager.mainBlue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Cairo',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedInUser ? Routes.dashboardScreen : Routes.loginScreen,
      // initialRoute: Routes.onBoardingScreen,
      onGenerateRoute: appRouter.generateRoute,
      locale: const Locale('ar', ''), // Set Arabic locale to enable RTL
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''), // Arabic
      ],
    );
  }
}
