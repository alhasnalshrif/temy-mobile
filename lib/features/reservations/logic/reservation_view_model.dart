import 'package:flutter/material.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/data/models/default_reservation.dart';
import 'package:temy_barber/features/reservations/data/repos/default_reservation_storage.dart';
import 'package:temy_barber/features/reservations/data/models/time_slots_response.dart';

/// Configuration constants for reservations
class ReservationConfig {
  static const int defaultMaxBookingDays = 30;
  static const String dateFormat = 'yyyy-MM-dd';
}

/// State management class for reservation screen
/// Handles business logic and state separation from UI
class ReservationViewModel extends ChangeNotifier {
  // Selection State
  DateTime _selectedDate;
  DateTime _currentMonth;
  String? _selectedTime;

  // Loading States
  bool _isLoadingTimeSlots = false;
  bool _isLoadingSettings = false;
  bool _isLoadingDialogShowing = false;

  // Data State
  TimeSlotsResponse? _timeSlotsData;
  bool _isQueueMode = false;
  bool _isDefault = false;

  // Dependencies
  final ReservationArguments? arguments;
  final DefaultReservationStorage _storage;

  ReservationViewModel({this.arguments})
      : _selectedDate = DateTime.now(),
        _currentMonth = DateTime.now(),
        _storage = DefaultReservationStorage() {
    _initializeFromArguments();
  }

  /// Initialize state from navigation arguments
  void _initializeFromArguments() {
    final now = DateTime.now();
    _selectedDate = arguments?.selectedDate ?? now;
    _selectedTime = arguments?.selectedTime;
    _isQueueMode = arguments?.isQueueMode ?? false;
    _currentMonth = DateTime(now.year, now.month);
  }

  // ===== Getters =====

  /// Currently selected date
  DateTime get selectedDate => _selectedDate;

  /// Currently displayed month in calendar
  DateTime get currentMonth => _currentMonth;

  /// Currently selected time slot
  String? get selectedTime => _selectedTime;

  /// Available time slots from backend
  TimeSlotsResponse? get timeSlotsData => _timeSlotsData;

  /// Whether time slots are currently being fetched
  bool get isLoadingTimeSlots => _isLoadingTimeSlots;

  /// Whether queue settings are currently being fetched
  bool get isLoadingSettings => _isLoadingSettings;

  /// Whether loading dialog is currently showing
  bool get isLoadingDialogShowing => _isLoadingDialogShowing;

  /// Whether current booking mode is queue (vs time-slot)
  bool get isQueueMode => _isQueueMode;

  /// Whether current reservation matches saved default
  bool get isDefault => _isDefault;

  /// Barber data from arguments
  BarberDetailData? get barberData => arguments?.barberData;

  /// Selected services for booking
  List<BarberService> get selectedServices =>
      arguments?.selectedServices ?? [];

  /// Total price of selected services
  double get totalPrice => arguments?.totalPrice ?? 0.0;

  /// Maximum booking days from backend settings
  int get maxBookingDays =>
      barberData?.maxReservationDays ?? ReservationConfig.defaultMaxBookingDays;

  /// Total duration of all selected services in minutes
  int get totalDuration =>
      selectedServices.fold(0, (sum, service) => sum + service.duration);

  /// Whether booking can proceed based on mode and selections
  bool get canBook {
    if (_isQueueMode) {
      return selectedServices.isNotEmpty;
    }
    return _selectedTime != null && selectedServices.isNotEmpty;
  }

  // ===== Date Selection Methods =====

  /// Update selected date and reset related state
  void selectDate(DateTime date) {
    if (_selectedDate != date) {
      _selectedDate = date;
      _selectedTime = null; // Reset time when date changes
      notifyListeners();
    }
  }

  /// Update currently displayed calendar month
  void updateCurrentMonth(DateTime month) {
    if (_currentMonth != month) {
      _currentMonth = month;
      notifyListeners();
    }
  }

  // ===== Time Selection Methods =====

