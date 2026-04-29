import 'package:flutter/material.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/widgets/app_avatar.dart';
import 'package:temy_barber/core/widgets/snackbar_helper.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:temy_barber/features/barber/data/repos/barber_repo.dart';
import 'package:temy_barber/features/reservations/data/models/default_reservation.dart';
import 'package:temy_barber/features/reservations/data/repos/default_reservation_storage.dart';
import 'package:easy_localization/easy_localization.dart';

class DefaultBookingCard extends StatefulWidget {
  const DefaultBookingCard({super.key});

  @override
  State<DefaultBookingCard> createState() => _DefaultBookingCardState();
}

class _DefaultBookingCardState extends State<DefaultBookingCard> {
  bool _isLoading = true;
  bool _isBookingLoading = false;
  DefaultReservation? _defaultReservation;
  final DefaultReservationStorage _storage = DefaultReservationStorage();

  @override
  void initState() {
    super.initState();
    _loadDefaultReservation();
  }

  Future<void> _loadDefaultReservation() async {
    final reservation = await _storage.load();

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _defaultReservation = reservation;
    });
  }

  Future<void> _removeDefaultBooking() async {
    await _storage.remove();

    if (!mounted) return;

    setState(() {
      _defaultReservation = null;
    });

    SnackbarHelper.showError(context, 'default_booking.removed'.tr());
  }

  Future<BarberDetailData> _resolveBarberDetail(
    DefaultReservation reservation,
  ) async {
    try {
      final response = await getIt<BarberRepo>().getCategory(
        reservation.barber.id,
      );

      return response.when(
        success: (barberDetailResponseModel) => barberDetailResponseModel.data,
        failure: (_) => reservation.barber,
      );
    } catch (_) {
      return reservation.barber;
    }
  }

  Future<void> _handleBookNow(DefaultReservation reservation) async {
    setState(() => _isBookingLoading = true);

    final barberDetail = await _resolveBarberDetail(reservation);

    if (!mounted) return;

    setState(() => _isBookingLoading = false);

    context.pushGoNamed(
      AppRoutes.reservationName,
      pathParameters: {'barberId': reservation.barber.id},
      extra: reservation.toReservationArguments(barberData: barberDetail),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _defaultReservation == null) {
      return const SizedBox.shrink();
    }

    final reservation = _defaultReservation!;
    final barber = reservation.barber;
    final services = reservation.services;
    final totalPrice = reservation.totalPrice;

    return Dismissible(
      key: const Key('default_booking_card'),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _removeDefaultBooking();
      },
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text('default_booking.remove_title'.tr()),
            content: Text('default_booking.remove_confirmation'.tr()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('default_booking.cancel'.tr()),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  'default_booking.remove'.tr(),
                  style: const TextStyle(color: ColorsManager.red),
                ),
              ),
            ],
          ),
        );
      },
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: ColorsManager.red.withAlpha(200),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),

        decoration: BoxDecoration(
          border: Border.all(color: ColorsManager.mainBlue),
          color: ColorsManager.lightBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              AppAvatar(imageUrl: barber.avatar, radius: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'default_booking.best_choice'.tr(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      barber.name.isEmpty ? 'مصفف الشعر' : barber.name,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${services.length} ${'default_booking.services'.tr()} · ${(reservation.totalDuration / 60).ceil()} ${'default_booking.hour'.tr()}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 11),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ' $totalPrice جنيه',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.mainBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ElevatedButton(
                    onPressed: _isBookingLoading
                        ? null
                        : () => _handleBookNow(reservation),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.mainBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      minimumSize: const Size(80, 32),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_isBookingLoading)
                          const SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        else
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 12,
                            color: Colors.white,
                          ),
                        const SizedBox(width: 4),
                        Text(
                          'default_booking.book_now'.tr(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
