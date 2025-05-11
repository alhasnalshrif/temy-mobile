import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/features/home/logic/home_cubit.dart';
import 'package:temy_barber/features/home/ui/widgets/banner/banner_bloc_builder.dart';
import 'package:temy_barber/features/home/ui/widgets/category/category_bloc_builder.dart';
import 'package:temy_barber/features/home/ui/widgets/category_sea_all.dart';
import 'package:temy_barber/features/home/ui/widgets/home_top_bar.dart';
import 'package:temy_barber/features/home/ui/widgets/next_booking_card.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';

// import 'widgets/banner_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: RefreshIndicator(
            color: Theme.of(context).primaryColor,
            backgroundColor: Colors.white,
            onRefresh: () async {
              // Refresh all home screen data
              await context.read<HomeCubit>().refreshHomeData();
              // Also refresh bookings data to get the latest booking
              context.read<BookingCubit>().getBooking();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeTopBar(),
                  // Add next booking card here - it will automatically show or hide based on booking data
                  const NextBookingCard(),
                  verticalSpace(16),
                  const BannerBlocBuilder(),
                  verticalSpace(24),

                  // const BannerCard(),
                  const DoctorSpecialitySeaAll(),
                  verticalSpace(10),
                  const CategoryBlocBuilder(),
                  // const HomeBlocBuilder(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
