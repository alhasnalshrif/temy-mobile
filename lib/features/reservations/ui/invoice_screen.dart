import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/utils/date_utils.dart' as app_date_utils;

import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';

import 'package:temy_barber/features/reservations/data/models/reservation_response.dart';

class InvoiceScreen extends StatelessWidget {
  final ReservationResponseModel? arguments;

  const InvoiceScreen({super.key, this.arguments});

  ReservationData? get _reservationData => arguments?.data;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ColorsManager.mainBlue,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: ColorsManager.black,
      appBar: AppBar(
        backgroundColor: ColorsManager.black,
        elevation: 0,
        title: Text(
          'invoice.title'.tr(),
          style: TextStyles.font18WhiteSemiBold,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.goNamed(AppRoutes.dashboardName),
        ),
      ),
      body: Column(
        children: [
          _buildSuccessHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        _buildGuestNotificationBanner(),
                        _buildSectionCard(
                          title: 'invoice.barber'.tr(),
                          icon: Icons.person_outline,
                          child: _buildBarberContent(),
                        ),
                        const SizedBox(height: 16),
                        _buildDateTimeCard(),
                        const SizedBox(height: 16),
                        _buildServicesCard(),
                        const SizedBox(height: 16),
                        _buildTotalCard(),
                      ],
                    ),
                  ),
                  _buildBottomButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessHeader() {
    return Container(
      color: ColorsManager.black,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: const Icon(
              Icons.check,
              color: ColorsManager.black,
              size: 40,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'invoice.booking_success'.tr(),
            style: TextStyles.font18WhiteSemiBold.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestNotificationBanner() {
    final isGuest =
        _reservationData?.user == null && _reservationData?.userName != null;

    if (!isGuest) return const SizedBox.shrink();

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
                if (_reservationData?.userPhone != null) ...[
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
                        _reservationData!.userPhone!,
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

  Widget _buildBarberContent() {
    final serviceNames =
        _reservationData?.services.map((s) => s.name).join(' • ') ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _reservationData?.barber.name ?? 'booking.unknown_barber'.tr(),
          style: TextStyles.font16DarkBold,
        ),
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

  Widget _buildDateTimeCard() {
    final isQueueReservation = _reservationData?.isQueueReservation ?? false;

    if (isQueueReservation) {
      final queueNumber = _reservationData?.queueNumber;
      final queuePosition = _reservationData?.queuePosition;
      final displayNumber = queueNumber ?? queuePosition;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorsManager.mainBlue.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorsManager.mainBlue.withOpacity(0.3)),
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

    DateTime? reservationDate;
    if (_reservationData?.date != null) {
      try {
        reservationDate = DateFormat(
          'yyyy-MM-dd',
        ).parse(_reservationData!.date);
      } catch (e) {
        debugPrint("Error parsing date: $e");
      }
    }

    final locale =
        EasyLocalization.of(
          WidgetsBinding.instance.rootElement!,
        )?.locale.languageCode ??
        'ar';
    final dateStr = reservationDate != null
        ? DateFormat('EEEE, dd MMMM', locale).format(reservationDate)
        : 'common.not_available'.tr();

    final timeStr = _reservationData?.startTime != null
        ? app_date_utils.formatTimeOfDayString(
            _reservationData!.startTime,
            locale: locale,
          )
        : 'common.not_available'.tr();

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

  Widget _buildServicesCard() {
    final services = _reservationData?.services ?? [];

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
    final totalPrice = _reservationData?.totalPrice ?? 0.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'invoice.total'.tr(),
            style: TextStyles.font16WhiteMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorsManager.black,
            ),
          ),
          Text(
            "${totalPrice.toInt()} EGP",
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
            context.goNamed(AppRoutes.dashboardName);
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
