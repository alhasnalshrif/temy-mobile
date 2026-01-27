import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/features/auth/logic/cubit/login_cubit.dart';
import 'package:temy_barber/features/auth/logic/forgot_password/forgot_password_cubit.dart';
import 'package:temy_barber/features/auth/logic/reset_password/reset_password_cubit.dart';
import 'package:temy_barber/features/auth/logic/sign_up_cubit.dart';
import 'package:temy_barber/features/auth/logic/verification_cubit.dart';
import 'package:temy_barber/features/auth/ui/forgot_password_screen.dart';
import 'package:temy_barber/features/auth/ui/login_screen.dart';
import 'package:temy_barber/features/auth/ui/reset_password_screen.dart';
import 'package:temy_barber/features/auth/ui/sign_up_screen.dart';
import 'package:temy_barber/features/auth/ui/verification_screen.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/barber/logic/barber_cubit.dart';
import 'package:temy_barber/features/barber/ui/barber_screen.dart';
import 'package:temy_barber/features/booking/ui/booking.dart'
    deferred as booking;
import 'package:temy_barber/features/category/logic/category_cubit.dart';
import 'package:temy_barber/features/category/ui/category_screen.dart';
import 'package:temy_barber/features/category_barbers/logic/category_cubit.dart';
import 'package:temy_barber/features/category_barbers/ui/category_screen.dart';
import 'package:temy_barber/features/dashboard/dashboard_screen.dart';
import 'package:temy_barber/features/home/logic/home_cubit.dart';
import 'package:temy_barber/features/home/ui/home_screen.dart';
import 'package:temy_barber/features/profile/data/models/profile_response.dart';
import 'package:temy_barber/features/profile/logic/notification_cubit.dart';
import 'package:temy_barber/features/profile/ui/profile.dart'
    deferred as profile;
import 'package:temy_barber/features/profile/ui/content_screen.dart';
import 'package:temy_barber/features/profile/ui/update_profile_screen.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_response.dart';
import 'package:temy_barber/features/reservations/logic/reservation_cubit.dart';
import 'package:temy_barber/features/reservations/ui/booking_confirmation.dart';
import 'package:temy_barber/features/reservations/ui/invoice_screen.dart'
    deferred as invoice;
import 'package:temy_barber/features/reservations/ui/reservations_screen.dart';

