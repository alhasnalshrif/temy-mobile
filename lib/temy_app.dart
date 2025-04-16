import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/routing/app_router.dart';
import 'package:temy_barber/core/theme/colors.dart';

import 'core/routing/routes.dart';

class TemyApp extends StatelessWidget {
  final AppRouter appRouter;
  const TemyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Temy Barber',
      theme: ThemeData(
        primaryColor: ColorsManager.mainBlue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Cairo',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute:
          isLoggedInUser ? Routes.dashboardScreen : Routes.loginScreen,
      // initialRoute: Routes.onBoardingScreen,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
