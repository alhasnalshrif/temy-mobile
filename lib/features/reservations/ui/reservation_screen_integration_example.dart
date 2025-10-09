import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/widgets/app_text_button.dart';
import 'package:temy_barber/features/reservations/logic/queue_cubit.dart';
import 'package:temy_barber/features/reservations/logic/queue_state.dart';
import 'package:temy_barber/features/reservations/ui/queue_position_screen.dart';
import 'package:temy_barber/features/reservations/ui/widgets/queue_section.dart';
import 'package:temy_barber/features/reservations/ui/widgets/time_slot_section.dart';

/// Example of how to integrate queue mode into the reservation screen
/// This is a template - adapt it to your existing reservations_screen.dart
class ReservationScreenExample extends StatefulWidget {
  final String barberId;
  final String barberName;
  final String? barberAvatar;
  final List<String> selectedServiceIds;
  final String? userId;
  final bool isQueueMode; // Get this from settings API

  const ReservationScreenExample({
    super.key,
    required this.barberId,
    required this.barberName,
    this.barberAvatar,
    required this.selectedServiceIds,
    this.userId,
    required this.isQueueMode,
  });

  @override
  State<ReservationScreenExample> createState() =>
      _ReservationScreenExampleState();
}

class _ReservationScreenExampleState extends State<ReservationScreenExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reservation - ${widget.barberName}')),
      body: BlocProvider(
        // Provide QueueCubit
        create: (context) => getIt<QueueCubit>(),
        child: BlocListener<QueueCubit, QueueState>(
          // Listen for queue position success to navigate (after joining queue)
          listener: (context, state) {
            state.maybeWhen(
              queuePositionSuccess: (data) {
                // Navigate to queue position screen only once
                if (ModalRoute.of(context)?.isCurrent ?? false) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: context.read<QueueCubit>(),
                        child: QueuePositionScreen(
                          reservationId: data.reservation.id,
                          barberId: widget.barberId,
                          barberName: widget.barberName,
                        ),
                      ),
                    ),
                  );
                }
              },
              joinQueueError: (error) {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error), backgroundColor: Colors.red),
                );
              },
              orElse: () {},
            );
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Barber Info Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        if (widget.barberAvatar != null)
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(widget.barberAvatar!),
                          )
                        else
                          const CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.person),
                          ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.barberName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.isQueueMode
                                    ? 'Queue Mode Active'
                                    : 'Time Slot Booking',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: widget.isQueueMode
                                      ? Colors.green
                                      : Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Mode-specific UI
                if (widget.isQueueMode) ...[
                  // Queue Mode UI
                  _buildQueueModeUI(context),
                ] else ...[
                  // Time Slot Mode UI (your existing implementation)
                  _buildTimeSlotModeUI(context),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQueueModeUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Show live queue status
        QueueSection(
          barberId: widget.barberId,
          barberName: widget.barberName,
          barberAvatar: widget.barberAvatar,
        ),
        const SizedBox(height: 24),

        // Join Queue Button
        BlocBuilder<QueueCubit, QueueState>(
          builder: (context, state) {
            return state.maybeWhen(
              joinQueueLoading: () => AppTextButton(
                buttonText: 'Joining Queue...',
                textStyle: const TextStyle(color: Colors.white),
                onPressed: () {}, // Disabled state
              ),
              orElse: () => AppTextButton(
                buttonText: 'Join Queue',
                textStyle: const TextStyle(color: Colors.white),
                onPressed: () {
                  // Validate services are selected
                  if (widget.selectedServiceIds.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select at least one service'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                    return;
                  }

                  // Join the queue
                  context.read<QueueCubit>().joinQueue(
                    barberId: widget.barberId,
                    serviceIds: widget.selectedServiceIds,
                    userId: widget.userId,
                  );
                },
              ),
            );
          },
        ),

        const SizedBox(height: 16),

        // Info card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'How Queue Mode Works',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text('• Join the queue and get your queue number'),
              Text('• See your position and estimated wait time'),
              Text('• Position updates automatically'),
              Text('• Get notified when it\'s your turn'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlotModeUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Your existing time slot UI
        TimeSlotSection(
          barberData: null, // Pass actual barber data
          selectedTime: null, // Pass selected time
          onTimeSelected: (time) {
            // Handle time selection
          },
          totalDuration: 0, // Pass total duration
        ),

        const SizedBox(height: 24),

        // Book Appointment Button (your existing implementation)
        AppTextButton(
          buttonText: 'Book Appointment',
          textStyle: const TextStyle(color: Colors.white),
          onPressed: () {
            // Your existing booking logic
          },
        ),
      ],
    );
  }
}

/// Example: Get settings and determine mode
/// Add this to your settings cubit or repository
class SettingsExample {
  bool isQueueMode = false;
  int maxQueueSize = 50;
  int estimatedServiceTime = 30;

  // Fetch from your settings API
  Future<void> loadSettings() async {
    // Call: GET /api/v1/settings
    // Parse response and update fields
  }
}

/// Example: Navigate to reservation screen with mode
void navigateToReservation(
  BuildContext context, {
  required String barberId,
  required String barberName,
  String? barberAvatar,
  required List<String> selectedServiceIds,
  String? userId,
  required bool isQueueMode,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ReservationScreenExample(
        barberId: barberId,
        barberName: barberName,
        barberAvatar: barberAvatar,
        selectedServiceIds: selectedServiceIds,
        userId: userId,
        isQueueMode: isQueueMode,
      ),
    ),
  );
}
