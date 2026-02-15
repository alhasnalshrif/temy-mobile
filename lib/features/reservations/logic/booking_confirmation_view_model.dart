import 'package:flutter/material.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/data/models/booking_confirmation_models.dart';
import 'package:temy_barber/features/reservations/logic/booking_confirmation_logic.dart';
import 'package:temy_barber/features/reservations/logic/simple_multi_reservation_manager.dart';

/// ViewModel for BookingConfirmation screen handling all business logic
class BookingConfirmationViewModel extends ChangeNotifier {
  final ReservationArguments arguments;
  final MultiReservationManager _multiReservationManager;
  final BookingConfirmationLogic _logic;

  BookingConfirmationViewModel({
    required this.arguments,
    MultiReservationManager? multiReservationManager,
    BookingConfirmationLogic? logic,
  }) : _multiReservationManager =
           multiReservationManager ?? MultiReservationManager(),
       _logic = logic ?? const BookingConfirmationLogic();

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
  String formatDateForDisplay(DateTime date, String time) =>
      _logic.formatDateForDisplay(date, time);

  /// Format date for API
  String formatDateForApi(DateTime date) => _logic.formatDateForApi(date);

  /// Get user ID from shared preferences
  Future<String> getUserId() => _logic.getUserId();

  /// Check if user is logged in
  Future<bool> isUserLoggedIn() => _logic.isUserLoggedIn();

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
  ReservationArguments buildUpdatedArguments() =>
      _logic.buildUpdatedArguments(arguments);

  /// Validate booking can proceed
  BookingValidationResult validateBooking() =>
      _logic.validateBooking(arguments);

  /// Validate adding to multiple reservations
  BookingValidationResult validateAddToMultiple() =>
      _logic.validateAddToMultiple(arguments);
}
