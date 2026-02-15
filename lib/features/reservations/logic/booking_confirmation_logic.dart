import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/data/models/booking_confirmation_models.dart';

class BookingConfirmationLogic {
  const BookingConfirmationLogic();

  /// Format date for display
  String formatDateForDisplay(DateTime date, String time) {
    // This will be formatted with DateFormat in the UI
    return '$date, $time';
  }

  /// Format date for API
  String formatDateForApi(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Get user ID from shared preferences
  Future<String> getUserId() async {
    return await SharedPrefHelper.getSecuredString(SharedPrefKeys.userId);
  }

  /// Check if user is logged in
  Future<bool> isUserLoggedIn() async {
    final userId = await getUserId();
    return userId.isNotEmpty;
  }

  /// Build updated arguments for reservation
  ReservationArguments buildUpdatedArguments(ReservationArguments arguments) {
    return ReservationArguments(
      selectedServices: arguments.selectedServices,
      barberData: arguments.barberData,
      totalPrice: arguments.totalPrice,
      selectedDate: arguments.selectedDate,
      selectedTime: arguments.selectedTime,
      isQueueMode: arguments.isQueueMode ?? false,
    );
  }

  /// Validate booking can proceed
  BookingValidationResult validateBooking(ReservationArguments arguments) {
    final isQueueMode = arguments.isQueueMode ?? false;
    final hasValidDateAndTime =
        arguments.selectedDate != null && arguments.selectedTime != null;

    if (!isQueueMode && !hasValidDateAndTime) {
      return BookingValidationResult(
        isValid: false,
        errorMessage: 'booking_confirmation.select_date_time',
      );
    }
    return BookingValidationResult(isValid: true);
  }

  /// Validate adding to multiple reservations
  BookingValidationResult validateAddToMultiple(
    ReservationArguments arguments,
  ) {
    final hasValidDateAndTime =
        arguments.selectedDate != null && arguments.selectedTime != null;

    if (!hasValidDateAndTime) {
      return BookingValidationResult(
        isValid: false,
        errorMessage: 'booking_confirmation.select_date_time_first',
      );
    }
    return BookingValidationResult(isValid: true);
  }
}
