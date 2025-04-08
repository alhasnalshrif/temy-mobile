import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/core/routing/routes.dart';
import 'package:flutter_complete_project/features/booking/ui/booking.dart';
import 'package:flutter_complete_project/features/dashboard/dashboard_screen.dart';
import 'package:flutter_complete_project/features/home/logic/home_cubit.dart';
import 'package:flutter_complete_project/features/home/ui/home_screen.dart';
import 'package:flutter_complete_project/features/login/logic/cubit/login_cubit.dart';
import 'package:flutter_complete_project/features/login/ui/login_screen.dart';
import 'package:flutter_complete_project/features/onboarding/onboarding_screen.dart';
import 'package:flutter_complete_project/features/profile/ui/profile.dart';
import 'package:flutter_complete_project/features/sign_up/logic/sign_up_cubit.dart';
import 'package:flutter_complete_project/features/sign_up/ui/sign_up_screen.dart';
import '../di/dependency_injection.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const SignupScreen(),
          ),
        );
      // case Routes.homeScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => HomeCubit(getIt())..getCategories(),
      //       child: const HomeScreen(),
      //     ),
      //   );
      // case Routes.bookingScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const BookingScreen(),
      //   );
      // case Routes.profileScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const ProfileScreen(),
      //   );
      case Routes.dashboardScreen:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
