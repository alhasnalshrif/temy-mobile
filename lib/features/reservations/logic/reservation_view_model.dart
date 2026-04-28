import 'package:flutter/material.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/data/models/default_reservation.dart';
import 'package:temy_barber/features/reservations/data/repos/default_reservation_storage.dart';
import 'package:temy_barber/features/reservations/data/models/time_slots_response.dart';

/// ViewModel that manages all business logic for the Reservations screen.
/// This separates UI concerns from business logic for better maintainability.
class ReservationViewModel extends ChangeNotifier {
  // Private state
  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime.now();
  String? _selectedTime;
  bool _isLoadingDialogShowing = false;
  TimeSlotsResponse? _timeSlotsData;
  bool _isLoadingTimeSlots = false;
  bool _isQueueMode = false;
  bool _isLoadingSettings = true;
  bool _isDefault = false;

  // Dependencies
  final ReservationArguments? arguments;
  final DefaultReservationStorage _defaultReservationStorage =
      DefaultReservationStorage();

  ReservationViewModel({this.arguments}) {
    _selectedDate = arguments?.selectedDate ?? DateTime.now();
    _selectedTime = arguments?.selectedTime;
    _isQueueMode = arguments?.isQueueMode ?? false;
    _currentMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  // Getters
  DateTime get selectedDate => _selectedDate;
  DateTime get currentMonth => _currentMonth;
  String? get selectedTime => _selectedTime;
  bool get isLoadingDialogShowing => _isLoadingDialogShowing;
  TimeSlotsResponse? get timeSlotsData => _timeSlotsData;
  bool get isLoadingTimeSlots => _isLoadingTimeSlots;
  bool get isQueueMode => _isQueueMode;
  bool get isLoadingSettings => _isLoadingSettings;
  bool get isDefault => _isDefault;

  BarberDetailData? get barberData => arguments?.barberData;
  List<BarberService> get selectedServices => arguments?.selectedServices ?? [];
  double get totalPrice => arguments?.totalPrice ?? 0.0;

  /// Maximum booking days from barber settings
  int get maxBookingDays => barberData?.maxReservationDays ?? 30;

  /// Total duration of all selected services in minutes
  int get totalDuration =>
      selectedServices.fold(0, (sum, service) => sum + service.duration);

  /// Check if booking can proceed
  /// For queue mode: only services needed
  /// For time-slot mode: services + selected time needed
  bool get canBook {
    if (_isQueueMode) {
      return selectedServices.isNotEmpty;
    }
    return _selectedTime != null && selectedServices.isNotEmpty;
  }

  // Setters with notification
  void setSelectedDate(DateTime date) {
    if (_selectedDate != date) {
      _selectedDate = date;
      _selectedTime = null; // Reset time when date changes
      notifyListeners();
    }
  }

  void setCurrentMonth(DateTime month) {
    if (_currentMonth != month) {
      _currentMonth = month;
      notifyListeners();
    }
  }

  void setSelectedTime(String? time) {
    if (_selectedTime != time) {
      _selectedTime = time;
      notifyListeners();
    }
  }

  void setLoadingDialogShowing(bool value) {
    _isLoadingDialogShowing = value;
  }

  void setTimeSlotsData(TimeSlotsResponse? data) {
    _timeSlotsData = data;
    notifyListeners();
  }

  void setLoadingTimeSlots(bool value) {
    _isLoadingTimeSlots = value;
    notifyListeners();
  }

  void setQueueMode(bool value) {
    _isQueueMode = value;
    notifyListeners();
  }

  void setLoadingSettings(bool value) {
    _isLoadingSettings = value;
    notifyListeners();
  }

  /// Update state when time slots are loading
  void onTimeSlotsLoading() {
    _isLoadingTimeSlots = true;
    _timeSlotsData = null;
    _selectedTime = null;
    notifyListeners();
  }

  /// Update state when time slots load successfully
  void onTimeSlotsSuccess(TimeSlotsResponse response) {
    _isLoadingTimeSlots = false;
    _timeSlotsData = response;
    notifyListeners();
  }

  /// Update state when time slots fail to load
  void onTimeSlotsError() {
    _isLoadingTimeSlots = false;
    _timeSlotsData = null;
    notifyListeners();
  }

  /// Update state when queue settings are loading
  void onQueueSettingsLoading() {
    _isLoadingSettings = true;
    notifyListeners();
  }

  /// Update state when queue settings load successfully
  void onQueueSettingsSuccess(bool isQueueMode) {
    _isLoadingSettings = false;
    _isQueueMode = isQueueMode;
    notifyListeners();
  }

  /// Update state when queue settings fail to load
  void onQueueSettingsError() {
    _isLoadingSettings = false;
    _isQueueMode = false;
    notifyListeners();
  }

  /// Build reservation arguments for navigation
  ReservationArguments buildReservationArguments() {
    return ReservationArguments(
      selectedServices: selectedServices,
      barberData: barberData,
      selectedDate: _selectedDate,
      selectedTime: _selectedTime,
      totalPrice: totalPrice,
      isQueueMode: _isQueueMode,
    );
  }

  /// Save current reservation as default for quick booking
  Future<void> saveAsDefault() async {
    final currentBarberData = barberData;
    if (currentBarberData == null || selectedServices.isEmpty) return;

    final defaultReservation = DefaultReservation(
      barber: currentBarberData,
      services: selectedServices,
      totalPrice: totalPrice,
    );

    await _defaultReservationStorage.save(defaultReservation);

    _isDefault = true;
    notifyListeners();
  }

  /// Remove the saved default reservation
  Future<void> removeDefault() async {
    await _defaultReservationStorage.remove();

    _isDefault = false;
    notifyListeners();
  }

  /// Check if the current reservation matches the saved default
  Future<void> checkIsDefault() async {
    final currentBarberData = barberData;
    if (currentBarberData == null || selectedServices.isEmpty) {
      _isDefault = false;
      notifyListeners();
      return;
    }

    try {
      final defaultReservation = await _defaultReservationStorage.load();
      final defaultServiceIds =
          defaultReservation?.services.map((service) => service.id).toSet() ??
          {};
      final currentServiceIds = selectedServices
          .map((service) => service.id)
          .toSet();

      _isDefault =
          defaultReservation?.barber.id == currentBarberData.id &&
          defaultServiceIds.length == currentServiceIds.length &&
          defaultServiceIds.containsAll(currentServiceIds);
    } catch (e) {
      _isDefault = false;
    }
    notifyListeners();
  }

  /// Format date for API requests
  String formatDateForApi(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    super.dispose();
  }
}
