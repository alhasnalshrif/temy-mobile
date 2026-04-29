import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/utils/responsive_utils.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/barber/logic/barber_service_selection_cubit.dart';
import 'package:temy_barber/features/barber/ui/widgets/floating_booking_button.dart';
import 'package:temy_barber/features/barber/ui/widgets/rating_display.dart';
import 'package:temy_barber/features/barber/ui/widgets/service_card.dart';
import 'package:temy_barber/features/barber/ui/widgets/tabs/service_tab.dart';
import 'package:temy_barber/features/reservations/ui/widgets/time_slot_section.dart';

class BarberScreenItem extends StatelessWidget {
  final BarberDetailData? serviceResponseModel;

  const BarberScreenItem({super.key, this.serviceResponseModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BarberServiceSelectionCubit(),
      child: _BarberScreenContent(serviceResponseModel: serviceResponseModel),
    );
  }
}

class _BarberScreenContent extends StatelessWidget {
  final BarberDetailData? serviceResponseModel;

  const _BarberScreenContent({super.key, required this.serviceResponseModel});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ResponsiveBuilder(
          mobile: _BarberMobileLayout(serviceResponseModel: serviceResponseModel),
          tablet: _BarberDesktopLayout(serviceResponseModel: serviceResponseModel),
          desktop: _BarberDesktopLayout(serviceResponseModel: serviceResponseModel),
        ),
      ),
    );
  }
}

/// Mobile layout for barber screen
class _BarberMobileLayout extends StatelessWidget {
  final BarberDetailData? serviceResponseModel;

  const _BarberMobileLayout({super.key, required this.serviceResponseModel});

  @override
  Widget build(BuildContext context) {
    final services = serviceResponseModel?.services ?? [];
    final barberName = serviceResponseModel?.name ?? 'barber.name'.tr();

    return Stack(
      children: [
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildSliverAppBar(context, barberName),
            _buildServiceSection(services),
          ],
        ),
        _buildFloatingBookingButton(context),
      ],
    );
  }

  Widget _buildSliverAppBar(BuildContext context, String barberName) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xFF1A1A2E),
      elevation: 0,
      titleSpacing: 0,
      leadingWidth: 64,
      leading: Center(
        child: _CircleBtn(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      title: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.5,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(191),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            barberName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A2E),
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          serviceResponseModel?.avatar ?? '',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: ColorsManager.mainBlue.withAlpha(38),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(24),
        child: _buildRoundedShelf(),
      ),
    );
  }

  Widget _buildRoundedShelf() {
    return Container(
      height: 24,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 8),
          width: 36,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceSection(List<dynamic> services) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
            child: Text(
              'barber.service_tab'.tr(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ),
          if (services.isEmpty)
            Padding(
              padding: const EdgeInsets.all(40),
              child: Center(
                child: Text('barber.no_services'.tr(), style: TextStyles.font16GrayRegular),
              ),
            )
          else
            BlocBuilder<BarberServiceSelectionCubit, BarberServiceSelectionState>(
              builder: (context, state) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  itemCount: services.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return ServiceSelectionCard(
                      service: service,
                      isSelected: state.selectedServices.any((s) => s.id == service.id),
                      onTap: () => context.read<BarberServiceSelectionCubit>().toggleService(
                        service,
                        service.price.toDouble(),
                      ),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildFloatingBookingButton(BuildContext context) {
    return BlocBuilder<BarberServiceSelectionCubit, BarberServiceSelectionState>(
      builder: (context, state) {
        return FloatingBookingButton(
          hasSelection: state.hasSelection,
          onTap: () => _navigateToReservation(context, state),
        );
      },
    );
  }

  void _navigateToReservation(BuildContext context, BarberServiceSelectionState state) {
    context.pushGoNamed(
      AppRoutes.reservationName,
      pathParameters: {
        'barberId': serviceResponseModel?.id.toString() ?? '',
      },
      extra: ReservationArguments(
        selectedServices: state.selectedServices.toList(),
        barberData: serviceResponseModel,
        totalPrice: state.totalPrice,
        selectedTime: state.selectedTime,
        selectedDate: DateTime.now(),
      ),
    );
  }
}

/// Desktop layout for barber screen
class _BarberDesktopLayout extends StatelessWidget {
  final BarberDetailData? serviceResponseModel;

  const _BarberDesktopLayout({super.key, required this.serviceResponseModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager.background,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: _buildBarberInfoCard()),
            const SizedBox(width: 24),
            Expanded(flex: 7, child: _buildServicesCard()),
          ],
        ),
      ),
    );
  }

  Widget _buildBarberInfoCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorsManager.moreLighterGray),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BarberHeader(barber: serviceResponseModel),
          const SizedBox(height: 24),
          const Divider(height: 1, color: ColorsManager.moreLighterGray),
          const SizedBox(height: 24),
          BlocBuilder<BarberServiceSelectionCubit, BarberServiceSelectionState>(
            builder: (context, state) {
              return _DesktopBookingButton(
                hasSelection: state.hasSelection,
                totalPrice: state.totalPrice,
                onTap: () => _navigateToReservation(context, state),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServicesCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorsManager.moreLighterGray),
      ),
      child: BlocBuilder<BarberServiceSelectionCubit, BarberServiceSelectionState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 400,
                child: ServiceTab(
                  serviceResponseModel: serviceResponseModel,
                  selectedServices: state.selectedServices,
                  onServiceSelected: (service, price, selected) {
                    context.read<BarberServiceSelectionCubit>().toggleService(service, price);
                  },
                ),
              ),
              if (state.hasSelection) ...[
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 24),
                TimeSlotSection(
                  barberData: serviceResponseModel,
                  selectedTime: state.selectedTime,
                  onTimeSelected: (t) => context.read<BarberServiceSelectionCubit>().selectTime(t),
                  totalDuration: state.totalDuration,
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  void _navigateToReservation(BuildContext context, BarberServiceSelectionState state) {
    context.pushGoNamed(
      AppRoutes.reservationName,
      pathParameters: {
        'barberId': serviceResponseModel?.id.toString() ?? '',
      },
      extra: ReservationArguments(
        selectedServices: state.selectedServices.toList(),
        barberData: serviceResponseModel,
        totalPrice: state.totalPrice,
        selectedTime: state.selectedTime,
        selectedDate: DateTime.now(),
      ),
    );
  }
}

/// Desktop booking button
class _DesktopBookingButton extends StatelessWidget {
  final bool hasSelection;
  final double totalPrice;
  final VoidCallback onTap;

  const _DesktopBookingButton({
    required this.hasSelection,
    required this.totalPrice,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: hasSelection ? ColorsManager.mainBlue : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: hasSelection ? onTap : null,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              hasSelection
                  ? '${'barber.book_now'.tr()} - ${totalPrice.toStringAsFixed(0)}'
                  : 'barber.select_service'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: hasSelection ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Barber header widget
class _BarberHeader extends StatelessWidget {
  final BarberDetailData? barber;

  const _BarberHeader({super.key, required this.barber});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ColorsManager.mainBlue, width: 2),
            image: DecorationImage(
              image: NetworkImage(barber?.avatar ?? ''),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          barber?.name ?? 'barber.name'.tr(),
          style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        RatingDisplay(rating: 5.0, reviewCount: barber?.rating.total ?? 0),
      ],
    );
  }
}

/// Circle button for navigation
class _CircleBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(230),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: ColorsManager.mainBlue, size: 20),
      ),
    );
  }
}
