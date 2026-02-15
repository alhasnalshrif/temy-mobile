import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';

import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';

import 'package:temy_barber/core/utils/responsive_utils.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_response.dart';
import 'package:temy_barber/features/reservations/logic/invoice_logic.dart';

class InvoiceScreen extends StatelessWidget {
  final ReservationResponseModel? arguments;

  final _logic = const InvoiceLogic();

  const InvoiceScreen({super.key, this.arguments});

  List<ReservationData> get _allReservations =>
      _logic.getAllReservations(arguments);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ColorsManager.mainBlue,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final isDesktop = ResponsiveUtils.isDesktop(context);

    return Scaffold(
      backgroundColor: isDesktop ? Colors.white : ColorsManager.black,
      appBar: AppBar(
        backgroundColor: isDesktop ? Colors.white : ColorsManager.black,
        elevation: 0,
        title: Text(
          'invoice.title'.tr(),
          style: isDesktop
              ? TextStyles.font18DarkBlueBold
              : TextStyles.font18WhiteSemiBold,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: isDesktop ? Colors.black : Colors.white,
          ),
          onPressed: () => context.goNamed(AppRoutes.homeName),
        ),
      ),
      body: Column(
        children: [
          _buildSuccessHeader(isDesktop),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Container(
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  margin: isDesktop
                      ? const EdgeInsets.only(bottom: 24)
                      : EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: isDesktop
                        ? BorderRadius.circular(28)
                        : const BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(20),
                          children: [
                            _buildGuestNotificationBanner(),
                            ..._allReservations.asMap().entries.map((entry) {
                              final index = entry.key;
                              final reservation = entry.value;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (_allReservations.length > 1)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12.0,
                                        top: 8.0,
                                      ),
                                      child: Text(
                                        "${'booking.reservation'.tr()} #${index + 1}",
                                        style: TextStyles.font16DarkBold
                                            .copyWith(
                                              color: ColorsManager.mainBlue,
                                            ),
                                      ),
                                    ),
                                  _buildReservationCard(reservation),
                                  if (index < _allReservations.length - 1)
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      child: Divider(),
                                    ),
                                ],
                              );
                            }),
                            const SizedBox(height: 16),
                            if (_allReservations.isNotEmpty) _buildTotalCard(),
                          ],
                        ),
                      ),
                      _buildBottomButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessHeader(bool isDesktop) {
    return Container(
      color: isDesktop ? Colors.white : ColorsManager.black,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: isDesktop ? ColorsManager.mainBlue : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isDesktop ? ColorsManager.mainBlue : Colors.white,
                width: 3,
              ),
            ),
            child: Icon(
              Icons.check,
              color: isDesktop ? Colors.white : ColorsManager.black,
              size: 40,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'invoice.booking_success'.tr(),
            style: isDesktop
                ? TextStyles.font18DarkBlueBold.copyWith(fontSize: 20)
                : TextStyles.font18WhiteSemiBold.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestNotificationBanner() {
    // Check if ANY reservation is guest
    final hasGuest = _logic.hasGuest(_allReservations);
    if (!hasGuest) return const SizedBox.shrink();

    // Use first reservation's phone for display if available
    final displayPhone = _logic.getDisplayPhone(_allReservations);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF81C784)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'invoice.guest_booking'.tr(),
                  style: TextStyles.font14DarkBlueMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'invoice.guest_notification'.tr(),
                  style: TextStyles.font13GrayRegular,
                ),
                if (displayPhone != null) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        size: 14,
                        color: Color(0xFF4CAF50),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        displayPhone,
                        style: TextStyles.font13GrayRegular.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Wrapper to display details for a single reservation
  Widget _buildReservationCard(ReservationData reservation) {
    return Column(
      children: [
        _buildSectionCard(
          title: 'invoice.barber'.tr(),
          icon: Icons.person_outline,
          child: _buildBarberContent(reservation),
        ),
        const SizedBox(height: 16),
        _buildDateTimeCard(reservation),
        const SizedBox(height: 16),
        _buildServicesCard(reservation),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsManager.lightBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorsManager.lightBlue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: ColorsManager.mainBlue),
              const SizedBox(width: 8),
              Text(title, style: TextStyles.font14DarkBlueMedium),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  // Updated to accept ReservationData
  Widget _buildBarberContent(ReservationData reservation) {
    final serviceNames = reservation.services.map((s) => s.name).join(' • ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(reservation.barber.name, style: TextStyles.font16DarkBold),
        if (serviceNames.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            serviceNames,
            style: TextStyles.font13GrayRegular,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  // Updated to accept ReservationData
  Widget _buildDateTimeCard(ReservationData reservation) {
    final isQueueReservation = reservation.isQueueReservation ?? false;

    if (isQueueReservation) {
      final queueNumber = reservation.queueNumber;
      final queuePosition = reservation.queuePosition;
      final displayNumber = queueNumber ?? queuePosition;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorsManager.mainBlue.withAlpha(20),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorsManager.mainBlue.withAlpha(77)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.people_outline,
                  size: 18,
                  color: ColorsManager.mainBlue,
                ),
                const SizedBox(width: 8),
                Text(
                  'invoice.queue_info'.tr(),
                  style: TextStyles.font14DarkBlueMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (displayNumber != null)
              _buildInfoRow('invoice.queue_number'.tr(), "#$displayNumber"),
            if (queuePosition != null && queuePosition > 0) ...[
              const SizedBox(height: 8),
              _buildInfoRow(
                'invoice.people_before_you'.tr(),
                "${queuePosition - 1}",
              ),
            ],
          ],
        ),
      );
    }

    final locale =
        EasyLocalization.of(
          WidgetsBinding.instance.rootElement!,
        )?.locale.languageCode ??
        'ar';
    final dateStr = _logic.formatReservationDate(reservation.date, locale);
    final timeStr = _logic.formatReservationTime(reservation.startTime, locale);

    return _buildSectionCard(
      title: 'invoice.appointment_date'.tr(),
      icon: Icons.calendar_today_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('invoice.date'.tr(), dateStr),
          const SizedBox(height: 8),
          _buildInfoRow('invoice.time'.tr(), timeStr),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyles.font13GrayRegular),
        Text(
          value,
          style: TextStyles.font14DarkBlueMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Updated to accept ReservationData
  Widget _buildServicesCard(ReservationData reservation) {
    final services = reservation.services;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsManager.lightBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorsManager.lightBlue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.content_cut,
                size: 18,
                color: ColorsManager.mainBlue,
              ),
              const SizedBox(width: 8),
              Text(
                'invoice.services'.tr(),
                style: TextStyles.font14DarkBlueMedium,
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (services.isNotEmpty)
            ...services.map(
              (service) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        service.name,
                        style: TextStyles.font14GrayRegular,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "${service.price.toInt()} EGP",
                      style: TextStyles.font14DarkBlueMedium,
                    ),
                  ],
                ),
              ),
            )
          else
            Text(
              'invoice.no_services'.tr(),
              style: TextStyles.font13GrayRegular,
            ),
        ],
      ),
    );
  }

  Widget _buildTotalCard() {
    // Calculate sum of all reservations
    final grandTotal = _logic.calculateGrandTotal(_allReservations);
    final isMultiple = _allReservations.length > 1;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isMultiple ? 'common.grand_total'.tr() : 'invoice.total'.tr(),
            style: TextStyles.font16WhiteMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorsManager.black,
            ),
          ),
          Text(
            "${grandTotal.toInt()} EGP",
            style: TextStyles.font18WhiteSemiBold.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorsManager.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.mainBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          onPressed: () {
            context.goNamed(AppRoutes.homeName);
          },
          child: Text(
            'invoice.back_to_home'.tr(),
            style: TextStyles.font16WhiteMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
