import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:temy_barber/core/routing/routes.dart';
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
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('الفاتورة', style: TextStyles.font18WhiteSemiBold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildConfirmationCheck(context),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                      child: Text(
                        "تفاصيل الحجز",
                        style: TextStyles.font18DarkBlueBold,
                      ),
                    ),
                    _buildGuestNotificationBanner(),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        children: [
                          _buildBarberInfo(),
                          const SizedBox(height: 24),
                          _buildDateTimeSection(),
                          const SizedBox(height: 24),
                          _buildServicesList(),
                          const SizedBox(height: 24),
                          _buildTotalSection(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    _buildBottomButtons(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationCheck(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SizedBox(
        height: 120,
        child: Center(
          child: Image.asset('assets/icons/check.png', width: 100, height: 100),
        ),
      ),
    );
  }

  Widget _buildGuestNotificationBanner() {
    // Check if this is a guest reservation (user is null but userName/userPhone exist)
    final isGuest =
        _reservationData?.user == null && _reservationData?.userName != null;

    if (!isGuest) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.mainBlue.withOpacity(0.1),
            ColorsManager.lightBlue.withOpacity(0.3),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorsManager.mainBlue.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "حجز ضيف",
                  style: TextStyles.font16DarkBold.copyWith(
                    color: ColorsManager.mainBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "تم إرسال تفاصيل الحجز إلى رقم الواتساب الخاص بك",
                  style: TextStyles.font14GrayRegular.copyWith(fontSize: 13),
                ),
                if (_reservationData?.userPhone != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone_android,
                        size: 14,
                        color: ColorsManager.mainBlue,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _reservationData!.userPhone!,
                        style: TextStyles.font14BlueSemiBold.copyWith(
                          fontSize: 13,
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

  Widget _buildBarberInfo() {
    final isQueueReservation = _reservationData?.isQueueReservation ?? false;

    String? shortDateStr;
    if (!isQueueReservation && _reservationData?.date != null) {
      DateTime? reservationDate;
      try {
        reservationDate = DateFormat(
          'yyyy-MM-dd',
        ).parse(_reservationData!.date);
        shortDateStr = DateFormat(
          'EEE, dd MMM',
          'en_US',
        ).format(reservationDate);
      } catch (e) {
        print("Error parsing date: $e");
      }
    }

    final serviceNames =
        _reservationData?.services.map((s) => s.name).join(', ') ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _reservationData?.barber.name ?? "اسم الحلاق",
                  style: TextStyles.font18DarkBlueBold,
                  overflow: TextOverflow.ellipsis,
                ),
                if (serviceNames.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    serviceNames,
                    style: TextStyles.font14GrayRegular,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ],
            ),
          ),
          if (shortDateStr != null && shortDateStr.isNotEmpty)
            Text(shortDateStr, style: TextStyles.font14GrayRegular),
        ],
      ),
    );
  }

  Widget _buildDateTimeSection() {
    // Check if this is a queue reservation
    final isQueueReservation = _reservationData?.isQueueReservation ?? false;

    if (isQueueReservation) {
      // For queue reservations, show queue information instead of date/time
      final queueNumber = _reservationData?.queueNumber;
      final queuePosition = _reservationData?.queuePosition;
      final displayNumber = queueNumber ?? queuePosition;

      return Container(
        decoration: BoxDecoration(
          // color: Colors.grey[200],
          color: ColorsManager.mainBlue.withOpacity(0.1),
          border: Border.all(color: ColorsManager.mainBlue),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.people_outline,
                  size: 20,
                  color: Colors.black54,
                ),
                const SizedBox(width: 12),
                Text("معلومات الطابور", style: TextStyles.font16DarkBold),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(right: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (displayNumber != null)
                    Text(
                      "رقمك في الطابور: #$displayNumber",
                      style: TextStyles.font14BlueSemiBold,
                    ),
                  if (queuePosition != null && queuePosition > 0) ...[
                    const SizedBox(height: 4),
                    Text(
                      "عدد الأشخاص قبلك: ${queuePosition - 1}",
                      style: TextStyles.font14BlueSemiBold,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    }

    // For regular reservations, show date/time
    DateTime? reservationDate;
    if (_reservationData?.date != null) {
      try {
        reservationDate = DateFormat(
          'yyyy-MM-dd',
        ).parse(_reservationData!.date);
      } catch (e) {
        print("Error parsing date: $e");
      }
    }

    final dateStr = reservationDate != null
        ? DateFormat('EEE, dd MMM', 'en_US').format(reservationDate)
        : 'غير محدد';

    final timeStr = _reservationData?.startTime != null
        ? app_date_utils.formatTimeOfDayString(
            _reservationData!.startTime,
            locale: 'en_US',
          )
        : 'غير محدد';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/icons/calendar.png',
                width: 20,
                height: 20,
                color: Colors.black54,
              ),
              const SizedBox(width: 12),
              Text("التاريخ والوقت", style: TextStyles.font16DarkBold),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: Text(
              "$dateStr - $timeStr",
              style: TextStyles.font16GrayRegular,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesList() {
    final services = _reservationData?.services ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("تفاصيل الدفع", style: TextStyles.font16DarkBold),
          ),
          const SizedBox(height: 8),
          if (services.isNotEmpty)
            ...services.map(
              (service) => _buildServiceItem(service.name, service.price),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "لا توجد خدمات محددة",
                style: TextStyles.font14GrayRegular,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(
    String name,
    double price, {
    bool isDiscount = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        "$name - ${isDiscount ? '-' : ''}${price.toInt()} EGP",
        style: isDiscount
            ? TextStyles.font14GrayRegular.copyWith(color: Colors.red)
            : TextStyles.font14GrayRegular,
      ),
    );
  }

  Widget _buildTotalSection() {
    final totalPrice = _reservationData?.totalPrice ?? 0.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("المجموع", style: TextStyles.font18DarkBlueBold),
              Text(
                "${totalPrice.toInt()} EGP",
                style: TextStyles.font18DarkBlueBold,
              ),
            ],
          ),
          // divider
          const SizedBox(height: 8),
          Divider(color: Colors.grey[300], height: 1, thickness: 1),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.mainBlue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.dashboardScreen);
              },
              child: Text(
                'الصفحه الرئيسيه',
                style: TextStyles.font16WhiteMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
