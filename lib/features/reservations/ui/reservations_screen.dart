import 'package:flutter/material.dart';
import 'package:flutter_complete_project/core/theme/colors.dart';
import 'package:flutter_complete_project/features/barber/data/models/barber_detail_response.dart';
import 'package:flutter_complete_project/features/barber/data/models/reservation_arguments.dart';
import 'package:flutter_complete_project/features/reservations/ui/widgets/services_section.dart';
import 'package:flutter_complete_project/features/reservations/ui/widgets/calendar_section.dart';
import 'package:flutter_complete_project/features/reservations/ui/widgets/time_slot_section.dart';
import 'package:flutter_complete_project/features/reservations/ui/widgets/total_section.dart';
import 'package:flutter_complete_project/features/reservations/ui/widgets/book_button.dart';

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

  // Maximum number of days ahead that can be booked
  final int maxBookingDays = 30; // You can adjust this value as needed

  // Get barber and services data
  BarberDetailData? get barberData => widget.arguments?.barberData;
  List<BarberService> get selectedServices =>
      widget.arguments?.selectedServices ?? [];
  double get totalPrice => widget.arguments?.totalPrice ?? 0.0;

  // Get total duration of selected services in minutes
  int get totalDuration =>
      selectedServices.fold(0, (sum, service) => sum + (service.duration ?? 0));

  // Check if booking is possible
  bool get canBook => _selectedTime != null && selectedServices.isNotEmpty;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    currentMonth = DateTime(selectedDate.year, selectedDate.month, 1);
  }

  void _handleBooking() {
    if (!canBook) return;

    // Show a confirmation dialog before proceeding
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'تأكيد الحجز',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'هل تريد تأكيد الحجز؟',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildConfirmationDetail('الخدمات:', '${selectedServices.length}'),
            _buildConfirmationDetail(
              'التاريخ:',
              '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
            ),
            _buildConfirmationDetail('الوقت:', _selectedTime!),
            _buildConfirmationDetail(
              'المبلغ الإجمالي:',
              '${totalPrice.toStringAsFixed(0)} EGP',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              // Implement booking logic
              Navigator.pop(context);

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('تم الحجز بنجاح!'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.green[700],
                ),
              );
            },
            child: const Text('تأكيد الحجز'),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(barberData?.avatar ?? ''),
              backgroundColor: Colors.grey[200],
              onBackgroundImageError: (exception, stackTrace) =>
                  const Icon(Icons.person),
            ),
            const SizedBox(width: 8),
            Text(barberData?.name ?? ""),
          ],
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.05),
        centerTitle: true,
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
                isEnabled: canBook,
                onPressed: _handleBooking,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
