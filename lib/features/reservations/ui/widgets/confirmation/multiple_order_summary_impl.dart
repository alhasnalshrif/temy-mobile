part of 'multiple_order_summary.dart';

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
    final dateFormat = DateFormat('d MMM', 'ar');
    return "${dateFormat.format(reservation.selectedDate!)}, ${reservation.selectedTime}";
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
          child: AppAvatar(imageUrl: reservation.barberData?.avatar, radius: 20),
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
                color: ColorsManager.red.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 18,
                color: ColorsManager.red,
              ),
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

/// Grand total card
class _GrandTotalCard extends StatelessWidget {
  final double grandTotal;

  const _GrandTotalCard({required this.grandTotal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: ColorsManager.thirdfMain.withAlpha(75),
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
