import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/widgets/floating_action_pill.dart';
import 'package:temy_barber/core/widgets/snackbar_helper.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/logic/reservation_cubit.dart';
import 'package:temy_barber/features/reservations/logic/reservation_state.dart';
import 'package:temy_barber/features/reservations/logic/reservation_view_model.dart';
import 'package:temy_barber/features/reservations/ui/widgets/services_section.dart';
import 'package:temy_barber/features/reservations/ui/widgets/calendar_section.dart';
import 'package:temy_barber/features/reservations/ui/widgets/time_slot_section.dart';
import 'package:temy_barber/features/reservations/ui/widgets/total_section.dart';
import 'package:temy_barber/features/reservations/ui/widgets/queue_mode_section.dart';
import 'package:temy_barber/core/utils/responsive_utils.dart';

class ReservationsScreen extends StatefulWidget {
  final ReservationArguments? arguments;

  const ReservationsScreen({super.key, this.arguments});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  late ReservationViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ReservationViewModel(arguments: widget.arguments);
    _initializeData();
  }

  void _initializeData() {
    _viewModel.checkIsDefault();
    _fetchQueueSettings();
    _fetchAvailableTimeSlots();
  }

  void _fetchQueueSettings() {
    context.read<ReservationCubit>().getQueueSettings();
  }

  void _fetchAvailableTimeSlots() {
    final barberId = _viewModel.barberData?.id;
    if (barberId != null) {
      context.read<ReservationCubit>().getAvailableTimeSlots(
        barberId: barberId,
        date: _viewModel.selectedDate,
      );
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReservationCubit, ReservationState>(
      listener: _handleStateChanges,
      child: BlocBuilder<ReservationCubit, ReservationState>(
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            reservationLoading: () => true,
            orElse: () => false,
          );

          return Scaffold(
            appBar: _buildAppBar(),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Stack(
                children: [
                  Positioned.fill(child: _buildResponsiveLayout()),
                  Positioned(
                    right: 16,
                    bottom: MediaQuery.paddingOf(context).bottom + 12,
                    child: _buildFloatingPill(isLoading),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final isDefault = _viewModel.isDefault;

    return AppBar(
      title: Text('barber.details'.tr(), style: TextStyles.font18WhiteBold),
      backgroundColor: ColorsManager.mainBlue,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        color: Colors.white,
        onPressed: () => context.pop(),
      ),
      actions: [
        _BookmarkButton(
          isDefault: isDefault,
          onTap: _handleSaveAsDefault,
        ),
      ],
    );
  }

  Widget _buildResponsiveLayout() {
    return ResponsiveBuilder(
      mobile: _buildMobileLayout(),
      tablet: _buildTabletLayout(),
      desktop: _buildTabletLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ServicesSection(services: _viewModel.selectedServices),
            const SizedBox(height: 24),
            _buildBookingContent(),
            const SizedBox(height: 24),
            TotalSection(totalPrice: _viewModel.totalPrice),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Container(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ServicesSection(services: _viewModel.selectedServices),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      _buildBookingContent(),
                      const SizedBox(height: 24),
                      TotalSection(totalPrice: _viewModel.totalPrice),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookingContent() {
    if (_viewModel.isQueueMode) {
      return const QueueModeSection();
    }

    return Column(
      children: [
        CalendarSection(
          maxBookingDays: _viewModel.maxBookingDays,
          initialDate: _viewModel.selectedDate,
          initialMonth: _viewModel.currentMonth,
          daysOff: _viewModel.barberData?.workingHours.daysOff,
          onDateSelected: _handleDateSelected,
          onMonthChanged: _handleMonthChanged,
        ),
        const SizedBox(height: 24),
        TimeSlotSection(
          totalDuration: _viewModel.totalDuration,
          barberData: _viewModel.barberData,
          selectedTime: _viewModel.selectedTime,
          isLoading: _viewModel.isLoadingTimeSlots,
          timeSlotsData: _viewModel.timeSlotsData,
          onTimeSelected: _handleTimeSelected,
        ),
      ],
    );
  }

  Widget _buildFloatingPill(bool isLoading) {
    return FloatingActionPill(
      isLoading: isLoading,
      isEnabled: _viewModel.canBook,
      onTap: _handleProceed,
    );
  }

  void _handleStateChanges(BuildContext context, ReservationState state) {
    state.maybeWhen(
      queueSettingsLoading: () => _viewModel.setQueueSettingsLoading(true),
      queueSettingsSuccess: (settings) {
        _viewModel.setQueueMode(settings.data?.isQueueMode ?? false);
        setState(() {});
      },
      queueSettingsError: (_) {
        _viewModel.setQueueMode(false);
        setState(() {});
      },
      reservationLoading: () => LoadingDialog.show(context),
      reservationSuccess: (response, _) {
        LoadingDialog.dismiss(context);
        context.go(AppRoutes.Invoice, extra: response);
        SnackbarHelper.showSuccess(context, 'booking.success_message'.tr());
      },
      reservationError: (error) {
        LoadingDialog.dismiss(context);
        _handleReservationError(error.apiErrorModel.message.toString());
      },
      timeSlotsLoading: () {
        _viewModel.setTimeSlotsLoading(true);
        setState(() {});
      },
      timeSlotsSuccess: (response) {
        _viewModel.setTimeSlotsData(response);
        setState(() {});
      },
      timeSlotsError: (error) {
        _viewModel.setTimeSlotsData(null);
        setState(() {});
        SnackbarHelper.showError(context, '${'booking.load_error'.tr()}: $error');
      },
      orElse: () {},
    );
  }

  void _handleReservationError(String errorMessage) {
    if (errorMessage.contains('overlaps with an existing booking') ||
        errorMessage.contains('overlaps') ||
        errorMessage.contains('already booked')) {
      SnackbarHelper.showError(context, 'time_slots.slot_no_longer_available'.tr());

      final barberId = _viewModel.barberData?.id;
      if (barberId != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            context.read<ReservationCubit>().getAvailableTimeSlots(
              barberId: barberId,
              date: _viewModel.selectedDate,
            );
          }
        });
      }
    } else {
      SnackbarHelper.showError(context, errorMessage);
    }
  }

  void _handleDateSelected(DateTime date) {
    _viewModel.selectDate(date);
    _fetchAvailableTimeSlots();
    setState(() {});
  }

  void _handleMonthChanged(DateTime month) {
    _viewModel.updateCurrentMonth(month);
    setState(() {});
  }

  void _handleTimeSelected(String? time) {
    final previousSelection = _viewModel.selectedTime;
    _viewModel.selectTime(time);
    setState(() {});

    if (previousSelection != null && time == null) {
      SnackbarHelper.showError(context, 'time_slots.slot_mismatch'.tr());
    }
  }

  void _handleSaveAsDefault() {
    if (_viewModel.isDefault) {
      _viewModel.removeDefault();
      SnackbarHelper.showSuccess(context, 'default_booking.removed'.tr());
    } else {
      _viewModel.saveAsDefault();
      SnackbarHelper.showSuccess(context, 'default_booking.saved_as_default'.tr());
    }
    setState(() {});
  }

  void _handleProceed() {
    final args = _viewModel.buildNavigationArguments();
    context.pushGoNamed(AppRoutes.bookingConfirmationName, extra: args);
  }
}

/// Bookmark button for saving default booking
class _BookmarkButton extends StatelessWidget {
  final bool isDefault;
  final VoidCallback onTap;

  const _BookmarkButton({
    required this.isDefault,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(
        isDefault ? Icons.bookmark : Icons.bookmark_border,
        color: isDefault ? ColorsManager.background : ColorsManager.lightBlue,
        size: 20,
      ),
      label: Text(
        isDefault ? 'default_booking.saved_as_default'.tr() : 'default_booking.save_as_default'.tr(),
        style: TextStyle(
          color: isDefault ? ColorsManager.background : ColorsManager.lightBlue,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
