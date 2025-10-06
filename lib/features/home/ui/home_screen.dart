import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/routes.dart';
import 'package:temy_barber/features/home/logic/home_cubit.dart';
import 'package:temy_barber/features/home/ui/widgets/banner/banner_bloc_builder.dart';
import 'package:temy_barber/features/home/ui/widgets/category/category_bloc_builder.dart';
import 'package:temy_barber/features/home/ui/widgets/category_sea_all.dart';
import 'package:temy_barber/features/home/ui/widgets/home_top_bar.dart';
import 'package:temy_barber/features/home/ui/widgets/next_booking_card.dart';
import 'package:temy_barber/features/home/ui/widgets/default_booking_card.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';

import 'package:temy_barber/features/profile/logic/profile_cubit.dart';
import 'package:temy_barber/features/profile/logic/profile_state.dart';

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
          child: Stack(
            children: [
              RefreshIndicator(
                color: Theme.of(context).primaryColor,
                backgroundColor: Colors.white,
                onRefresh: () async {
                  await context.read<HomeCubit>().refreshHomeData();
                  context.read<BookingCubit>().getBooking();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeTopBar(),
                      const DefaultBookingCard(),
                      const NextBookingCard(),
                      verticalSpace(16),
                      const BannerBlocBuilder(),
                      verticalSpace(24),
                      const DoctorSpecialitySeaAll(),
                      verticalSpace(10),
                      const CategoryBlocBuilder(),
                      verticalSpace(24),
                    ],
                  ),
                ),
              ),
              // Add verification check listener
              BlocListener<ProfileCubit, ProfileState>(
                listenWhen: (previous, current) => current is ProfileSuccess,
                listener: (context, state) {
                  if (state is ProfileSuccess) {
                    final user = state.userProfile.user;
                    final isVerified = user?.verified ?? true;

                    debugPrint('=== Home Screen: User Profile Loaded ===');
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
      ),
    );
  }
}
