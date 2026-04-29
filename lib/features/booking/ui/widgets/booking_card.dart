import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/widgets/cancel_confirmation_dialog.dart';
import 'package:temy_barber/core/widgets/snackbar_helper.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';
import 'package:temy_barber/features/booking/ui/widgets/barber_section.dart';
import 'package:temy_barber/features/booking/ui/widgets/cancelled_indicator.dart';
import 'package:temy_barber/features/booking/ui/widgets/date_time_section.dart';
import 'package:temy_barber/features/booking/ui/widgets/services_list_view.dart';

class BookingCard extends StatelessWidget {
  final BookingData booking;

  const BookingCard({super.key, required this.booking});

  void _showCancelConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext dialogContext) {
        return CancelConfirmationDialog(
          onConfirm: () {
            if (booking.id != null) {
              context.read<BookingCubit>().cancelBooking(booking.id!);
            } else {
              SnackbarHelper.showError(context, 'booking.error_cancel_no_id'.tr());
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isCancelled = booking.status == 'cancelled';
    bool isPending = booking.status == 'pending';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        border: Border.all(color: Colors.grey.withAlpha(50)),

        borderRadius: BorderRadius.circular(12),
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
              if (isPending)
                Container(
                  margin: const EdgeInsets.only(top: 4, left: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () => _showCancelConfirmation(context),
                    child: Text(
                      'common.cancel'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              if (isCancelled) const CancelledIndicator(),
            ],
          ),
          verticalSpace(8),
          const Divider(color: ColorsManager.lightBlue),
          verticalSpace(8),
          DateTimeSection(booking: booking),
          verticalSpace(8),
          ServicesListView(booking: booking.services ?? []),
        ],
      ),
    );
  }
}
