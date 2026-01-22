import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/routes.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';
import 'package:temy_barber/features/booking/ui/booking.dart';
import 'package:temy_barber/features/home/logic/home_cubit.dart';
import 'package:temy_barber/features/home/ui/home_screen.dart';
import 'package:temy_barber/features/profile/logic/profile_cubit.dart';
import 'package:temy_barber/features/profile/logic/profile_state.dart';
import 'package:temy_barber/features/profile/ui/profile.dart';
import 'package:easy_localization/easy_localization.dart';

class DashboardScreen extends StatefulWidget {
  final int? initialTabIndex;

  const DashboardScreen({super.key, this.initialTabIndex});

  @override
  State<DashboardScreen> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<DashboardScreen> {
  late int _selectedIndex;
  late List<Widget> _widgetOptions;
  late BookingCubit _bookingCubit;
  late ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTabIndex ?? 0;
    _bookingCubit = BookingCubit(getIt())..getBooking();
    _profileCubit = getIt<ProfileCubit>()..getProfile();
    _initializeScreens();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null &&
        args is int &&
        args >= 0 &&
        args < _widgetOptions.length) {
      setState(() {
        _selectedIndex = args;
      });
    }
  }

  void _initializeScreens() {
    _widgetOptions = [
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit(getIt())
              ..getCategories()
              // ..getBarbers()
              ..getBanners(),
          ),
          BlocProvider.value(value: _bookingCubit),
          BlocProvider.value(value: _profileCubit),
        ],
        child: const HomeScreen(),
      ),
      BlocProvider.value(value: _bookingCubit, child: const BookingScreen()),
      BlocProvider.value(value: _profileCubit, child: const ProfileScreen()),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      canPop: false, // Prevent back navigation to login
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // Exit the app when back button is pressed
          SystemNavigator.pop();
        }
      },
      child: BlocProvider.value(
        value: _profileCubit,
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                IndexedStack(index: _selectedIndex, children: _widgetOptions),
                // Add verification check listener at dashboard level
                BlocListener<ProfileCubit, ProfileState>(
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

                        debugPrint(
                          'User not verified. Redirecting to verification screen',
                        );
                        debugPrint('Phone: $fullPhone');

                        // Navigate after the current frame to avoid build scope errors
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (context.mounted) {
                            context.pushReplacementNamed(
                              Routes.verificationScreen,
                              arguments: {
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
                ),
              ],
            ),
          ),
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: Colors.white,
              indicatorColor: Colors.white,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              labelTextStyle: WidgetStateProperty.all(
                TextStyles.font13BlueRegular,
              ),
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.white,
            ),
            child: SizedBox(
              height: 80,
              child: NavigationBar(
                selectedIndex: _selectedIndex,
                destinations: [
                  NavigationDestination(
                    icon: Image.asset(
                      'assets/icons/home.png',
                      height: 24,
                      width: 24,
                    ),
                    selectedIcon: Image.asset(
                      'assets/icons/home.png',
                      height: 24,
                      width: 24,
                      color: ColorsManager.mainBlue,
                    ),
                    label: 'navigation.home'.tr(),
                  ),
                  NavigationDestination(
                    icon: Image.asset(
                      'assets/icons/calendar.png',
                      height: 24,
                      width: 24,
                    ),
                    selectedIcon: Image.asset(
                      'assets/icons/calendar.png',
                      height: 24,
                      width: 24,
                      color: ColorsManager.mainBlue,
                    ),
                    label: 'navigation.booking'.tr(),
                  ),
                  NavigationDestination(
                    icon: Image.asset(
                      'assets/icons/user.png',
                      height: 24,
                      width: 24,
                    ),
                    selectedIcon: Image.asset(
                      'assets/icons/user.png',
                      height: 24,
                      width: 24,
                      color: ColorsManager.mainBlue,
                    ),
                    label: 'navigation.profile'.tr(),
                  ),
                ],
                onDestinationSelected: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
