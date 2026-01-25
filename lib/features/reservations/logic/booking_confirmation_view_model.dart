import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/logic/simple_multi_reservation_manager.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';

/// ViewModel for BookingConfirmation screen handling all business logic
class BookingConfirmationViewModel extends ChangeNotifier {
  final ReservationArguments arguments;
  final MultiReservationManager _multiReservationManager;

  BookingConfirmationViewModel({
    required this.arguments,
    MultiReservationManager? multiReservationManager,
  }) : _multiReservationManager =
           multiReservationManager ?? MultiReservationManager();

  // Getters
  bool get isQueueMode => arguments.isQueueMode ?? false;

  List<ReservationArguments> get existingReservations =>
      _multiReservationManager.reservations;

  bool get hasMultipleReservations =>
      !isQueueMode && existingReservations.isNotEmpty;

  List<ReservationArguments> get allReservations => hasMultipleReservations
      ? [...existingReservations, arguments]
      : [arguments];

  double get grandTotal =>
      allReservations.fold(0.0, (total, res) => total + res.totalPrice);

  int get totalReservationsCount =>
      _multiReservationManager.reservations.length + 1;

  bool get hasValidDateAndTime =>
      arguments.selectedDate != null && arguments.selectedTime != null;

  String get confirmButtonText {
    if (isQueueMode || _multiReservationManager.reservations.isEmpty) {
      return 'booking_confirmation.confirm_booking';
    }
    return 'booking_confirmation.confirm_all';
  }

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

  /// Add current reservation to multi-reservation list
  void addToMultipleReservations() {
    _multiReservationManager.addReservation(arguments);
    notifyListeners();
  }

  /// Remove a reservation from the list
  void removeReservation(int index) {
    _multiReservationManager.removeReservationAt(index);
    notifyListeners();
  }

  /// Clear all reservations
  void clearReservations() {
    _multiReservationManager.clearReservations();
  }

  /// Get reservations data for API
  List<Map<String, dynamic>> getReservationsData() {
    return _multiReservationManager.getReservationsData(
      currentReservation: arguments,
    );
  }

  /// Build service IDs list
  List<String> get serviceIds =>
      arguments.selectedServices.map((s) => s.id).toList();

  /// Get barber ID
  String get barberId => arguments.barberData?.id ?? '';

  /// Build updated arguments for reservation
  ReservationArguments buildUpdatedArguments() {
    return ReservationArguments(
      selectedServices: arguments.selectedServices,
      barberData: arguments.barberData,
      totalPrice: arguments.totalPrice,
      selectedDate: arguments.selectedDate,
      selectedTime: arguments.selectedTime,
      isQueueMode: isQueueMode,
    );
  }

  /// Validate booking can proceed
  BookingValidationResult validateBooking() {
    if (!isQueueMode && !hasValidDateAndTime) {
      return BookingValidationResult(
        isValid: false,
        errorMessage: 'booking_confirmation.select_date_time',
      );
    }
    return BookingValidationResult(isValid: true);
  }

  /// Validate adding to multiple reservations
  BookingValidationResult validateAddToMultiple() {
    if (!hasValidDateAndTime) {
      return BookingValidationResult(
        isValid: false,
        errorMessage: 'booking_confirmation.select_date_time_first',
      );
    }
    return BookingValidationResult(isValid: true);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/// Result of booking validation
class BookingValidationResult {
  final bool isValid;
  final String? errorMessage;

  BookingValidationResult({required this.isValid, this.errorMessage});
}

/// Data class for booking confirmation
class BookingConfirmationData {
  final String date;
  final String startTime;
  final List<String> serviceIds;
  final String barberId;
  final String? userId;
  final GuestInfo? guestInfo;
  final ReservationArguments arguments;

  BookingConfirmationData({
    required this.date,
    required this.startTime,
    required this.serviceIds,
    required this.barberId,
    this.userId,
    this.guestInfo,
    required this.arguments,
  });
}
