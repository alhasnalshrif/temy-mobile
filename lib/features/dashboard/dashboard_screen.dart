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

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    // Initialize the screens with their controllers
    _initializeScreens();
  }

  void _initializeScreens() {
    _widgetOptions = [
      BlocProvider(
        // create: (context) => HomeCubit(getIt())..getCategories(),
        create: (context) => HomeCubit(getIt())..getBarbers(),
        child: const HomeScreen(),
      ),
      BlocProvider(
        // create: (context) => HomeCubit(getIt())..getCategories(),
        create: (context) => BookingCubit(getIt())..getBooking(),
        child: const BookingScreen(),
      ),
      BlocProvider(
        create: (context) => ProfileCubit(getIt())..getProfile(),
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
        // child: _widgetOptions.elementAt(_selectedIndex),
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
              label: "Home",
            ),
            NavigationDestination(
              icon: Image.asset('assets/icons/calendar.png',
                  height: 40, width: 40),
              selectedIcon: Image.asset('assets/icons/calendar.png',
                  height: 40, width: 40, color: ColorsManager.mainBlue),
              label: 'Booking',
            ),
            NavigationDestination(
              icon: Image.asset('assets/icons/user.png', height: 40, width: 40),
              selectedIcon: Image.asset('assets/icons/user.png',
                  height: 40, width: 40, color: ColorsManager.mainBlue),
              label: 'Profile',
            ),
          ],
          onDestinationSelected: _onItemTapped,
        ),
      ),
    );
  }
}
