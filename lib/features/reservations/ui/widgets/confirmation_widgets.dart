import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';

/// Header widget showing review details info
class ConfirmationHeader extends StatelessWidget {
  const ConfirmationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: ColorsManager.lightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            size: 24,
            color: ColorsManager.mainBlue,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'booking_confirmation.review_details'.tr(),
              style: TextStyles.font14DarkBlueMedium,
            ),
          ),
        ],
      ),
    );
  }
}

/// Barber info section widget
class BarberInfoSection extends StatelessWidget {
  final BarberDetailData? barberData;

  const BarberInfoSection({super.key, required this.barberData});

  @override
  Widget build(BuildContext context) {
    if (barberData == null) return const SizedBox.shrink();

    return _ConfirmationCard(
      child: Row(
        children: [
          _BarberAvatar(avatarUrl: barberData?.avatar),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "${'booking_confirmation.barber_label'.tr()}: ${barberData?.name ?? 'booking_confirmation.unknown_barber'.tr()}",
              style: TextStyles.font14DarkBlueMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Appointment info section widget
class AppointmentInfoSection extends StatelessWidget {
  final DateTime? selectedDate;
  final String? selectedTime;

  const AppointmentInfoSection({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedDate == null || selectedTime == null) {
      return const SizedBox.shrink();
    }

    final formattedDate = DateFormat(
      'EEEE, d MMMM',
      'ar',
    ).format(selectedDate!);

    return _ConfirmationCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorsManager.lightBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              'assets/icons/calendar.png',
              color: ColorsManager.mainBlue,
              width: 18,
              height: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'booking_confirmation.date_label'.tr(),
                  style: TextStyles.font14DarkBlueMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$formattedDate - $selectedTime",
                  style: TextStyles.font14GrayRegular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Payment info section widget
class PaymentInfoSection extends StatelessWidget {
  const PaymentInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _ConfirmationCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorsManager.lightBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.payments_outlined,
              color: ColorsManager.mainBlue,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'booking_confirmation.payment_on_arrival'.tr(),
            style: TextStyles.font14DarkBlueMedium,
          ),
          const Spacer(),
          const Icon(
            Icons.check_circle,
            color: ColorsManager.mainBlue,
            size: 18,
          ),
        ],
      ),
    );
  }
}

/// Single reservation order summary
class SingleOrderSummary extends StatelessWidget {
  final ReservationArguments arguments;

  const SingleOrderSummary({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'booking_confirmation.summary_services'.tr(),
          style: TextStyles.font16DarkBold,
        ),
        const SizedBox(height: 12),
        _ConfirmationCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ServicesList(services: arguments.selectedServices),
              const Divider(height: 24, color: ColorsManager.lightBlue),
              _TotalRow(
                label: 'booking_confirmation.total_final'.tr(),
                amount: arguments.totalPrice,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Multiple reservations order summary
class MultipleOrderSummary extends StatelessWidget {
  final List<ReservationArguments> reservations;
  final double grandTotal;
  final void Function(int index) onRemoveReservation;

  const MultipleOrderSummary({
    super.key,
    required this.reservations,
    required this.grandTotal,
    required this.onRemoveReservation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'booking_confirmation.summary'.tr(
                args: [reservations.length.toString()],
              ),
              style: TextStyles.font16DarkBold,
            ),
            Text(
              "${grandTotal.toStringAsFixed(2)} ${'common.currency'.tr()}",
              style: TextStyles.font14DarkBlueMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorsManager.mainBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reservations.length,
          itemBuilder: (context, index) {
            final isCurrentReservation = index == reservations.length - 1;
            return _ReservationCard(
              reservation: reservations[index],
              showRemoveButton: !isCurrentReservation,
              onRemove: () => onRemoveReservation(index),
            );
          },
        ),
        _GrandTotalCard(grandTotal: grandTotal),
      ],
    );
  }
}

/// Add another reservation button
class AddAnotherReservationButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddAnotherReservationButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: ColorsManager.lightBlue.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.add_circle_outline,
                  color: ColorsManager.mainBlue,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'booking_confirmation.add_another'.tr(),
                    style: TextStyles.font14DarkBlueMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.mainBlue,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: ColorsManager.mainBlue.withOpacity(0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Bottom action buttons
class ConfirmationBottomButtons extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onConfirm;
  final String confirmText;

  const ConfirmationBottomButtons({
    super.key,
    required this.onEdit,
    required this.onConfirm,
    required this.confirmText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: OutlinedButton.icon(
            onPressed: onEdit,
            icon: const Icon(Icons.arrow_back_ios, size: 16),
            label: Text('booking_confirmation.edit'.tr()),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              foregroundColor: ColorsManager.mainBlue,
              side: const BorderSide(color: ColorsManager.mainBlue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 5,
          child: ElevatedButton.icon(
            onPressed: onConfirm,
            icon: const Icon(Icons.check_circle_outline),
            label: Text(confirmText),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Private helper widgets

class _ConfirmationCard extends StatelessWidget {
  final Widget child;

  const _ConfirmationCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.lightBlue),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: child,
    );
  }
}

class _BarberAvatar extends StatelessWidget {
  final String? avatarUrl;

  const _BarberAvatar({this.avatarUrl});

  bool get _hasValidAvatar =>
      avatarUrl != null && avatarUrl!.isNotEmpty && avatarUrl != 'null';

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.grey.shade100,
      backgroundImage: _hasValidAvatar ? NetworkImage(avatarUrl!) : null,
      onBackgroundImageError: _hasValidAvatar
          ? (exception, stackTrace) {
              // Handle network errors gracefully during hot reload
            }
          : null,
      child: !_hasValidAvatar
          ? const Icon(Icons.person, size: 20, color: Colors.grey)
          : null,
    );
  }
}

class _ServicesList extends StatelessWidget {
  final List<BarberService> services;

  const _ServicesList({required this.services});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 12, color: ColorsManager.lightBlue),
      itemBuilder: (context, index) {
        final service = services[index];
        return Row(
          children: [
            Expanded(
              child: Text(service.name, style: TextStyles.font14DarkBlueMedium),
            ),
            Text(
              "${service.duration} ${'booking.min'.tr()}",
              style: TextStyles.font14GrayRegular.copyWith(fontSize: 12),
            ),
            const SizedBox(width: 12),
            Text(
              "${service.price.toStringAsFixed(2)} ${'common.currency'.tr()}",
              style: TextStyles.font14DarkBlueMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String label;
  final double amount;

  const _TotalRow({required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyles.font16DarkBold),
        Text(
          "${amount.toStringAsFixed(2)} ${'common.currency'.tr()}",
          style: TextStyles.font16DarkBold.copyWith(
            color: ColorsManager.mainBlue,
          ),
        ),
      ],
    );
  }
}

class _ReservationCard extends StatelessWidget {
  final ReservationArguments reservation;
  final bool showRemoveButton;
  final VoidCallback onRemove;

  const _ReservationCard({
    required this.reservation,
    required this.showRemoveButton,
    required this.onRemove,
  });

  String get _dateTime {
    if (reservation.selectedDate == null || reservation.selectedTime == null) {
      return "";
    }
    return "${DateFormat('d MMM', 'ar').format(reservation.selectedDate!)}, ${reservation.selectedTime}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildServices(),
          _buildTotal(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ColorsManager.lightBlue, width: 1.5),
          ),
          child: _BarberAvatar(avatarUrl: reservation.barberData?.avatar),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reservation.barberData?.name ??
                    'booking_confirmation.unknown_barber'.tr(),
                style: TextStyles.font18DarkBlueBold,
                overflow: TextOverflow.ellipsis,
              ),
              if (_dateTime.isNotEmpty)
                Text(
                  _dateTime,
                  style: TextStyles.font12BlueRegular.copyWith(
                    color: Colors.grey.shade600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
        if (showRemoveButton)
          IconButton(
            onPressed: onRemove,
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 18, color: Colors.red),
            ),
            tooltip: 'booking_confirmation.remove_tooltip'.tr(),
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
            ),
          ),
      ],
    );
  }

