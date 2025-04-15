import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/core/routing/routes.dart';
import 'package:flutter_complete_project/features/barber/logic/barber_cubit.dart';
import 'package:flutter_complete_project/features/barber/ui/barber_screen.dart';
import 'package:flutter_complete_project/features/category/logic/category_cubit.dart';
import 'package:flutter_complete_project/features/category/ui/category_screen.dart';
import 'package:flutter_complete_project/features/dashboard/dashboard_screen.dart';
import 'package:flutter_complete_project/features/login/logic/cubit/login_cubit.dart';
import 'package:flutter_complete_project/features/login/ui/login_screen.dart';
import 'package:flutter_complete_project/features/onboarding/onboarding_screen.dart';
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

      case Routes.categoryScreen:
        final categoryId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                CategoryCubit(getIt(), categoryId!)..getCategory(),
            child: const CategoryScreen(),
          ),
        );
      case Routes.barberScreen:
        final barberId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                BarberCubit(getIt(), barberId!)..getBarberDetail(),
            child: const BarberScreen(),
          ),
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
