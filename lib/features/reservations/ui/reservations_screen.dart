import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/routing/routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
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
import 'package:temy_barber/core/widgets/shimmer_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
  bool _isQueueMode = false; // Track if queue mode is enabled
  bool _isLoadingSettings = true; // Track if settings are being loaded

  // Get barber and services data
  BarberDetailData? get barberData => widget.arguments?.barberData;

  // Maximum number of days ahead that can be booked (from barber settings)
  int get maxBookingDays => barberData?.maxReservationDays ?? 30;
  List<BarberService> get selectedServices =>
      widget.arguments?.selectedServices ?? [];
  double get totalPrice => widget.arguments?.totalPrice ?? 0.0;

  // Get total duration of selected services in minutes
  int get totalDuration =>
      selectedServices.fold(0, (sum, service) => sum + service.duration);

  // Check if booking is possible
  // For queue mode: only services needed
  // For time-slot mode: services + selected time needed
  bool get canBook {
    if (_isQueueMode) {
      return selectedServices.isNotEmpty;
    } else {
      return _selectedTime != null && selectedServices.isNotEmpty;
    }
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    currentMonth = DateTime(selectedDate.year, selectedDate.month, 1);

    print(
      '🔍 ReservationsScreen: initState - Initial _isQueueMode: $_isQueueMode',
    );

    // Fetch queue settings first to determine the mode
    _fetchQueueSettings();

    // Fetch time slots for the initial date when screen loads
    _fetchAvailableTimeSlots();
  }

  // Fetch queue settings to check if queue mode is enabled
  void _fetchQueueSettings() {
    print('🔍 ReservationsScreen: Fetching queue settings...');
    context.read<ReservationCubit>().getQueueSettings();
  }

  // Save current reservation as default
  Future<void> _saveAsDefault() async {
    if (barberData != null && selectedServices.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();

      // Create a map with all necessary data
      final Map<String, dynamic> defaultReservation = {
        'barber': {
          'id': barberData!.id,
          'name': barberData!.name,
          'avatar': barberData!.avatar,
        },
        'services': selectedServices
            .map(
              (service) => {
                'id': service.id,
                'name': service.name,
                'price': service.price,
                'duration': service.duration,
                'category': service.category,
                'imageCover': service.imageCover,
              },
            )
            .toList(),
        'totalPrice': totalPrice,
      };

      // Save as JSON string
      await prefs.setString(
        'default_reservation',
        jsonEncode(defaultReservation),
      );
    }
  }

  void _fetchAvailableTimeSlots() {
    if (barberData?.id != null) {
      context.read<ReservationCubit>().getAvailableTimeSlots(
        barberId: barberData!.id,
        date: selectedDate,
      );
    }
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
          child: ShimmerLoading.circular(size: 50), // Example shimmer
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReservationCubit, ReservationState>(
      listener: (context, state) {
        state.maybeWhen(
          queueSettingsLoading: () {
            print('🔍 ReservationsScreen: Queue settings loading...');
            setState(() {
              _isLoadingSettings = true;
            });
          },
          queueSettingsSuccess: (settingsResponse) {
            print('✅ ReservationsScreen: Queue settings success!');
            print('   isQueueMode: ${settingsResponse.data?.isQueueMode}');
            setState(() {
              _isLoadingSettings = false;
              _isQueueMode = settingsResponse.data?.isQueueMode ?? false;
            });
            print('   Updated _isQueueMode to: $_isQueueMode');
          },
          queueSettingsError: (error) {
            print('❌ ReservationsScreen: Queue settings error: $error');
            setState(() {
              _isLoadingSettings = false;
              _isQueueMode = false; // Default to time-slot mode on error
            });
          },
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
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.invoiceScreen,
              arguments: response,
              (route) => false, // Remove all previous routes
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
                content: Text(
                  '${'booking.load_error'.tr()}: ${error.toString()}',
                ),
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
              title: Text('تفاصيل الحجز', style: TextStyles.font18DarkBlueBold),
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
                            // DEBUG: Show current mode
                            ServicesSection(services: selectedServices),
                            const SizedBox(height: 24),

                            // Show EITHER Queue Mode OR Time-Slot Reservation
                            if (_isQueueMode) ...[
                              // Queue Mode UI
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: ColorsManager.mainBlue.withOpacity(
                                    0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: ColorsManager.mainBlue,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.people_outline,
                                          color: ColorsManager.mainBlue,
                                          size: 24,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            'booking.queue_mode'.tr(),
                                            style: TextStyles.font18DarkBlueBold
                                                .copyWith(
                                                  color: ColorsManager.mainBlue,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'booking.queue_mode_description'.tr(),
                                      style: TextStyles.font14GrayRegular,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${'booking.queue_mode_benefit_1'.tr()}\n'
                                      '${'booking.queue_mode_benefit_2'.tr()}\n',
                                      style: TextStyles.font14GrayRegular
                                          .copyWith(height: 1.5),
                                    ),
                                  ],
                                ),
                              ),
                            ] else ...[
                              // Time-Slot Reservation UI
                              CalendarSection(
                                maxBookingDays: maxBookingDays,
                                initialDate: selectedDate,
                                initialMonth: currentMonth,
                                daysOff: barberData?.workingHours.daysOff,
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
                                  final previousSelection = _selectedTime;
                                  setState(() {
                                    _selectedTime = time;
                                  });

                                  if (previousSelection != null &&
                                      time == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          'الوقت المختار لا يتوافق مع مدة الخدمات المختارة',
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor:
                                            Colors.red[700] ?? Colors.red,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],

                            const SizedBox(height: 24),
                            TotalSection(totalPrice: totalPrice),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        // Save as Default button
                        Expanded(
                          flex: 3,
                          child: AnimatedOpacity(
                            opacity:
                                canBook &&
                                    state.maybeWhen(
                                      reservationLoading: () => false,
                                      orElse: () => true,
                                    )
                                ? 1.0
                                : 0.7,
                            duration: const Duration(milliseconds: 200),
                            child: ElevatedButton(
                              onPressed:
                                  canBook &&
                                      state.maybeWhen(
                                        reservationLoading: () => false,
                                        orElse: () => true,
                                      )
                                  ? () {
                                      _saveAsDefault();
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'default_booking.saved_as_default'
                                                .tr(),
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.green[700],
                                        ),
                                      );
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 56),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.white.withOpacity(0.1),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                    color: ColorsManager.mainBlue,
                                    width: 1.5,
                                  ),
                                ),
                                padding: EdgeInsets.zero,
                                surfaceTintColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                disabledBackgroundColor:
                                    ColorsManager.lightBlue,
                              ),
                              child: Text(
                                'default_booking.save_as_default'.tr(),
                                style: const TextStyle(
                                  color: ColorsManager.mainBlue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Next button
                        Expanded(
                          flex: 5,
                          child: AnimatedOpacity(
                            opacity:
                                canBook &&
                                    state.maybeWhen(
                                      reservationLoading: () => false,
                                      orElse: () => true,
                                    )
                                ? 1.0
                                : 0.7,
                            duration: const Duration(milliseconds: 200),
                            child: ElevatedButton(
                              onPressed:
                                  canBook &&
                                      state.maybeWhen(
                                        reservationLoading: () => false,
                                        orElse: () => true,
                                      )
                                  ? () {
                                      final args = ReservationArguments(
                                        selectedServices: selectedServices,
                                        barberData: barberData,
                                        selectedDate: selectedDate,
                                        selectedTime: _selectedTime,
                                        totalPrice: totalPrice,
                                        isQueueMode: _isQueueMode,
                                      );
                                      Navigator.pushNamed(
                                        context,
                                        Routes.bookingConfirmationScreen,
                                        arguments: args,
                                      );
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 56),
                                backgroundColor: ColorsManager.mainBlue,
                                foregroundColor: Colors.white.withOpacity(0.1),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.zero,
                                surfaceTintColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                disabledBackgroundColor: Colors.grey.shade400,
                              ),
                              child: const Text(
                                'التالي',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
