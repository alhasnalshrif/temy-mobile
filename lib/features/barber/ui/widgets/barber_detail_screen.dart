import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/barber/ui/widgets/rating_display.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/utils/responsive_utils.dart';
import 'package:temy_barber/features/barber/ui/widgets/tabs/service_tab.dart';
import 'package:temy_barber/features/reservations/ui/widgets/time_slot_section.dart';

class BarberScreenItem extends StatefulWidget {
  final BarberDetailData? serviceResponseModel;

  const BarberScreenItem({super.key, this.serviceResponseModel});

  @override
  State<BarberScreenItem> createState() => _BarberScreenItemState();
}

class _BarberScreenItemState extends State<BarberScreenItem> {
  final Set<BarberService> _selectedServices = {};
  double _selectedTotalPrice = 0.0;
  String? _selectedTime;

  int get _totalDuration => _selectedServices.fold(0, (t, s) => t + s.duration);

  void _onServiceSelected(BarberService service, double price, bool selected) {
    setState(() {
      if (selected) {
        _selectedServices.add(service);
        _selectedTotalPrice += price;
      } else {
        _selectedServices.remove(service);
        _selectedTotalPrice -= price;
      }
    });
  }

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
          mobile: _buildMobileLayout(),
          tablet: _buildDesktopLayout(),
          desktop: _buildDesktopLayout(),
        ),
      ),
    );
  }

  // ─── MOBILE ──────────────────────────────────────────────────────────────────

  Widget _buildMobileLayout() {
    final services = widget.serviceResponseModel?.services ?? [];
    final barberName = widget.serviceResponseModel?.name ?? 'barber.name'.tr();

    return Stack(
      children: [
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── Hero image — smooth collapse and fade ──
            SliverAppBar(
              expandedHeight: 220,
              pinned: true,
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1A1A2E),
              elevation: 0,
              // centerTitle: true,
              titleSpacing: 0,
              leadingWidth: 64,
              leading: Center(
                child: _circleBtn(
                  Icons.arrow_back_ios_new_rounded,
                  () => Navigator.of(context).pop(),
                ),
              ),
              title: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.5,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
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
                  widget.serviceResponseModel?.avatar ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: ColorsManager.mainBlue.withOpacity(0.15),
                  ),
                ),
              ),
              // White rounded shelf attached to the bottom of the app bar
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(24),
                child: Container(
                  height: 24,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
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
                ),
              ),
            ),

            // ── Barber info header ──
            // SliverToBoxAdapter(child: _buildBarberInfo()),

            // ── Section title ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                child: Text(
                  'barber.service_tab'.tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
              ),
            ),

            // ── Service items ──
            if (services.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Center(
                    child: Text(
                      'barber.no_services'.tr(),
                      style: TextStyles.font16GrayRegular,
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  100,
                ), // padding for floating button
                sliver: SliverList.separated(
                  itemCount: services.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return _ServiceCard(
                      service: service,
                      isSelected: _selectedServices.any(
                        (s) => s.id == service.id,
                      ),
                      onTap: () => _onServiceSelected(
                        service,
                        service.price.toDouble(),
                        !_selectedServices.any((s) => s.id == service.id),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),

        // ── Floating compact booking pill ──
        _buildFloatingBookingPill(),
      ],
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: ColorsManager.mainBlue, size: 20),
      ),
    );
  }

  Widget _buildBarberInfo() {
    final barber = widget.serviceResponseModel;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
      child: Row(
        children: [
          // Left: name + rating
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  barber?.name ?? 'barber.name'.tr(),
                  style: tt.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
              ],
            ),
          ),
          // Right: favorite
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite, color: Colors.red, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingBookingPill() {
    final bool has = _selectedServices.isNotEmpty;

    return Positioned(
      bottom: 32,
      left: 0,
      right: 0,
      child: SafeArea(
        child: IgnorePointer(
          ignoring: !has,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: has ? 1.0 : 0.0,
            curve: Curves.easeOut,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 400),
              offset: has ? Offset.zero : const Offset(0, 0.5),
              curve: Curves.easeOutBack,
              child: Center(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: ColorsManager.mainBlue,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: ColorsManager.mainBlue.withOpacity(0.35),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: has ? _navigateToReservation : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Price and duration
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: [
                            //     Text(
                            //       _priceText(_selectedTotalPrice),
                            //       style: const TextStyle(
                            //         color: Colors.white,
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: 16,
                            //       ),
                            //     ),
                            //     Text(
                            //       '$_totalDuration ${'barber.minutes'.tr()}',
                            //       style: TextStyle(
                            //         color: Colors.white.withOpacity(0.8),
                            //         fontSize: 12,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(width: 16),
                            // Divider
                            // Container(
                            //   height: 28,
                            //   width: 1.5,
                            //   color: Colors.white.withOpacity(0.2),
                            // ),
                            // const SizedBox(width: 16),
                            // Book Now Text
                            Text(
                              'barber.book_now'.tr(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToReservation() {
    context.pushGoNamed(
      AppRoutes.reservationName,
      pathParameters: {
        'barberId': widget.serviceResponseModel?.id.toString() ?? '',
      },
      extra: ReservationArguments(
        selectedServices: _selectedServices.toList(),
        barberData: widget.serviceResponseModel,
        totalPrice: _selectedTotalPrice,
        selectedTime: _selectedTime,
        selectedDate: DateTime.now(),
      ),
    );
  }

  // ─── DESKTOP ─────────────────────────────────────────────────────────────────

  Widget _buildDesktopLayout() {
    return Container(
      color: ColorsManager.background,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorsManager.moreLighterGray),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    const Divider(
                      height: 1,
                      color: ColorsManager.moreLighterGray,
                    ),
                    const SizedBox(height: 24),
                    _buildDesktopBookingButton(),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorsManager.moreLighterGray),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 400,
                      child: ServiceTab(
                        serviceResponseModel: widget.serviceResponseModel,
                        selectedServices: _selectedServices,
                        onServiceSelected: _onServiceSelected,
                      ),
                    ),
                    if (_selectedServices.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 24),
                      _buildTimeSlotSection(),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final barber = widget.serviceResponseModel;
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

  String _priceText(double price) =>
      'barber.price'.tr(args: [price.toStringAsFixed(0)]);

  Widget _buildDesktopBookingButton() {
    final bool hasSelection = _selectedServices.isNotEmpty;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: hasSelection ? ColorsManager.mainBlue : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: hasSelection ? _navigateToReservation : null,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              hasSelection
                  ? '${'barber.book_now'.tr()} - ${_priceText(_selectedTotalPrice)}'
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

  Widget _buildTimeSlotSection() {
    return TimeSlotSection(
      barberData: widget.serviceResponseModel,
      selectedTime: _selectedTime,
      onTimeSelected: (t) => setState(() => _selectedTime = t),
      totalDuration: _totalDuration,
    );
  }
}

// ─── Stateless service card (no rebuilds on parent setState) ──────────────────

class _ServiceCard extends StatelessWidget {
  final BarberService service;
  final bool isSelected;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isSelected ? ColorsManager.mainBlue.withAlpha(10) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? ColorsManager.mainBlue
              : ColorsManager.lighterGray,
          width: isSelected ? 2 : 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // Checkbox circle
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorsManager.mainBlue
                        : ColorsManager.moreLighterGray,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : ColorsManager.gray,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 16,
                        )
                      : null,
                ),
                const SizedBox(width: 14),
                // Name + duration
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name,
                        style: TextStyles.font13DarkBlueRegular,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            size: 14,
                            color: ColorsManager.gray,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'barber.duration'.tr(
                              args: [service.duration.toString()],
                            ),
                            style: TextStyles.font13GrayRegular,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Price badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorsManager.mainBlue
                        : ColorsManager.thirdfMain,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'barber.price'.tr(args: [service.price.toString()]),
                    style: isSelected
                        ? TextStyles.font14WhiteSemiBold
                        : TextStyles.font14BlueSemiBold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
