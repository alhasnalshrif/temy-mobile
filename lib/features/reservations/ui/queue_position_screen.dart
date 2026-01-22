import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/widgets/app_text_button.dart';
import 'package:temy_barber/features/reservations/logic/queue_cubit.dart';
import 'package:temy_barber/features/reservations/logic/queue_state.dart';

class QueuePositionScreen extends StatefulWidget {
  final String reservationId;
  final String barberId;
  final String barberName;

  const QueuePositionScreen({
    super.key,
    required this.reservationId,
    required this.barberId,
    required this.barberName,
  });

  @override
  State<QueuePositionScreen> createState() => _QueuePositionScreenState();
}

class _QueuePositionScreenState extends State<QueuePositionScreen> {
  @override
  void initState() {
    super.initState();
    // Start polling for queue position updates
    context.read<QueueCubit>().startPollingQueuePosition(
      widget.reservationId,
      intervalSeconds: 10,
    );
  }

  @override
  void dispose() {
    // Stop polling when screen is closed
    context.read<QueueCubit>().stopPolling();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Queue Status - ${widget.barberName}'),
        backgroundColor: ColorsManager.mainBlue,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<QueueCubit, QueueState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Loading...')),
            joinQueueLoading: () =>
                const Center(child: CircularProgressIndicator()),
            joinQueueSuccess: (data) =>
                const Center(child: Text('Successfully joined queue')),
            joinQueueError: (error) => Center(child: Text('Error: $error')),
            queueStatusLoading: () =>
                const Center(child: CircularProgressIndicator()),
            queueStatusSuccess: (data) =>
                const Center(child: Text('Queue Status')),
            queueStatusError: (error) => Center(child: Text('Error: $error')),
            queuePositionLoading: () =>
                const Center(child: CircularProgressIndicator()),
            queuePositionSuccess: (data) => _buildQueuePositionView(data),
            queuePositionError: (error) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: $error'),
                  const SizedBox(height: 16),
                  AppTextButton(
                    buttonText: 'Retry',
                    textStyle: const TextStyle(color: Colors.white),
                    onPressed: () {
                      context.read<QueueCubit>().getMyQueuePosition(
                        widget.reservationId,
                      );
                    },
                  ),
                ],
              ),
            ),
            queueActionLoading: () =>
                const Center(child: CircularProgressIndicator()),
            queueActionSuccess: (message) => Center(child: Text(message)),
            queueActionError: (error) => Center(child: Text('Error: $error')),
          );
        },
      ),
    );
  }

  Widget _buildQueuePositionView(data) {
    final peopleAhead = data.peopleAhead;
    final status = data.queueStatus;
    final reservation = data.reservation;

    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (status) {
      case 'waiting':
        statusColor = Colors.orange;
        statusText = 'Waiting in Queue';
        statusIcon = Icons.hourglass_empty;
        break;
      case 'in_service':
        statusColor = Colors.green;
        statusText = 'Your Turn - In Service';
        statusIcon = Icons.cut;
        break;
      case 'completed':
        statusColor = Colors.blue;
        statusText = 'Service Completed';
        statusIcon = Icons.check_circle;
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'Unknown Status';
        statusIcon = Icons.help_outline;
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<QueueCubit>().getMyQueuePosition(widget.reservationId);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Card
            Card(
              color: statusColor.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(statusIcon, size: 64, color: statusColor),
                    const SizedBox(height: 16),
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Queue Number
            _buildInfoCard(
              icon: Icons.confirmation_number,
              title: 'Queue Number',
              value: '#${reservation.queueNumber}',
              color: ColorsManager.mainBlue,
            ),
            const SizedBox(height: 16),

            // Current Position
            if (status == 'waiting') ...[
              _buildInfoCard(
                icon: Icons.people,
                title: 'People Ahead',
                value: '$peopleAhead',
                color: Colors.orange,
              ),
              const SizedBox(height: 16),
            ],

            // Services
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.cut, color: ColorsManager.mainBlue),
                        SizedBox(width: 8),
                        Text(
                          'Services',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...reservation.services.map(
                      (service) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(service.name),
                            Text(
                              '${service.duration} min',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Duration',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${reservation.totalDuration} min',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Auto-refresh indicator
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorsManager.lightBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh, size: 16, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(
                    'Auto-updating every 10 seconds',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
