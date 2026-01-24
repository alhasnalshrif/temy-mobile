import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:temy_barber/features/reservations/ui/widgets/common_widgets.dart';

/// Displays the list of selected services with their details
class ServicesSection extends StatelessWidget {
  final List<BarberService> services;

  const ServicesSection({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          if (services.isEmpty) _buildEmptyState() else _buildServicesList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SectionHeader(
        title: 'booking.required_services'.tr(),
        badge: CountBadge(count: '${services.length}'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return EmptyStateWidget(
      icon: Icons.shopping_bag_outlined,
      message: 'booking.no_services_selected'.tr(),
    );
  }

  Widget _buildServicesList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      separatorBuilder: (_, __) => const Divider(
        height: 1,
        thickness: 1,
        color: ColorsManager.lightBlue,
        indent: 16,
        endIndent: 16,
      ),
      itemBuilder: (_, index) => _ServiceItem(service: services[index]),
    );
  }
}

/// Individual service item widget
class _ServiceItem extends StatelessWidget {
  final BarberService service;

  const _ServiceItem({required this.service});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          _buildServiceImage(),
          const SizedBox(width: 16),
          Expanded(child: _buildServiceName()),
          const SizedBox(width: 8),
          _buildPriceAndDuration(),
        ],
      ),
    );
  }

  Widget _buildServiceImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 50,
        height: 50,
        child: Image.network(
          service.imageCover ?? '',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: Colors.grey[200],
            child: Image.asset('assets/images/temy.png', fit: BoxFit.fitWidth),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceName() {
    return Text(service.name, style: TextStyles.font15DarkBlueMedium);
  }

  Widget _buildPriceAndDuration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'EGP ${service.price.toStringAsFixed(0)}',
          style: TextStyles.font16DarkBold,
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: ColorsManager.thirdfMain,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '${service.duration} ${'booking.min'.tr()}',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: ColorsManager.darkBlue,
            ),
          ),
        ),
      ],
    );
  }
}
