import 'package:flutter/material.dart';
import 'package:flutter_complete_project/features/barber/data/models/barber_detail_response.dart';

class AboutTab extends StatelessWidget {
  final BarberDetailData? serviceResponseModel;

  const AboutTab({super.key, this.serviceResponseModel});

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
