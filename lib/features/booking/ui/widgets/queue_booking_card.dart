import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';
import 'package:temy_barber/features/booking/ui/widgets/barber_section.dart';
import 'package:temy_barber/features/booking/ui/widgets/services_list_view.dart';

class QueueBookingCard extends StatelessWidget {
  final BookingData booking;
  final VoidCallback? onCancelBooking;
  final VoidCallback? onViewDetails;

  const QueueBookingCard({
    super.key,
    required this.booking,
    this.onCancelBooking,
    this.onViewDetails,
  });

  void _showCancelConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext dialogContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(dialogContext).viewInsets.bottom,
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'booking.cancel_title'.tr(),
                style: Theme.of(dialogContext).textTheme.headlineSmall
                    ?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12.0),
              Text(
                'booking.cancel_message'.tr(),
                style: Theme.of(
                  dialogContext,
                ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24.0),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'booking.keep_booking'.tr(),
                        style: Theme.of(
                          dialogContext,
                        ).textTheme.labelLarge?.copyWith(color: Colors.black87),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        if (booking.id != null) {
                          context.read<BookingCubit>().cancelBooking(
                            booking.id!,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('booking.error_cancel_no_id'.tr()),
                              backgroundColor: ColorsManager.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        backgroundColor: ColorsManager.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'booking.confirm_cancel'.tr(),
                        style: Theme.of(
                          dialogContext,
                        ).textTheme.labelLarge?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final queueStatus = booking.queueStatus ?? 'waiting';
    final isWaiting = queueStatus == 'waiting';
    final isSkipped = queueStatus == 'skipped';
    final isCancelled = booking.status == 'cancelled';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withAlpha(50)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BarberSection(
                  name:
                      booking.barber?.name ??
                      'booking.default_barber_name'.tr(),
                  avatarUrl: booking.barber?.avatar,
                  location: 'booking.default_location'.tr(),
                  rating: '5.0',
                  reviewCount: 24,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Queue number badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsManager.mainBlue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.confirmation_number,
                          color: Colors.white,
                          size: 14,
                        ),
                        horizontalSpace(4),
                        Text(
                          '#${booking.queueNumber ?? 0}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(8),
                  // Status badge
                  _buildStatusBadge(queueStatus),
                  // Cancel button for waiting status
                  if (isWaiting) ...[
                    verticalSpace(8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () => _showCancelConfirmation(context),
                      child: Text(
                        'cancel'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                  // Cancelled indicator
                  if (isCancelled || isSkipped) ...[
                    verticalSpace(8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: ColorsManager.red.withAlpha(25),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ColorsManager.red),
                      ),
                      child: Text(
                        isSkipped ? 'SKIPPED' : 'CANCELLED',
                        style: const TextStyle(
                          color: ColorsManager.red,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          verticalSpace(16),
          const Divider(),
          verticalSpace(16),

          // Queue Info Section
          _buildQueueInfoSection(queueStatus),

          verticalSpace(16),

          // Services List
          ServicesListView(booking: booking.services ?? []),
        ],
      ),
    );
  }

  Widget _buildQueueInfoSection(String queueStatus) {
    final isWaiting = queueStatus == 'waiting';
    final isInService = queueStatus == 'in_service';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _getStatusColor(queueStatus).withAlpha(25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _getStatusColor(queueStatus).withAlpha(75)),
      ),
      child: Column(
        children: [
          // Queue position and wait time (for waiting status)
          if (isWaiting)
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    icon: Icons.people,
                    label: 'booking.queue_position'.tr(),
                    value: '#${booking.queuePosition ?? 0}',
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
                  child: _buildInfoItem(
                    icon: Icons.person_outline,
                    label: 'booking.people_ahead'.tr(),
                    value:
                        '${((booking.queuePosition ?? 1) - 1).toString()} ${'booking.people'.tr()}',
                    color: Colors.orange,
                  ),
                ),
              ],
            ),

          // Service in progress (for in_service status)
          if (isInService)
            Row(
              children: [
                const Icon(Icons.cut, color: Colors.green, size: 24),
                horizontalSpace(12),
                Expanded(
                  child: Text(
                    'queue.service_in_progress'.tr(),
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),

          // Date and time info
          if (!isInService && !isWaiting)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: _getStatusColor(queueStatus),
                ),
                horizontalSpace(4),
                Text(
                  _formatDate(booking.date),
                  style: TextStyle(
                    color: _getStatusColor(queueStatus),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                horizontalSpace(16),
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: _getStatusColor(queueStatus),
                ),
                horizontalSpace(4),
                Text(
                  _formatTime(booking.joinedQueueAt),
                  style: TextStyle(
                    color: _getStatusColor(queueStatus),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        verticalSpace(4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
        verticalSpace(2),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withAlpha(25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getStatusColor(status)),
      ),
      child: Text(
        _getStatusText(status),
        style: TextStyle(
          color: _getStatusColor(status),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
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

  String _getStatusText(String status) {
    switch (status) {
      case 'waiting':
        return 'WAITING';
      case 'in_service':
        return 'IN SERVICE';
      case 'completed':
        return 'COMPLETED';
      case 'skipped':
        return 'SKIPPED';
      default:
        return status.toUpperCase();
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  String _formatTime(String? timeString) {
    if (timeString == null) return 'N/A';
    try {
      final time = DateTime.parse(timeString);
      return DateFormat('hh:mm a').format(time);
    } catch (e) {
      return timeString;
    }
  }
}