class AppRouterGo {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter createRouter({required bool isLoggedIn}) {
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: isLoggedIn ? AppRoutes.Home : AppRoutes.Login,
      debugLogDiagnostics: kDebugMode, // Disable route logging in production
      routes: [
        // Auth Routes
        GoRoute(
          path: AppRoutes.Login,
          name: AppRoutes.loginName,
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<LoginCubit>()),
              BlocProvider(create: (context) => getIt<NotificationCubit>()),
            ],
            child: const LoginScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.Signup,
          name: AppRoutes.signupName,
          builder: (context, state) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const SignupScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.Verification,
          name: AppRoutes.verificationName,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>?;
            return BlocProvider(
              create: (context) => getIt<VerificationCubit>(),
              child: VerificationScreen(
                phoneNumber: args?['phoneNumber'] as String? ?? '',
                shouldAutoResend: args?['shouldAutoResend'] as bool? ?? false,
                comingFromLogin: args?['comingFromLogin'] as bool? ?? false,
              ),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.ForgotPassword,
          name: AppRoutes.forgotPasswordName,
          builder: (context, state) => BlocProvider(
            create: (context) => getIt<ForgotPasswordCubit>(),
            child: const ForgotPasswordScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.ResetPassword,
          name: AppRoutes.resetPasswordName,
          builder: (context, state) {
            final phoneNumber = state.extra as String? ?? '';
            return BlocProvider(
              create: (context) => getIt<ResetPasswordCubit>(),
              child: ResetPasswordScreen(phoneNumber: phoneNumber),
            );
          },
        ),

        // Main App Routes (Shell)
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return DashboardScreen(navigationShell: navigationShell);
          },
          branches: [
            // Home Branch
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.Home,
                  name: AppRoutes.homeName,
                  builder: (context, state) => BlocProvider(
                    create: (context) => HomeCubit(getIt())
                      ..getCategories()
                      ..getBanners(),
                    child: const HomeScreen(),
                  ),
                  routes: [
                    // Nested Category Routes
                    GoRoute(
                      path: AppRoutes.CategoriesPath, // Relative path
                      name: AppRoutes.categoriesName,
                      builder: (context, state) => BlocProvider(
                        create: (context) =>
                            CategoryCubit(getIt())..getCategory(),
                        child: const CategoryScreen(),
                      ),
                    ),
                    GoRoute(
                      path: AppRoutes.CategoryBarbersPath, // Relative path
                      name: AppRoutes.categoryBarbersName,
                      builder: (context, state) {
                        final categoryId = state.pathParameters['categoryId']!;
                        return BlocProvider(
                          create: (context) =>
                              CategoryBarberCubit(getIt(), categoryId)
                                ..getCategoryWithBarbers(),
                          child: const CategoryBarbersScreen(),
                        );
                      },
                    ),

                    // Nested Barber Routes
                    GoRoute(
                      path: AppRoutes.BarberDetailPath, // Relative path
                      name: AppRoutes.barberName,
                      builder: (context, state) {
                        final barberId = state.pathParameters['barberId']!;
                        return BlocProvider(
                          create: (context) =>
                              BarberCubit(getIt(), barberId)..getBarberDetail(),
                          child: const BarberScreen(),
                        );
                      },
                      routes: [
                        // Nested Reservation (accessed from Barber)
                        GoRoute(
                          path: AppRoutes.ReservationPath,
                          name: AppRoutes.reservationName,
                          builder: (context, state) {
                            final args = state.extra as ReservationArguments?;
                            return BlocProvider(
                              create: (context) => ReservationCubit(getIt()),
                              child: ReservationsScreen(arguments: args),
                            );
                          },
                        ),
                      ],
                    ),

                    // Nested Booking Confirmation (accessed from Home/Reservation)
                    // Kept at Home level to allow clearing Barber/Reservation from history if desired,
                    // or can be nested if we want to keep history.
                    // Usually confirmation leads back to Home.
                    GoRoute(
                      path: AppRoutes.BookingConfirmationPath,
                      name: AppRoutes.bookingConfirmationName,
                      builder: (context, state) {
                        final args = state.extra as ReservationArguments?;
                        if (args == null) {
                          Future.microtask(() => context.go(AppRoutes.Home));
                          return const SizedBox.shrink();
                        }
                        return BlocProvider(
                          create: (context) => ReservationCubit(getIt()),
                          child: BookingConfirmation(arguments: args),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),

            // Booking Branch
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.Booking,
                  name: AppRoutes.bookingName,
                  builder: (context, state) => FutureBuilder(
                    future: booking.loadLibrary(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return booking.BookingScreen();
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),

            // Profile Branch
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.Profile,
                  name: AppRoutes.profileName,
                  builder: (context, state) => FutureBuilder(
                    future: profile.loadLibrary(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return profile.ProfileScreen();
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                  routes: [
                    GoRoute(
                      path: AppRoutes
                          .UpdateProfilePath, // Relative path for /profile/update
                      name: AppRoutes.updateProfileName,
                      builder: (context, state) {
                        final user = state.extra as User;
                        return UpdateProfileScreen(currentUser: user);
                      },
                    ),
                    GoRoute(
                      path: AppRoutes.PrivacyPolicyPath,
                      name: AppRoutes.privacyPolicyName,
                      builder: (context, state) => ContentScreen(
                        titleKey: 'privacy_policy.title',
                        sections: ContentData.getPrivacyPolicySections(),
                      ),
                    ),
                    GoRoute(
                      path: AppRoutes.HelpPath,
                      name: AppRoutes.helpName,
                      builder: (context, state) => ContentScreen(
                        titleKey: 'help.title',
                        sections: ContentData.getHelpSections(),
                      ),
                    ),
                    GoRoute(
                      path: AppRoutes.AboutPath,
                      name: AppRoutes.aboutName,
                      builder: (context, state) => ContentScreen(
                        titleKey: 'about.title',
                        sections: ContentData.getAboutSections(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        GoRoute(
          path: AppRoutes.Invoice,
          name: AppRoutes.invoiceName,
          builder: (context, state) {
            final reservation = state.extra as ReservationResponseModel;
            return FutureBuilder(
              future: invoice.loadLibrary(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return invoice.InvoiceScreen(arguments: reservation);
                }
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              },
            );
          },
        ),
      ],

      // Redirect logic for auth
      redirect: (context, state) {
        final isLoggingIn = state.matchedLocation == AppRoutes.Login;
        final isSigningUp = state.matchedLocation == AppRoutes.Signup;
        final isForgotPassword =
            state.matchedLocation == AppRoutes.ForgotPassword;
        final isResetPassword =
            state.matchedLocation == AppRoutes.ResetPassword;
        final isVerification = state.matchedLocation == AppRoutes.Verification;
        final isHome = state.matchedLocation.startsWith(AppRoutes.Home);

        // Allow auth screens even if not logged in
        if (isLoggingIn ||
            isSigningUp ||
            isForgotPassword ||
            isResetPassword ||
            isVerification ||
            isHome) {
          return null;
        }

        // Redirect to login if not logged in
        if (!isLoggedInUser) {
          return AppRoutes.Login;
        }

        return null;
      },

      // Error handling
      errorBuilder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<LoginCubit>()),
          BlocProvider(create: (context) => getIt<NotificationCubit>()),
        ],
        child: const LoginScreen(),
      ),
    );
  }
}
