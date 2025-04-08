import 'package:flutter/material.dart';
import 'package:flutter_complete_project/core/di/dependency_injection.dart';
import 'package:flutter_complete_project/core/helpers/constants.dart';
import 'package:flutter_complete_project/core/helpers/extensions.dart';
import 'package:flutter_complete_project/core/helpers/shared_pref_helper.dart';
import 'package:flutter_complete_project/temy_app.dart';

import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  await checkedIfUserLoggedIn();
  runApp(TemyApp(
    appRouter: AppRouter(),
  ));
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
