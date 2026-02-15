import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/logic/reservation_cubit.dart';
import 'package:temy_barber/features/reservations/logic/reservation_state.dart';
import 'package:temy_barber/features/reservations/logic/reservation_view_model.dart';
import 'package:temy_barber/features/reservations/ui/widgets/services_section.dart';
import 'package:temy_barber/features/reservations/ui/widgets/calendar_section.dart';
import 'package:temy_barber/features/reservations/ui/widgets/time_slot_section.dart';
import 'package:temy_barber/features/reservations/ui/widgets/total_section.dart';
import 'package:temy_barber/features/reservations/ui/widgets/queue_mode_section.dart';
import 'package:temy_barber/features/reservations/ui/widgets/common_widgets.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';
import 'package:easy_localization/easy_localization.dart';
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
              child: Column(
                children: [
                  Expanded(child: _buildResponsiveLayout()),
                  _buildBottomActions(isLoading),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleStateChanges(BuildContext context, ReservationState state) {
    state.maybeWhen(
      queueSettingsLoading: () => _viewModel.onQueueSettingsLoading(),
      queueSettingsSuccess: (settings) {
        _viewModel.onQueueSettingsSuccess(settings.data?.isQueueMode ?? false);
        setState(() {});
      },
      queueSettingsError: (_) {
        _viewModel.onQueueSettingsError();
        setState(() {});
      },
      reservationLoading: () => _showLoadingDialog(),
      reservationSuccess: (response, _) {
        _dismissLoadingDialog();
        context.go(AppRoutes.Invoice, extra: response);
        _showSuccessSnackBar('booking.success_message'.tr());
      },
      reservationError: (error) {
        _dismissLoadingDialog();

        // Check if this is an overlap error and provide better UX
        final errorMessage = error.apiErrorModel.message.toString();
        if (errorMessage.contains('overlaps with an existing booking') ||
            errorMessage.contains('overlaps') ||
            errorMessage.contains('already booked')) {
          _showErrorSnackBar('time_slots.slot_no_longer_available'.tr());

          // Refresh time slots after overlap error so user can see updated availability
          if (_viewModel.barberData?.id != null &&
              _viewModel.selectedDate != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                context.read<ReservationCubit>().getAvailableTimeSlots(
                  barberId: _viewModel.barberData!.id,
                  date: _viewModel.selectedDate!,
                );
              }
            });
          }
        } else {
          _showErrorSnackBar(errorMessage);
        }
      },
      timeSlotsLoading: () {
        _viewModel.onTimeSlotsLoading();
        setState(() {});
      },
      timeSlotsSuccess: (response) {
        _viewModel.onTimeSlotsSuccess(response);
        setState(() {});
      },
      timeSlotsError: (error) {
        _viewModel.onTimeSlotsError();
        setState(() {});
        _showErrorSnackBar('${'booking.load_error'.tr()}: $error');
      },
      orElse: () {},
    );
  }

  void _showLoadingDialog() {
    if (_viewModel.isLoadingDialogShowing) return;
    _viewModel.setLoadingDialogShowing(true);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Center(child: ShimmerLoading.circular(size: 50)),
      ),
    );
  }

  void _dismissLoadingDialog() {
    if (_viewModel.isLoadingDialogShowing) {
      Navigator.of(context).pop();
      _viewModel.setLoadingDialogShowing(false);
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.green[700],
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: ColorsManager.red.withAlpha(200),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('barber.details'.tr(), style: TextStyles.font18DarkBlueBold),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        color: Colors.black,
        onPressed: () => context.pop(),
      ),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ServicesSection(services: _viewModel.selectedServices),
            const SizedBox(height: 24),
            _buildBookingContent(),
            const SizedBox(height: 24),
            TotalSection(totalPrice: _viewModel.totalPrice),
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
                  child: ServicesSection(services: _viewModel.selectedServices),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      _buildBookingContent(),
                      const SizedBox(height: 24),
                      TotalSection(totalPrice: _viewModel.totalPrice),
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

  void _handleDateSelected(DateTime date) {
    _viewModel.setSelectedDate(date);
    _fetchAvailableTimeSlots();
    setState(() {});
  }

  void _handleMonthChanged(DateTime month) {
    _viewModel.setCurrentMonth(month);
    setState(() {});
  }

  void _handleTimeSelected(String? time) {
    final previousSelection = _viewModel.selectedTime;
    _viewModel.setSelectedTime(time);
    setState(() {});

    if (previousSelection != null && time == null) {
      _showErrorSnackBar('time_slots.slot_mismatch'.tr());
    }
  }

  Widget _buildBottomActions(bool isLoading) {
    final canProceed = _viewModel.canBook && !isLoading;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: PrimaryButton(
                text: 'default_booking.save_as_default'.tr(),
                isOutlined: true,
                onPressed: canProceed ? _handleSaveAsDefault : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 5,
              child: PrimaryButton(
                text: 'common.next'.tr(),
                isLoading: isLoading,
                onPressed: canProceed ? _handleProceed : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSaveAsDefault() {
    _viewModel.saveAsDefault();
    _showSuccessSnackBar('default_booking.saved_as_default'.tr());
  }

  void _handleProceed() {
    final args = _viewModel.buildReservationArguments();
    context.goNamed(AppRoutes.bookingConfirmationName, extra: args);
  }
}
