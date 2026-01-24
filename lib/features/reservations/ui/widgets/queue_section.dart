import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
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
                    buttonText: 'queue.retry'.tr(),
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
                  color: ColorsManager.mainBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.people, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          'queue.live_status'.tr(),
                          style: const TextStyle(
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
                        Row(
                          children: [
                            const Icon(Icons.cut, color: Colors.green, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              'queue.now_serving'.tr(),
                              style: const TextStyle(
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
                              '${'queue.queue_number_label'.tr()} #${currentCustomer.queueNumber}',
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
                                  'queue.service_duration'.tr(
                                    args: [
                                      currentCustomer.totalDuration.toString(),
                                    ],
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'queue.service_count'.tr(
                                    args: [
                                      currentCustomer.services.length
                                          .toString(),
                                    ],
                                  ),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'queue.people_waiting'.tr(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
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
                          Text(
                            'queue.est_wait_time'.tr(),
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            'queue.est_wait'.tr(
                              args: [queueData.estimatedServiceTime.toString()],
                            ),
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
                Text(
                  'queue.waiting_queue'.tr(),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        'queue.position'.tr(args: [(index + 1).toString()]),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${'queue.service_count'.tr(args: [customer.services.length.toString()])} • ${'queue.service_duration'.tr(args: [customer.totalDuration.toString()])}',
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
                            'queue.est_wait'.tr(
                              args: [estimatedWait.toString()],
                            ),
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
                    'queue.more_waiting'.tr(
                      args: [(waitingCount - 5).toString()],
                    ),
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
                label: Text('queue.refresh'.tr()),
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