  /// Update selected time slot
  void selectTime(String? time) {
    if (_selectedTime != time) {
      _selectedTime = time;
      notifyListeners();
    }
  }

  /// Check if date needs fresh time slot data from backend
  bool shouldFetchTimeSlots(DateTime date) {
    final normalizedDate = _normalizeDate(date);
    final normalizedSelected = _normalizeDate(_selectedDate);
    return normalizedDate != normalizedSelected;
  }

  /// Check if backend indicates date has available slots
  bool hasAvailableSlots(DateTime date) {
    if (!shouldFetchTimeSlots(date)) {
      return _timeSlotsData != null &&
          !_timeSlotsData!.data.isDayOff &&
          _timeSlotsData!.data.slots.isNotEmpty;
    }
    return false; // Need to fetch from backend first
  }

  // ===== Loading State Methods =====

  /// Update time slots loading state
  void setTimeSlotsLoading(bool isLoading) {
    _isLoadingTimeSlots = isLoading;
    if (isLoading) {
      _timeSlotsData = null;
      _selectedTime = null;
    }
    notifyListeners();
  }

  /// Update time slots data from backend response
  void setTimeSlotsData(TimeSlotsResponse? data) {
    _timeSlotsData = data;
    _isLoadingTimeSlots = false;
    notifyListeners();
  }

  /// Update queue settings loading state
  void setQueueSettingsLoading(bool isLoading) {
    _isLoadingSettings = isLoading;
    notifyListeners();
  }

  /// Update queue mode from backend response
  void setQueueMode(bool isQueueMode) {
    _isQueueMode = isQueueMode;
    _isLoadingSettings = false;
    notifyListeners();
  }

  /// Update loading dialog visibility
  void setLoadingDialogShowing(bool isShowing) {
    _isLoadingDialogShowing = isShowing;
  }

  // ===== Default Reservation Methods =====

  /// Save current reservation as default for quick booking
  Future<bool> saveAsDefault() async {
    final currentBarber = barberData;
    if (currentBarber == null || selectedServices.isEmpty) {
      return false;
    }

    try {
      final defaultReservation = DefaultReservation(
        barber: currentBarber,
        services: selectedServices,
        totalPrice: totalPrice,
      );

      await _storage.save(defaultReservation);
      _isDefault = true;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Remove saved default reservation
  Future<bool> removeDefault() async {
    try {
      await _storage.remove();
      _isDefault = false;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Check if current reservation matches saved default
  Future<bool> checkIsDefault() async {
    final currentBarber = barberData;
    if (currentBarber == null || selectedServices.isEmpty) {
      _isDefault = false;
      notifyListeners();
      return false;
    }

    try {
      final defaultReservation = await _storage.load();
      final isMatch = _matchesDefaultReservation(defaultReservation, currentBarber);
      _isDefault = isMatch;
      notifyListeners();
      return isMatch;
    } catch (e) {
      _isDefault = false;
      notifyListeners();
      return false;
    }
  }

  // ===== Navigation Methods =====

  /// Build reservation arguments for navigation to next screen
  ReservationArguments buildNavigationArguments() {
    return ReservationArguments(
      selectedServices: selectedServices,
      barberData: barberData,
      selectedDate: _selectedDate,
      selectedTime: _selectedTime,
      totalPrice: totalPrice,
      isQueueMode: _isQueueMode,
    );
  }

  /// Format date for API requests (YYYY-MM-DD)
  String formatDateForApi(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  // ===== Private Helper Methods =====

  /// Normalize date to midnight for consistent comparisons
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Check if current selection matches saved default reservation
  bool _matchesDefaultReservation(
    DefaultReservation? defaultReservation,
    BarberDetailData currentBarber,
  ) {
    if (defaultReservation == null) return false;

    final defaultServiceIds =
        defaultReservation.services.map((s) => s.id).toSet();
    final currentServiceIds = selectedServices.map((s) => s.id).toSet();

    return defaultReservation.barber.id == currentBarber.id &&
        defaultServiceIds.length == currentServiceIds.length &&
        defaultServiceIds.containsAll(currentServiceIds);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
