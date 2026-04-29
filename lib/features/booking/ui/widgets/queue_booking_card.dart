import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/widgets/cancel_confirmation_dialog.dart';
import 'package:temy_barber/core/widgets/status_widgets.dart';
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
      builder: (dialogContext) => CancelConfirmationDialog(
        onConfirm: () {
          if (booking.id != null) {
            context.read<BookingCubit>().cancelBooking(booking.id!);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('booking.error_cancel_no_id'.tr()),
                backgroundColor: ColorsManager.red,
              ),
            );
          }
        },
      ),
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
          _buildHeader(context, queueStatus, isWaiting, isCancelled, isSkipped),
          verticalSpace(16),
          const Divider(),
          verticalSpace(16),
          QueueInfoSection(
            status: queueStatus,
            queuePosition: booking.queuePosition,
            date: booking.date,
            joinedAt: booking.joinedQueueAt,
          ),
          verticalSpace(16),
          ServicesListView(booking: booking.services ?? []),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    String queueStatus,
    bool isWaiting,
    bool isCancelled,
    bool isSkipped,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: BarberSection(
            name: booking.barber?.name ?? 'booking.default_barber_name'.tr(),
            avatarUrl: booking.barber?.avatar,
            location: 'booking.default_location'.tr(),
            rating: '5.0',
            reviewCount: 24,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            QueueStatusBadge(queueNumber: booking.queueNumber ?? 0, status: queueStatus),
            verticalSpace(8),
            StatusBadge(status: queueStatus),
            verticalSpace(8),
            if (isWaiting)
              _CancelButton(context)
            else if (isCancelled || isSkipped)
              _CancelledIndicator(isSkipped: isSkipped),
          ],
        ),
      ],
    );
  }

  Widget _CancelButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.red,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () => _showCancelConfirmation(context),
      child: Text(
        'cancel'.tr(),
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _CancelledIndicator({bool isSkipped = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: ColorsManager.red.withAlpha(25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorsManager.red),
      ),
      child: Text(
        isSkipped ? 'SKIPPED' : 'CANCELLED',
        style: const TextStyle(color: ColorsManager.red, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}
