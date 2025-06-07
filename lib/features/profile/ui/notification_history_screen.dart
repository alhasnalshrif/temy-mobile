import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/profile/logic/notification_cubit.dart';
import 'package:temy_barber/features/profile/data/models/notification_response.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationHistoryScreen extends StatefulWidget {
  const NotificationHistoryScreen({super.key});

  @override
  State<NotificationHistoryScreen> createState() =>
      _NotificationHistoryScreenState();
}

class _NotificationHistoryScreenState extends State<NotificationHistoryScreen> {
  late NotificationCubit notificationCubit;

  @override
  void initState() {
    super.initState();
    notificationCubit = getIt<NotificationCubit>();
    notificationCubit.getNotificationHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'notifications.history'.tr(),
          style: TextStyles.font18DarkBold,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorsManager.mainBlue),
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        bloc: notificationCubit,
        builder: (context, state) {
          if (state.runtimeType.toString().contains('Loading')) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.mainBlue,
              ),
            );
          } else if (state.runtimeType.toString().contains('HistoryLoaded')) {
            final historyState = state as dynamic;
            final notifications = historyState.history.notifications
                as List<NotificationHistoryItem>;

            if (notifications.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_none,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    verticalSpace(16),
                    Text(
                      'notifications.no_history'.tr(),
                      style: TextStyles.font12GreyMedium,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationCard(notification);
              },
            );
          } else if (state.runtimeType.toString().contains('Error')) {
            final errorState = state as dynamic;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 80,
                    color: Colors.red[400],
                  ),
                  verticalSpace(16),
                  Text(
                    errorState.message,
                    style: TextStyles.font16GreyMedium,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(16),
                  ElevatedButton(
                    onPressed: () => notificationCubit.getNotificationHistory(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.mainBlue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('common.retry'.tr()),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildNotificationCard(NotificationHistoryItem notification) {
    final isRead = notification.readAt != null;
    final createdAt = DateTime.parse(notification.createdAt);
    final formattedDate = DateFormat('MMM dd, yyyy - HH:mm').format(createdAt);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (!isRead) {
            notificationCubit.markNotificationAsRead(notification.id);
          }
          _handleNotificationTap(notification);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isRead
                ? Colors.white
                : ColorsManager.lightBlue.withOpacity(0.1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _getNotificationIcon(notification.type),
                  horizontalSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title,
                          style: isRead
                              ? TextStyles.font16DarkBold
                              : TextStyles.font16DarkBold.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                        ),
                        verticalSpace(4),
                        Text(
                          formattedDate,
                          style: TextStyles.font13GrayRegular,
                        ),
                      ],
                    ),
                  ),
                  if (!isRead)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: ColorsManager.mainBlue,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              verticalSpace(8),
              Text(
                notification.body,
                style: TextStyles.font14GrayRegular,
              ),
              if (notification.type != 'general') ...[
                verticalSpace(8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getTypeColor(notification.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getTypeLabel(notification.type),
                    style: TextStyles.font13GrayRegular.copyWith(
                      color: _getTypeColor(notification.type),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _getNotificationIcon(String type) {
    IconData iconData;
    Color iconColor;

    switch (type) {
      case 'booking_confirmed':
        iconData = Icons.check_circle;
        iconColor = Colors.green;
        break;
      case 'booking_reminder':
        iconData = Icons.access_time;
        iconColor = Colors.orange;
        break;
      case 'promotion':
        iconData = Icons.local_offer;
        iconColor = Colors.purple;
        break;
      case 'booking_cancelled':
        iconData = Icons.cancel;
        iconColor = Colors.red;
        break;
      default:
        iconData = Icons.notifications;
        iconColor = ColorsManager.mainBlue;
    }

    return Icon(iconData, color: iconColor, size: 24);
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'booking_confirmed':
        return Colors.green;
      case 'booking_reminder':
        return Colors.orange;
      case 'promotion':
        return Colors.purple;
      case 'booking_cancelled':
        return Colors.red;
      default:
        return ColorsManager.mainBlue;
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case 'booking_confirmed':
        return 'notifications.booking_confirmed'.tr();
      case 'booking_reminder':
        return 'notifications.booking_reminder'.tr();
      case 'promotion':
        return 'notifications.promotion'.tr();
      case 'booking_cancelled':
        return 'notifications.booking_cancelled'.tr();
      default:
        return 'notifications.general'.tr();
    }
  }

  void _handleNotificationTap(NotificationHistoryItem notification) {
    // Handle navigation based on notification type
    if (notification.data != null) {
      final data = notification.data!;
      final bookingId = data['booking_id'];

      switch (notification.type) {
        case 'booking_confirmed':
        case 'booking_reminder':
        case 'booking_cancelled':
          if (bookingId != null) {
            // Navigate to booking details
            // Navigator.pushNamed(context, Routes.bookingDetails, arguments: bookingId);
          } else {
            // Navigate to bookings list
            // Navigator.pushNamed(context, Routes.bookings);
          }
          break;
        case 'promotion':
          // Navigate to promotions or services
          // Navigator.pushNamed(context, Routes.services);
          break;
        default:
          // Default navigation or show dialog
          break;
      }
    }
  }
}
