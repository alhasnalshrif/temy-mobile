import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_complete_project/core/theme/colors.dart';
import 'package:flutter_complete_project/features/barber/data/models/barber_detail_response.dart';
import 'package:shimmer/shimmer.dart';

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

  // Add: Track selected service IDs
  final Set<String> _selectedServiceIds = {};
  double _selectedTotalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  // Add: Update selection and price
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
                    delegate: _SliverTabBarDelegate(tabBar: _buildTabBar()),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CategoryImage(
            imageUrl: barber?.avatar,
            backgroundColor: ColorsManager.background,
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  barber?.name ?? 'Barber Name',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.share_outlined),
                    onPressed: () {},
                    tooltip: 'Share',
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    tooltip: isFavorite
                        ? 'Remove from favorites'
                        : 'Add to favorites',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          _RatingDisplay(
            rating: barber?.averageRating,
            reviewCount: barber?.numberOfReviews,
          ),
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

  // Update: Pass selection handler and selected IDs to ServiceTab
  Widget _buildTabContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        _ServiceTab(
          serviceResponseModel: widget.serviceResponseModel,
          selectedServiceIds: _selectedServiceIds,
          onServiceSelected: _onServiceSelected,
        ),
        _ScheduleTab(serviceResponseModel: widget.serviceResponseModel),
        _AboutTab(serviceResponseModel: widget.serviceResponseModel),
      ],
    );
  }

  // Update: Show total price and pass selected IDs on booking
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

class _RatingDisplay extends StatelessWidget {
  final double? rating;
  final int? reviewCount;

  const _RatingDisplay({this.rating, this.reviewCount});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final displayRating = rating?.toStringAsFixed(1) ?? "N/A";
    final displayReviewCount = reviewCount ?? 0;

    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 18),
        const SizedBox(width: 4),
        Text(
          displayRating,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 4),
        Text(
          '($displayReviewCount Reviews)',
          style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate({required this.tabBar});

  @override
  double get minExtent => tabBar.preferredSize.height + 16;
  @override
  double get maxExtent => tabBar.preferredSize.height + 16;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: ColorsManager.thirdfMain,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}

class _AboutTab extends StatelessWidget {
  final BarberDetailData? serviceResponseModel;

  const _AboutTab({this.serviceResponseModel});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      physics: const ClampingScrollPhysics(),
      children: [
        Text(
          'Description',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          serviceResponseModel?.about ?? 'No description available.',
          style: textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
        ),
        const SizedBox(height: 24),
        const _AvailableHoursSection(),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _AvailableHoursSection extends StatelessWidget {
  const _AvailableHoursSection();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Hours',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        const _TimeRow('Monday - Friday', '09:00 am - 08:00 pm'),
        const SizedBox(height: 4),
        const _TimeRow('Saturday - Sunday', '09:00 am - 09:00 pm'),
      ],
    );
  }
}

class _TimeRow extends StatelessWidget {
  final String days;
  final String hours;

  const _TimeRow(this.days, this.hours);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(days,
            style: textTheme.bodyMedium?.copyWith(color: Colors.grey[700])),
        Text(
          hours,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

// Update: Enhanced ServiceTab with selection and improved design
class _ServiceTab extends StatelessWidget {
  final BarberDetailData? serviceResponseModel;
  final Set<String>? selectedServiceIds;
  final void Function(String id, double price, bool selected)?
      onServiceSelected;

  const _ServiceTab({
    this.serviceResponseModel,
    this.selectedServiceIds,
    this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    final services = serviceResponseModel?.services ?? [];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: services.isEmpty
          ? const Center(child: Text('No services available.'))
          : ListView.separated(
              itemCount: services.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final service = services[index];
                final isSelected =
                    selectedServiceIds?.contains(service.id) ?? false;
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: onServiceSelected == null
                      ? null
                      : () => onServiceSelected!(
                            service.id,
                            service.price.toDouble(),
                            !(isSelected),
                          ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).primaryColor.withOpacity(0.08)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300]!,
                        width: isSelected ? 2 : 0,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundImage: CachedNetworkImageProvider(
                          service.imageCover,
                        ),
                        backgroundColor: Colors.grey[200],
                      ),
                      title: Text(
                        service.name,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      subtitle: Text(
                        service.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'EGP ${service.price.toStringAsFixed(0)}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: ColorsManager.darkBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _ScheduleTab extends StatelessWidget {
  final BarberDetailData? serviceResponseModel;
  const _ScheduleTab({this.serviceResponseModel});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Scheduling Information Goes Here'),
      ),
    );
  }
}

class _CategoryImage extends StatelessWidget {
  final String? imageUrl;
  final Color backgroundColor;

  const _CategoryImage({
    required this.imageUrl,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    const double height = 180;
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: hasImage
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                width: double.infinity,
                height: height,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 300),
                placeholder: (context, url) => _buildShimmer(height),
                errorWidget: (context, url, error) => _buildError(height),
              )
            : Container(
                color: backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildShimmer(double height) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: double.infinity,
          height: height,
          color: Colors.white,
        ),
      );

  Widget _buildError(double height) => Container(
        width: double.infinity,
        height: height,
        color: Colors.grey[100],
        child: Center(
          child: Icon(
            Icons.broken_image_outlined,
            size: 48,
            color: Colors.grey[400],
          ),
        ),
      );
}
