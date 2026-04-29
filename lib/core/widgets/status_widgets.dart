import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';

/// Status badge widget for displaying status
class StatusBadge extends StatelessWidget {
  final String status;
  final String? customText;
  final Color? customColor;
  final Color? backgroundColor;
  final bool isUppercase;

  const StatusBadge({
    super.key,
    required this.status,
    this.customText,
    this.customColor,
    this.backgroundColor,
    this.isUppercase = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = customColor ?? _getColorForStatus(status);
    final text = customText ?? (isUppercase ? status.toUpperCase() : status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? color.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getColorForStatus(String status) {
    switch (status.toLowerCase()) {
      case 'waiting':
      case 'pending':
        return Colors.orange;
      case 'in_service':
      case 'confirmed':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'skipped':
      case 'cancelled':
        return ColorsManager.red;
      default:
        return Colors.grey;
    }
  }
}

/// Queue status badge with icon
class QueueStatusBadge extends StatelessWidget {
  final int queueNumber;
  final String status;

  const QueueStatusBadge({
    super.key,
    required this.queueNumber,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: ColorsManager.mainBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.confirmation_number, color: Colors.white, size: 14),
          const SizedBox(width: 4),
          Text(
            '#$queueNumber',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

/// Info item for displaying icon, label, and value
class InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const InfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}

/// Queue info section for displaying queue status information
class QueueInfoSection extends StatelessWidget {
  final String status;
  final int? queuePosition;
  final String? date;
  final String? joinedAt;

  const QueueInfoSection({
    super.key,
    required this.status,
    this.queuePosition,
    this.date,
    this.joinedAt,
  });

  bool get isWaiting => status == 'waiting';
  bool get isInService => status == 'in_service';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _getStatusColor().withAlpha(25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _getStatusColor().withAlpha(75)),
      ),
      child: Column(
        children: [
          if (isWaiting) _buildWaitingInfo(),
          if (isInService) _buildInServiceInfo(),
          if (!isInService && !isWaiting) _buildDateTimeInfo(),
        ],
      ),
    );
  }

  Widget _buildWaitingInfo() {
    return Row(
      children: [
        Expanded(
          child: InfoItem(
            icon: Icons.people,
            label: 'booking.queue_position'.tr(),
            value: '#$queuePosition',
            color: Colors.orange,
          ),
        ),
        Container(
          width: 1,
          height: 40,
          color: Colors.grey[300],
          margin: const EdgeInsets.symmetric(horizontal: 12),
        ),
        Expanded(
          child: InfoItem(
            icon: Icons.person_outline,
            label: 'booking.people_ahead'.tr(),
            value: '${(queuePosition ?? 1) - 1} ${'booking.people'.tr()}',
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildInServiceInfo() {
    return Row(
      children: [
        const Icon(Icons.cut, color: Colors.green, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'queue.service_in_progress'.tr(),
            style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.calendar_today, size: 16, color: _getStatusColor()),
        const SizedBox(width: 4),
        Text(
          _formatDate(date),
          style: TextStyle(color: _getStatusColor(), fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 16),
        Icon(Icons.access_time, size: 16, color: _getStatusColor()),
        const SizedBox(width: 4),
        Text(
          _formatTime(joinedAt),
          style: TextStyle(color: _getStatusColor(), fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (status) {
      case 'waiting':
        return Colors.orange;
      case 'in_service':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'skipped':
        return ColorsManager.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return '${date.month}/${date.day}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _formatTime(String? timeString) {
    if (timeString == null) return 'N/A';
    try {
      final time = DateTime.parse(timeString);
      final hour = time.hour.toString().padLeft(2, '0');
      final minute = time.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } catch (e) {
      return timeString;
    }
  }
}
