import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/routing/routes.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/barber/logic/barber_cubit.dart';
import 'package:temy_barber/features/barber/ui/barber_screen.dart';
import 'package:temy_barber/features/category/logic/category_cubit.dart';
import 'package:temy_barber/features/category/ui/category_screen.dart';
import 'package:temy_barber/features/category_barbers/logic/category_cubit.dart';
import 'package:temy_barber/features/category_barbers/ui/category_screen.dart';
import 'package:temy_barber/features/dashboard/dashboard_screen.dart';
import 'package:temy_barber/features/auth/logic/cubit/login_cubit.dart';
import 'package:temy_barber/features/auth/ui/login_screen.dart';
import 'package:temy_barber/features/auth/logic/forgot_password/forgot_password_cubit.dart';
import 'package:temy_barber/features/auth/ui/forgot_password_screen.dart';
import 'package:temy_barber/features/auth/logic/reset_password/reset_password_cubit.dart';
import 'package:temy_barber/features/auth/ui/reset_password_screen.dart';
// import 'package:temy_barber/features/onboarding/onboarding_screen.dart';
import 'package:temy_barber/features/profile/data/models/profile_response.dart';
import 'package:temy_barber/features/profile/logic/notification_cubit.dart';
import 'package:temy_barber/features/profile/ui/about_screen.dart';
import 'package:temy_barber/features/profile/ui/help_screen.dart';
import 'package:temy_barber/features/profile/ui/update_profile_screen.dart';
import 'package:temy_barber/features/profile/ui/notification_settings_screen.dart';
import 'package:temy_barber/features/profile/ui/privacy_policy_screen.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_response.dart';
import 'package:temy_barber/features/reservations/ui/booking_confirmation.dart';
import 'package:temy_barber/features/reservations/ui/invoice_screen.dart';
import 'package:temy_barber/features/reservations/ui/reservations_screen.dart';
import 'package:temy_barber/features/auth/logic/sign_up_cubit.dart';
import 'package:temy_barber/features/auth/ui/sign_up_screen.dart';
import 'package:temy_barber/features/auth/logic/verification_cubit.dart';
import 'package:temy_barber/features/auth/ui/verification_screen.dart';
import 'package:temy_barber/features/reservations/logic/reservation_cubit.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.onBoardingScreen:
      //   return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<LoginCubit>()),
              BlocProvider(create: (context) => getIt<NotificationCubit>()),
            ],
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
      case Routes.verificationScreen:
        // Handle both old format (String) and new format (Map) for arguments
        final arguments = settings.arguments;
        String phoneNumber = '';
        bool shouldAutoResend = false;
        bool comingFromLogin = false;

        if (arguments is String) {
          // Old format from signup
          phoneNumber = arguments;
        } else if (arguments is Map<String, dynamic>) {
          // New format from login
          phoneNumber = arguments['phoneNumber'] as String? ?? '';
          shouldAutoResend = arguments['shouldAutoResend'] as bool? ?? false;
          comingFromLogin = arguments['comingFromLogin'] as bool? ?? false;
        }

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<VerificationCubit>(),
            child: VerificationScreen(
              phoneNumber: phoneNumber,
              shouldAutoResend: shouldAutoResend,
              comingFromLogin: comingFromLogin,
            ),
          ),
        );
      case Routes.dashboardScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case Routes.updateProfileScreen:
        final userResponse = settings.arguments as User;
        return MaterialPageRoute(
          builder: (_) => UpdateProfileScreen(currentUser: userResponse),
        );
      case Routes.notificationSettingsScreen:
        return MaterialPageRoute(
          builder: (_) => const NotificationSettingsScreen(),
        );
      case Routes.privacyPolicyScreen:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
      case Routes.helpScreen:
        return MaterialPageRoute(builder: (_) => const HelpScreen());
      case Routes.aboutScreen:
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgotPasswordCubit>(),
            child: const ForgotPasswordScreen(),
          ),
        );
      case Routes.resetPasswordScreen:
        final phoneNumber = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ResetPasswordCubit>(),
            child: ResetPasswordScreen(phoneNumber: phoneNumber),
          ),
        );
      case Routes.invoiceScreen:
        final reservationResponse =
            settings.arguments as ReservationResponseModel;
        return MaterialPageRoute(
          builder: (_) => InvoiceScreen(arguments: reservationResponse),
        );
      case Routes.reservationScreen:
        final args = settings.arguments as ReservationArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ReservationCubit(getIt()),
            child: ReservationsScreen(arguments: args),
          ),
        );
      case Routes.bookingConfirmationScreen:
        final args = settings.arguments as ReservationArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ReservationCubit(getIt()),
            child: BookingConfirmation(arguments: args),
          ),
        );
      case Routes.categoryScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CategoryCubit(getIt())..getCategory(),
            child: const CategoryScreen(),
          ),
        );
      case Routes.categoryBarbersScreen:
        final categoryId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                CategoryBarberCubit(getIt(), categoryId!)
                  ..getCategoryWithBarbers(),
            child: const CategoryBarbersScreen(),
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
        // Handle unknown routes gracefully by redirecting to login if not logged in
        return MaterialPageRoute(
          builder: (_) => isLoggedInUser
              ? const DashboardScreen()
              : MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => getIt<LoginCubit>()),
                    BlocProvider(
                      create: (context) => getIt<NotificationCubit>(),
                    ),
                  ],
                  child: const LoginScreen(),
                ),
        );
    }
  }
}
