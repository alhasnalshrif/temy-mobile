import 'package:flutter/material.dart';
import 'package:flutter_complete_project/core/theme/colors.dart';
import 'package:flutter_complete_project/features/barber/data/models/barber_detail_response.dart';
import 'package:flutter_complete_project/features/barber/ui/widgets/tabs/about_tab.dart';
import 'package:flutter_complete_project/features/barber/ui/widgets/barber_image.dart';
import 'package:flutter_complete_project/features/barber/ui/widgets/rating_display.dart';
import 'package:flutter_complete_project/features/barber/ui/widgets/tabs/schedule_tab.dart';
import 'package:flutter_complete_project/features/barber/ui/widgets/tabs/service_tab.dart';
import 'package:flutter_complete_project/features/barber/ui/widgets/sliver_tab_bar_delegate.dart';

class BarberScreenItem extends StatefulWidget {
  final BarberDetailData? serviceResponseModel;

  const BarberScreenItem({
    super.key,
    this.serviceResponseModel,
  });

  @override
  State<BarberScreenItem> createState() => _BarberScreenItemState();
}

class _BarberScreenItemState extends State<BarberScreenItem>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFavorite = false;

  // Track selected service IDs
  final Set<String> _selectedServiceIds = {};
  double _selectedTotalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  // Update selection and price
  void _onServiceSelected(String id, double price, bool selected) {
    setState(() {
      if (selected) {
        _selectedServiceIds.add(id);
        _selectedTotalPrice += price;
      } else {
        _selectedServiceIds.remove(id);
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
        title: Text(
          widget.serviceResponseModel?.name ?? 'Barber Details',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorsManager.background,
        elevation: 0,
      ),
      backgroundColor: ColorsManager.background,
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(child: _buildHeader()),
                  SliverPersistentHeader(
                    delegate: SliverTabBarDelegate(tabBar: _buildTabBar()),
                    pinned: true,
                  ),
                ],
                body: _buildTabContent(),
              ),
            ),
          ),
          _buildBookingButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final textTheme = Theme.of(context).textTheme;
    final barber = widget.serviceResponseModel;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarberImage(
            imageUrl: barber?.avatar,
          ),
          const SizedBox(width: 16),
          // Name and details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  barber?.name ?? 'Barber Name',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                RatingDisplay(
                  rating: barber?.averageRating,
                  reviewCount: barber?.numberOfReviews,
                ),
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
        color: ColorsManager.mainBlue.withOpacity(0.1),
        border: Border.all(color: Theme.of(context).primaryColor, width: 1.5),
      ),
      indicatorPadding:
          const EdgeInsets.symmetric(vertical: 12, horizontal: -10),
      labelPadding: const EdgeInsets.symmetric(vertical: 8.0),
      dividerHeight: 0,
      tabs: const [
        Tab(text: 'Service'),
        Tab(text: 'Schedule'),
        Tab(text: 'About'),
      ],
    );
  }

  Widget _buildTabContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        ServiceTab(
          serviceResponseModel: widget.serviceResponseModel,
          selectedServiceIds: _selectedServiceIds,
          onServiceSelected: _onServiceSelected,
        ),
        ScheduleTab(serviceResponseModel: widget.serviceResponseModel),
        AboutTab(serviceResponseModel: widget.serviceResponseModel),
      ],
    );
  }

  Widget _buildBookingButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Material(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.2),
        child: InkWell(
          onTap: _selectedServiceIds.isEmpty
              ? null
              : () {
                  // TODO: Navigate to booking/checkout with selected IDs
                  // Example: Navigator.pushNamed(context, '/checkout', arguments: _selectedServiceIds.toList());
                },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: Text(
              _selectedServiceIds.isEmpty
                  ? 'Book Now'
                  : 'Book Now (EGP${_selectedTotalPrice.toStringAsFixed(0)})',
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
}
