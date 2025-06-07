import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';
import 'package:temy_barber/features/booking/ui/booking.dart';
import 'package:temy_barber/features/home/logic/home_cubit.dart';
import 'package:temy_barber/features/home/ui/home_screen.dart';
import 'package:temy_barber/features/profile/logic/profile_cubit.dart';
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

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTabIndex ?? 0;
    _bookingCubit = BookingCubit(getIt())..getBooking();
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
              ..getBanners(),
          ),
          BlocProvider.value(
            value: _bookingCubit,
          ),
        ],
        child: const HomeScreen(),
      ),
      BlocProvider.value(
        value: _bookingCubit,
        child: const BookingScreen(),
      ),
      BlocProvider(
        create: (context) => ProfileCubit(getIt(), getIt())..getProfile(),
        child: const ProfileScreen(),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          labelTextStyle: WidgetStateProperty.all(TextStyles.font13BlueRegular),
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.white,
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          destinations: [
            NavigationDestination(
              icon: Image.asset('assets/icons/home.png', height: 40, width: 40),
              selectedIcon: Image.asset('assets/icons/home.png',
                  height: 40, width: 40, color: ColorsManager.mainBlue),
              label: 'navigation.home'.tr(),
            ),
            NavigationDestination(
              icon: Image.asset('assets/icons/calendar.png',
                  height: 40, width: 40),
              selectedIcon: Image.asset('assets/icons/calendar.png',
                  height: 40, width: 40, color: ColorsManager.mainBlue),
              label: 'navigation.booking'.tr(),
            ),
            NavigationDestination(
              icon: Image.asset('assets/icons/user.png', height: 40, width: 40),
              selectedIcon: Image.asset('assets/icons/user.png',
                  height: 40, width: 40, color: ColorsManager.mainBlue),
              label: 'navigation.profile'.tr(),
            ),
          ],
          onDestinationSelected: _onItemTapped,
        ),
      ),
    );
  }
}
