import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/auth_helper.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/widgets/app_bars.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';
import 'package:temy_barber/features/booking/ui/widgets/booking_bloc_builder_with_queue.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ColorsManager.mainBlue,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return FutureBuilder<bool>(
      future: AuthHelper.isGuest(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBlueAppBar(title: 'booking.screen_title'.tr()),
            body: const Center(
              child: CircularProgressIndicator(color: ColorsManager.mainBlue),
            ),
          );
        }

        final isGuest = snapshot.data ?? true;

        if (isGuest) {
          return const GuestLoginScreen();
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBlueAppBar(title: 'booking.screen_title'.tr()),
          body: RefreshIndicator(
            color: ColorsManager.mainBlue,
            backgroundColor: Colors.white,
            onRefresh: () async {
              context.read<BookingCubit>().getBooking();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                width: double.infinity,
                alignment: Alignment.topCenter,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: const BookingBlocBuilderWithQueue(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
