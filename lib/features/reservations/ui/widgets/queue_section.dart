import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/widgets/app_text_button.dart';
import 'package:temy_barber/features/reservations/logic/queue_cubit.dart';
import 'package:temy_barber/features/reservations/logic/queue_state.dart';

class QueueSection extends StatefulWidget {
  final String barberId;
  final String barberName;
  final String? barberAvatar;

  const QueueSection({
    super.key,
    required this.barberId,
    required this.barberName,
    this.barberAvatar,
  });

  @override
  State<QueueSection> createState() => _QueueSectionState();
}

class _QueueSectionState extends State<QueueSection> {
  @override
  void initState() {
    super.initState();
    // Load initial queue status
    context.read<QueueCubit>().getQueueStatus(barberId: widget.barberId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueueCubit, QueueState>(
      builder: (context, state) {
        if (state is QueueStatusLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is QueueStatusError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 8),
                  Text(state.error, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  AppTextButton(
                    buttonText: 'Retry',
                    textStyle: const TextStyle(color: Colors.white),
                    onPressed: () {
                      context.read<QueueCubit>().getQueueStatus(
                        barberId: widget.barberId,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }

        if (state is QueueStatusSuccess) {
          final queueData = state.data.queue;
          final currentCustomer = queueData.currentCustomer;
          final waitingCount = queueData.waitingCustomers.length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [ColorsManager.mainBlue, Colors.blueAccent],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Live Queue Status',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.barberName,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Current Customer Being Served
              if (currentCustomer != null) ...[
                Card(
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.cut, color: Colors.green, size: 24),
                            SizedBox(width: 8),
                            Text(
                              'Now Serving',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Queue #${currentCustomer.queueNumber}',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${currentCustomer.totalDuration} min',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  '${currentCustomer.services.length} service(s)',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Waiting Queue Info
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'People Waiting',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 4),
                            ],
                          ),
                          Text(
                            '$waitingCount',
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.mainBlue,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Est. Wait Time per Person',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            '~${queueData.estimatedServiceTime} min',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Waiting Customers List
              if (waitingCount > 0) ...[
                const Text(
                  'Waiting Queue',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...queueData.waitingCustomers.take(5).toList().asMap().entries.map((
                  entry,
                ) {
                  final index = entry.key;
                  final customer = entry.value;
                  final estimatedWait = index * queueData.estimatedServiceTime;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: ColorsManager.mainBlue,
                        child: Text(
                          '#${customer.queueNumber}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        'Queue Position ${index + 1}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${customer.services.length} service(s) • ${customer.totalDuration} min',
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey,
                          ),
                          Text(
                            '~$estimatedWait min',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                if (waitingCount > 5) ...[
                  const SizedBox(height: 8),
                  Text(
                    'And ${waitingCount - 5} more waiting...',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],

              const SizedBox(height: 16),

              // Refresh Button
              OutlinedButton.icon(
                onPressed: () {
                  context.read<QueueCubit>().getQueueStatus(
                    barberId: widget.barberId,
                  );
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh Queue'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
