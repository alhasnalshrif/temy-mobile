import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/routing/routes.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/data/models/time_slots_response.dart';
import 'package:temy_barber/features/reservations/logic/reservation_cubit.dart';
import 'package:temy_barber/features/reservations/logic/reservation_state.dart';
import 'package:temy_barber/features/reservations/ui/widgets/services_section.dart';
import 'package:temy_barber/features/reservations/ui/widgets/calendar_section.dart';
import 'package:temy_barber/features/reservations/ui/widgets/time_slot_section.dart';
import 'package:temy_barber/features/reservations/ui/widgets/total_section.dart';
import 'package:temy_barber/features/reservations/ui/widgets/book_button.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart'; // Import shimmer
import 'package:easy_localization/easy_localization.dart';

class ReservationsScreen extends StatefulWidget {
  final ReservationArguments? arguments;

  const ReservationsScreen({super.key, this.arguments});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  // Use current date as the default selected date
  late DateTime selectedDate;
  late DateTime currentMonth;
  String? _selectedTime;
  bool _isLoadingDialogShowing = false;
  TimeSlotsResponse? _timeSlotsData;
  bool _isLoadingTimeSlots = false;

  // Maximum number of days ahead that can be booked
  final int maxBookingDays = 30; // You can adjust this value as needed

  // Get barber and services data
  BarberDetailData? get barberData => widget.arguments?.barberData;
  List<BarberService> get selectedServices =>
      widget.arguments?.selectedServices ?? [];
  double get totalPrice => widget.arguments?.totalPrice ?? 0.0;

  // Get total duration of selected services in minutes
  int get totalDuration =>
      selectedServices.fold(0, (sum, service) => sum + service.duration);

  // Check if booking is possible
  bool get canBook => _selectedTime != null && selectedServices.isNotEmpty;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    currentMonth = DateTime(selectedDate.year, selectedDate.month, 1);

    // Fetch time slots for the initial date when screen loads
    _fetchAvailableTimeSlots();
  }

  void _fetchAvailableTimeSlots() {
    if (barberData?.id != null) {
      context.read<ReservationCubit>().getAvailableTimeSlots(
            barberId: barberData!.id,
            date: selectedDate,
          );
    }
  }

  void _handleBooking() async {
    if (!canBook) return;

    // Get required data
    final userId =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.userId);
    // Add mounted check before using context after await
    if (!mounted) return;
    final serviceIds = selectedServices.map((s) => s.id).toList();
    final barberId = barberData?.id ?? '';
    // final date =
    //     '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
    final date =
        '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
    print(date);

    // Create ReservationArguments with date and time for the invoice screen
    final updatedArguments = ReservationArguments(
      selectedServices: selectedServices,
      barberData: barberData,
      totalPrice: totalPrice,
      selectedDate: selectedDate,
      selectedTime: _selectedTime,
    );

    // Call the reservation cubit directly
    context.read<ReservationCubit>().postReservation(
          userId: userId ?? '', // Add null check
          serviceIds: serviceIds,
          barberId: barberId,
          date: date,
          startTime: _selectedTime!,
          arguments: updatedArguments, // Pass the updated arguments
        );
  }

  void _showLoadingDialog(BuildContext context) {
    _isLoadingDialogShowing = true;
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) => PopScope(
        canPop: false, // Prevent dismissing with back button
        child: Center(
          // Replace CircularProgressIndicator with ShimmerLoading
          child: ShimmerLoading.circular(
            size: 50,
          ), // Example shimmer
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReservationCubit, ReservationState>(
      listener: (context, state) {
        state.maybeWhen(
          reservationLoading: () {
            if (!_isLoadingDialogShowing) {
              _showLoadingDialog(context);
            }
          },
          reservationSuccess: (response, arguments) {
            if (_isLoadingDialogShowing) {
              Navigator.of(context).pop(); // Dismiss loading dialog
              _isLoadingDialogShowing = false;
            }

            // Navigate to invoice screen with the updated arguments
            Navigator.pushReplacementNamed(
              context,
              Routes.invoiceScreen,
              arguments: response,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('booking.success_message'.tr()),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.green[700],
              ),
            );
          },
          reservationError: (error) {
            if (_isLoadingDialogShowing) {
              Navigator.of(context).pop(); // Dismiss loading dialog
              _isLoadingDialogShowing = false;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.red[700],
              ),
            );
          },
          timeSlotsLoading: () {
            setState(() {
              _isLoadingTimeSlots = true;
              _timeSlotsData = null;
              _selectedTime =
                  null; // Reset selected time when loading new slots
            });
          },
          timeSlotsSuccess: (response) {
            setState(() {
              _isLoadingTimeSlots = false;
              _timeSlotsData = response;
            });
          },
          timeSlotsError: (error) {
            setState(() {
              _isLoadingTimeSlots = false;
              _timeSlotsData = null;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('booking.load_error'.tr() + ': ${error.toString()}'),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.red[700],
              ),
            );
          },
          orElse: () {},
        );
      },
      child: BlocBuilder<ReservationCubit, ReservationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'تفاصيل الحجز',
                style: TextStyles.font18DarkBlueBold,
              ),
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 1,
              shadowColor: Colors.black.withOpacity(0.05),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ServicesSection(
                              services: selectedServices,
                            ),
                            const SizedBox(height: 24),
                            CalendarSection(
                              maxBookingDays: maxBookingDays,
                              initialDate: selectedDate,
                              initialMonth: currentMonth,
                              onDateSelected: (date) {
                                setState(() {
                                  selectedDate = date;
                                  // Reset time selection when date changes
                                  _selectedTime = null;
                                });
                                // Fetch time slots for the new selected date
                                _fetchAvailableTimeSlots();
                              },
                              onMonthChanged: (month) {
                                setState(() {
                                  currentMonth = month;
                                });
                              },
                            ),
                            const SizedBox(height: 24),
                            TimeSlotSection(
                              totalDuration: totalDuration,
                              barberData: barberData,
                              selectedTime: _selectedTime,
                              isLoading: _isLoadingTimeSlots,
                              timeSlotsData: _timeSlotsData,
                              onTimeSelected: (time) {
                                setState(() {
                                  _selectedTime = time;
                                });
                              },
                            ),
                            const SizedBox(height: 24),
                            TotalSection(totalPrice: totalPrice),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: BookButton(
                      isEnabled: canBook &&
                          state.maybeWhen(
                            reservationLoading: () => false,
                            orElse: () => true,
                          ),
                      onPressed: _handleBooking,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
