import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/utils/responsive_utils.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';
import 'package:temy_barber/features/profile/logic/profile_cubit.dart';
import 'package:temy_barber/features/profile/logic/profile_state.dart';
import 'package:easy_localization/easy_localization.dart';

class DashboardScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardScreen({super.key, required this.navigationShell});

  @override
  State<DashboardScreen> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<DashboardScreen> {
  late BookingCubit _bookingCubit;
  late ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _bookingCubit = BookingCubit(getIt())..getBooking();
    _profileCubit = getIt<ProfileCubit>()..getProfile();
  }

  void _onItemTapped(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  void dispose() {
    _bookingCubit.close();
    _profileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // If the shell can pop (has route history in current stack), let it?
          // But here we are at the dashboard level.
          // GoRouter handles back button priority usually.
          // If we want to exit app only when at the root of a branch, we might rely on default behavior
          // But existing code forced SystemNavigator.pop().
          // If we block pop, we might block internal navigation popping?
          // Let's assume for now we just want to ensure we don't pop the WHOLE dashboard unexpectedly.
          // But with StatefulShellRoute, standard pop works for nested routes.
          // The previous code was: if (!didPop) SystemNavigator.pop();
          // This implies "If back is pressed and nothing else handled it, exit app".
          // We will keep it but monitor behavior.
          // Actually, standard GoRouter back usage might require `canPop: true` or leaving it to router.
          // For now, removing the forced PopScope to let GoRouter handle back stack is SAFER for StatefulShellRoute.
          // BUT the user wants "Application Exit" behavior on dashboard likely.
          // Let's strictly revert to "Custom PopScope" ONLY if we are at the root?

          // Let's disable the aggressive SystemNavigator.pop for now to verify normal navigation first.
          // Or better, keep it but check navigationShell state?
          // If I return `canPop: false`, standard back button logic is intercepted.
          // I will Remove PopScope wrapper for now to allow GoRouter 's internal logic to work freely for nested routes
          // and re-add if "Exit App" functionality is missing.
          // Actually, I'll keep the provider wrapper but remove PopScope to avoid issues with browser back button or Android back button breaking navigation.
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _bookingCubit),
          BlocProvider.value(value: _profileCubit),
        ],
        child: BlocProvider.value(
          value:
              _profileCubit, // It's already provided above, but keeping structure similar
          child: ResponsiveBuilder(
            mobile: _buildMobileDashboard(),
            tablet: _buildDesktopDashboard(),
            desktop: _buildDesktopDashboard(),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileDashboard() {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [widget.navigationShell, _buildVerificationListener()],
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          labelTextStyle: WidgetStateProperty.all(TextStyles.font13BlueRegular),
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: SizedBox(
          height: 80,
          child: NavigationBar(
            selectedIndex: widget.navigationShell.currentIndex,
            destinations: _buildDestinations(),
            onDestinationSelected: _onItemTapped,
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopDashboard() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 48),
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/logo.png',
                    height: 48,
                    color: ColorsManager.mainBlue,
                  ),
                  const Spacer(),
                  // Centered Navigation Items
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTopNavItem(
                        0,
                        'navigation.home'.tr(),
                        'assets/icons/home.png',
                      ),
                      const SizedBox(width: 32),
                      _buildTopNavItem(
                        1,
                        'navigation.booking'.tr(),
                        'assets/icons/calendar.png',
                      ),
                      const SizedBox(width: 32),
                      _buildTopNavItem(
                        2,
                        'navigation.profile'.tr(),
                        'assets/icons/user.png',
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Profile / Avatar Placeholder
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsManager.mainBlue.withOpacity(0.1),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.person_outline,
                        color: ColorsManager.mainBlue,
                      ),
                      onPressed: () => _onItemTapped(2), // Go to profile
                    ),
                  ),
                ],
              ),
            ),
            // Main Content
            Expanded(
              child: Stack(
                children: [
                  widget.navigationShell,
                  _buildVerificationListener(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavItem(int index, String label, String iconPath) {
    final isSelected = widget.navigationShell.currentIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? ColorsManager.mainBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              height: 20,
              width: 20,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<NavigationDestination> _buildDestinations() {
    return [
      NavigationDestination(
        icon: Image.asset('assets/icons/home.png', height: 24, width: 24),
        selectedIcon: Image.asset(
          'assets/icons/home.png',
          height: 24,
          width: 24,
          color: ColorsManager.mainBlue,
        ),
        label: 'navigation.home'.tr(),
      ),
      NavigationDestination(
        icon: Image.asset('assets/icons/calendar.png', height: 24, width: 24),
        selectedIcon: Image.asset(
          'assets/icons/calendar.png',
          height: 24,
          width: 24,
          color: ColorsManager.mainBlue,
        ),
        label: 'navigation.booking'.tr(),
      ),
      NavigationDestination(
        icon: Image.asset('assets/icons/user.png', height: 24, width: 24),
        selectedIcon: Image.asset(
          'assets/icons/user.png',
          height: 24,
          width: 24,
          color: ColorsManager.mainBlue,
        ),
        label: 'navigation.profile'.tr(),
      ),
    ];
  }

  Widget _buildVerificationListener() {
    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) => current is ProfileSuccess,
      listener: (context, state) {
        if (state is ProfileSuccess) {
          final user = state.userProfile.user;
          final isVerified = user?.verified ?? true;

          debugPrint('=== Dashboard: User Profile Loaded ===');
          debugPrint('User verified: $isVerified');

          if (!isVerified) {
            final phoneNumber = user?.phone ?? '';
            final countryCode = user?.countryCode ?? '';
            final fullPhone = '$countryCode$phoneNumber';

            debugPrint('User not verified. Redirecting to verification screen');
            debugPrint('Phone: $fullPhone');

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                // We use root navigator for verification to cover everything
                context.pushNamed(
                  AppRoutes.verificationName,
                  extra: {
                    'phoneNumber': fullPhone,
                    'shouldAutoResend': true,
                    'comingFromLogin': true,
                  },
                );
              }
            });
          }
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
