import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/barber/ui/widgets/barber_image.dart';
import 'package:temy_barber/features/barber/ui/widgets/rating_display.dart';
import 'package:temy_barber/features/barber/ui/widgets/tabs/schedule_tab.dart';
import 'package:temy_barber/features/barber/ui/widgets/tabs/service_tab.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/utils/responsive_utils.dart';
import 'package:temy_barber/features/reservations/logic/time_slot_logic.dart';
import 'package:temy_barber/features/reservations/ui/widgets/time_slot_section.dart';

class BarberScreenItem extends StatefulWidget {
  final BarberDetailData? serviceResponseModel;

  const BarberScreenItem({super.key, this.serviceResponseModel});

  @override
  State<BarberScreenItem> createState() => _BarberScreenItemState();
}

class _BarberScreenItemState extends State<BarberScreenItem>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFavorite = false;

  // Track selected service IDs
  final Set<BarberService> _selectedServices = {};
  double _selectedTotalPrice = 0.0;
  String? _selectedTime;

  // Calculate total duration in minutes
  int get _totalDuration {
    return _selectedServices.fold(
      0,
      (total, service) => total + service.duration,
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // Update selection and price
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          widget.serviceResponseModel?.name ?? 'barber.details'.tr(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorsManager.mainBlue,
        elevation: 0,
      ),
      backgroundColor: ColorsManager.background,
      body: ResponsiveBuilder(
        mobile: _buildMobileLayout(),
        tablet: _buildDesktopLayout(),
        desktop: _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(child: _buildHeader()),
              
              ],
              body: _buildTabContent(),
            ),
          ),
        ),
       
        _buildBookingButton(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      color: ColorsManager.background,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(24.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column: Barber Info & Booking Action (30%)
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
                    _buildHeader(isDesktop: true),
                    const SizedBox(height: 24),
                    const Divider(
                      height: 1,
                      color: ColorsManager.moreLighterGray,
                    ),
                    const SizedBox(height: 24),
                    _buildBookingButton(),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 24),
            // Right Column: Tabs & Content (70%)
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorsManager.moreLighterGray),
                ),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTabBar(),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 400, // Fixed height for tab content
                        child: _buildTabContent(),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader({bool isDesktop = false}) {
    final textTheme = Theme.of(context).textTheme;
    final barber = widget.serviceResponseModel;

    if (isDesktop) {
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
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          RatingDisplay(rating: 5.0, reviewCount: barber?.rating.total ?? 0),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.lightBlue,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorsManager.moreLighterGray),
      ),
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarberImage(imageUrl: barber?.avatar),
          const SizedBox(width: 16),
          // Name and details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  barber?.name ?? 'barber.name'.tr(),
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (barber?.workingHours != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: ColorsManager.mainBlue,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _getWorkingDays(barber?.workingHours.daysOff),
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 8),

                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: ColorsManager.mainBlue,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${const TimeSlotLogic().formatTimeForDisplay(barber?.workingHours.start ?? "")} - ${const TimeSlotLogic().formatTimeForDisplay(barber?.workingHours.end ?? "")}',
                      style: textTheme.bodyMedium?.copyWith(
                        color: ColorsManager.mainBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // RatingDisplay(
                //   rating: 5.0,
                //   // rating: barber?.rating.average ?? 0.0,
                //   reviewCount: barber?.rating.total ?? 0,
                // ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: Theme.of(context).primaryColor,
      unselectedLabelColor: Colors.grey[600],
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorsManager.mainBlue.withAlpha(25),
        border: Border.all(color: Theme.of(context).primaryColor, width: 1.5),
      ),
      indicatorPadding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: -10,
      ),
      labelPadding: const EdgeInsets.symmetric(vertical: 8.0),
      dividerHeight: 0,
      tabs: [
        Tab(text: 'barber.service_tab'.tr()),
        Tab(text: 'barber.schedule_tab'.tr()),
      ],
    );
  }

  Widget _buildTabContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        ServiceTab(
          serviceResponseModel: widget.serviceResponseModel,
          selectedServices: _selectedServices,
          onServiceSelected: _onServiceSelected,
        ),
        ScheduleTab(serviceResponseModel: widget.serviceResponseModel),
      ],
    );
  }

  Widget _buildBookingButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Material(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
        shadowColor: Colors.transparent,
        child: InkWell(
          onTap: _selectedServices.isEmpty
              ? null
              : () {
                  final args = ReservationArguments(
                    selectedServices: _selectedServices.toList(),
                    barberData: widget.serviceResponseModel,
                    totalPrice: _selectedTotalPrice,
                    selectedTime: _selectedTime,
                    selectedDate: DateTime.now(),
                  );
                  context.goNamed(
                    AppRoutes.reservationName,
                    pathParameters: {
                      'barberId':
                          widget.serviceResponseModel?.id.toString() ?? '',
                    },
                    extra: args,
                  );
                },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: Text(
              _selectedServices.isEmpty
                  ? 'barber.book_now'.tr()
                  : '${'barber.book_now'.tr()} (${_priceText(_selectedTotalPrice)})',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _priceText(double price) {
    return 'barber.price'.tr(args: [price.toStringAsFixed(0)]);
  }

  Widget _buildTimeSlotSection() {
    return TimeSlotSection(
      barberData: widget.serviceResponseModel,
      selectedTime: _selectedTime,
      onTimeSelected: (time) {
        setState(() {
          _selectedTime = time;
        });
      },
      totalDuration: _totalDuration,
    );
  }

  String _getWorkingDays(List<int>? daysOff) {
    if (daysOff == null || daysOff.isEmpty) return 'Mon - Sun';
    if (daysOff.contains(7) && daysOff.length == 1) return 'Mon - Sat';
    if (daysOff.contains(6) && daysOff.contains(7) && daysOff.length == 2) {
      return 'Mon - Fri';
    }
    return 'Mon - Sun';
  }
}