  Widget _buildServices() {
    if (reservation.selectedServices.isEmpty) {
      return Text(
        'booking_confirmation.no_services'.tr(),
        style: TextStyles.font14GrayRegular.copyWith(
          color: Colors.grey.shade500,
        ),
      );
    }

    return Column(
      children: reservation.selectedServices.map((service) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  service.name,
                  style: TextStyles.font14DarkBlueMedium.copyWith(
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "${service.price.toStringAsFixed(0)} ${'common.currency'.tr()}",
                style: TextStyles.font14DarkBlueMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.mainBlue,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTotal() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          const Divider(color: ColorsManager.lightBlue, height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'common.total'.tr(),
                style: TextStyles.font14DarkBlueMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                "${reservation.totalPrice.toStringAsFixed(2)} ${'common.currency'.tr()}",
                style: TextStyles.font18DarkBlueBold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GrandTotalCard extends StatelessWidget {
  final double grandTotal;

  const _GrandTotalCard({required this.grandTotal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: ColorsManager.thirdfMain.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('common.grand_total'.tr(), style: TextStyles.font16DarkBold),
          Text(
            "${grandTotal.toStringAsFixed(2)} ${'common.currency'.tr()}",
            style: TextStyles.font16DarkBold.copyWith(
              color: ColorsManager.mainBlue,
            ),
          ),
        ],
      ),
    );
  }
}
