import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temy_barber/core/utils/date_utils.dart' as app_date_utils;
import 'package:temy_barber/features/reservations/data/models/reservation_response.dart';

class InvoiceLogic {
  const InvoiceLogic();

  List<ReservationData> getAllReservations(
    ReservationResponseModel? arguments,
  ) {
    return arguments?.allReservations ??
        (arguments?.data != null ? [arguments!.data] : []);
  }

  double calculateGrandTotal(List<ReservationData> reservations) {
    return reservations.fold(0.0, (sum, res) => sum + res.totalPrice);
  }

  bool hasGuest(List<ReservationData> reservations) {
    return reservations.any((r) => r.user == null && r.userName != null);
  }

  String? getDisplayPhone(List<ReservationData> reservations) {
    return reservations
        .firstWhere(
          (r) => r.userPhone != null,
          orElse: () => reservations.first,
        )
        .userPhone;
  }

  String formatReservationDate(String dateStr, String locale) {
    try {
      final date = DateFormat('yyyy-MM-dd').parse(dateStr);
      return DateFormat('EEEE, dd MMMM', locale).format(date);
    } catch (e) {
      debugPrint("Error parsing date: $e");
      return 'common.not_available'.tr();
    }
  }

  String formatReservationTime(String timeStr, String locale) {
    return app_date_utils.formatTimeOfDayString(timeStr, locale: locale);
  }
}
