import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';

/// State for barber service selection
class BarberServiceSelectionState {
  final Set<BarberService> selectedServices;
  final double totalPrice;
  final String? selectedTime;

  const BarberServiceSelectionState({
    this.selectedServices = const {},
    this.totalPrice = 0,
    this.selectedTime,
  });

  int get totalDuration => selectedServices.fold(0, (t, s) => t + s.duration);

  bool get hasSelection => selectedServices.isNotEmpty;

  BarberServiceSelectionState copyWith({
    Set<BarberService>? selectedServices,
    double? totalPrice,
    String? selectedTime,
  }) {
    return BarberServiceSelectionState(
      selectedServices: selectedServices ?? this.selectedServices,
      totalPrice: totalPrice ?? this.totalPrice,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }
}

/// Cubit for managing barber service selection
class BarberServiceSelectionCubit extends Cubit<BarberServiceSelectionState> {
  BarberServiceSelectionCubit() : super(const BarberServiceSelectionState());

  /// Toggle service selection
  void toggleService(BarberService service, double price) {
    final newSelectedServices = Set<BarberService>.from(state.selectedServices);
    double newTotalPrice = state.totalPrice;

    if (newSelectedServices.any((s) => s.id == service.id)) {
      newSelectedServices.removeWhere((s) => s.id == service.id);
      newTotalPrice -= price;
    } else {
      newSelectedServices.add(service);
      newTotalPrice += price;
    }

    emit(state.copyWith(
      selectedServices: newSelectedServices,
      totalPrice: newTotalPrice,
    ));
  }

  /// Check if a service is selected
  bool isServiceSelected(String serviceId) {
    return state.selectedServices.any((s) => s.id == serviceId);
  }

  /// Select a time slot
  void selectTime(String? time) {
    emit(state.copyWith(selectedTime: time));
  }

  /// Clear all selections
  void clearSelection() {
    emit(const BarberServiceSelectionState());
  }

  /// Get selected services as list
  List<BarberService> get selectedServicesList => state.selectedServices.toList();
}
