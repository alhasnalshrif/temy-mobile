import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/utils/responsive_utils.dart';
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
        child: Stack(
          children: [
            RefreshIndicator(
              color: Theme.of(context).primaryColor,
              backgroundColor: Colors.white,
              onRefresh: () async {
                await context.read<HomeCubit>().refreshHomeData();
                context.read<BookingCubit>().getBooking();
              },
              child: ResponsiveBuilder(
                mobile: _buildMobileLayout(context),
                tablet: _buildTabletLayout(context),
                desktop: _buildDesktopLayout(context),
              ),
            ),
            _buildVerificationListener(),
          ],
        ),
      ),
    );
  }

  /// Mobile layout: Single column scroll.
  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 28),
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
    );
  }

  /// Tablet layout: Two-column with sidebar.
  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeTopBar(),
          verticalSpace(16),
          // Two-column layout for booking cards
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: DefaultBookingCard()),
              SizedBox(width: 16),
              Expanded(child: NextBookingCard()),
            ],
          ),
          verticalSpace(24),
          const BannerBlocBuilder(),
          verticalSpace(32),
          const DoctorSpecialitySeaAll(),
          verticalSpace(16),
          const CategoryBlocBuilder(),
          verticalSpace(24),
        ],
      ),
    );
  }

  /// Desktop layout: Mobile logic with web UI design.
  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeTopBar(),
              verticalSpace(40),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(24),
                child: const DefaultBookingCard(),
              ),
              verticalSpace(20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(24),
                child: const NextBookingCard(),
              ),
              verticalSpace(40),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.hardEdge,
                child: const BannerBlocBuilder(),
              ),
              verticalSpace(48),
              const DoctorSpecialitySeaAll(),
              verticalSpace(20),
              const CategoryBlocBuilder(),
              verticalSpace(40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerificationListener() {
    return BlocListener<ProfileCubit, ProfileState>(
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

            debugPrint('User not verified. Redirecting to verification screen');
            debugPrint('Phone: $fullPhone');

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                context.goNamed(
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
