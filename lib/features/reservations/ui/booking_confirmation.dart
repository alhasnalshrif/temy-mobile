import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/logic/booking_confirmation_view_model.dart';
import 'package:temy_barber/features/reservations/logic/reservation_cubit.dart';
import 'package:temy_barber/features/reservations/logic/reservation_state.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';
import 'package:temy_barber/features/reservations/ui/widgets/confirmation_widgets.dart';
import 'package:temy_barber/features/auth/ui/widgets/guest_info_dialog.dart';

class BookingConfirmation extends StatefulWidget {
  final ReservationArguments arguments;

  const BookingConfirmation({super.key, required this.arguments});

  @override
  State<BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  late BookingConfirmationViewModel _viewModel;

  bool _isAddingAnother = false;

  @override
  void initState() {
    super.initState();
    _viewModel = BookingConfirmationViewModel(arguments: widget.arguments);
  }

  @override
  void dispose() {
    // Only clear reservations if we are NOT adding another one
    // and if the view model is available (not null)
    if (!_isAddingAnother) {
      _viewModel.clearReservations();
    }
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReservationCubit, ReservationState>(
      listener: _handleStateChanges,
      child: Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: _buildContent()),
              _buildBottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleStateChanges(BuildContext context, ReservationState state) {
    state.maybeWhen(
      reservationLoading: () => _showLoadingDialog(),
      reservationSuccess: (response, _) => _onReservationSuccess(response),
      reservationError: (error) =>
          _onError(error.apiErrorModel.message.toString()),
      otpVerificationLoading: () => _showLoadingDialog(),
      otpVerificationSuccess: (response, _) => _onReservationSuccess(response),
      otpVerificationError: (error) => _onError(
        error.apiErrorModel.message ?? 'booking_confirmation.otp_error'.tr(),
      ),
      orElse: () {},
    );
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Center(child: ShimmerLoading.circular(size: 50)),
      ),
    );
  }

  void _onReservationSuccess(dynamic response) {
    Navigator.of(context, rootNavigator: true).pop();
    _viewModel.clearReservations();
    context.go(AppRoutes.Invoice, extra: response);
  }

  void _onError(String message) {
    Navigator.of(context, rootNavigator: true).pop();
    _showSnackBar(message, ColorsManager.red);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'booking_confirmation.title'.tr(),
        style: TextStyles.font16DarkBold,
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.transparent,
    );
  }

  Widget _buildContent() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ConfirmationHeader(),
                const SizedBox(height: 16),
                _buildOrderSummary(),
                const SizedBox(height: 16),
                BarberInfoSection(barberData: _viewModel.arguments.barberData),
                const SizedBox(height: 16),
                AppointmentInfoSection(
                  selectedDate: _viewModel.arguments.selectedDate,
                  selectedTime: _viewModel.arguments.selectedTime,
                ),
                const SizedBox(height: 16),
                const PaymentInfoSection(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    if (_viewModel.hasMultipleReservations) {
      return MultipleOrderSummary(
        reservations: _viewModel.allReservations,
        grandTotal: _viewModel.grandTotal,
        onRemoveReservation: _handleRemoveReservation,
      );
    }
    return SingleOrderSummary(arguments: _viewModel.arguments);
  }

  Widget _buildBottomSection() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!_viewModel.isQueueMode)
              AddAnotherReservationButton(onTap: _handleAddAnotherReservation),
            ConfirmationBottomButtons(
              onEdit: () => context.pop(),
              onConfirm: _handleConfirm,
              confirmText: _getConfirmButtonText(),
            ),
          ],
        ),
      ),
    );
  }

  String _getConfirmButtonText() {
    if (_viewModel.isQueueMode || _viewModel.existingReservations.isEmpty) {
      return 'booking_confirmation.confirm_booking'.tr();
    }
    return 'booking_confirmation.confirm_all'.tr(
      args: [_viewModel.totalReservationsCount.toString()],
    );
  }

  void _handleRemoveReservation(int index) {
    setState(() {
      _viewModel.removeReservation(index);
    });
    _showSnackBar(
      'booking_confirmation.reservation_removed'.tr(),
      Colors.green,
    );
  }

  void _handleAddAnotherReservation() {
    final validation = _viewModel.validateAddToMultiple();
    if (!validation.isValid) {
      _showSnackBar(validation.errorMessage!.tr(), ColorsManager.red);
      return;
    }

    _viewModel.addToMultipleReservations();
    _isAddingAnother = true;
    _showSnackBar('booking_confirmation.booking_added'.tr(), Colors.green);
    context.goNamed(AppRoutes.categoriesName);
  }

  Future<void> _handleConfirm() async {
    if (_viewModel.isQueueMode) {
      await _confirmBooking();
      return;
    }

    if (_viewModel.existingReservations.isNotEmpty) {
      await _confirmMultipleReservations();
    } else {
      await _confirmBooking();
    }
  }

  Future<void> _confirmMultipleReservations() async {
    final validation = _viewModel.validateBooking();
    if (!validation.isValid) {
      _showSnackBar(validation.errorMessage!.tr(), ColorsManager.red);
      return;
    }

    final userId = await _viewModel.getUserId();
    final reservationsData = _viewModel.getReservationsData();

    context.read<ReservationCubit>().postMultipleReservations(
      userId: userId,
      reservationsData: reservationsData,
      arguments: _viewModel.arguments,
    );
  }

  Future<void> _confirmBooking() async {
    final validation = _viewModel.validateBooking();
    if (!validation.isValid) {
      _showSnackBar(validation.errorMessage!.tr(), ColorsManager.red);
      return;
    }

    final userId = await _viewModel.getUserId();
    GuestInfo? guestInfo;
    String? otp;

    // Handle guest user flow
    if (userId.isEmpty) {
      final guestResult = await _handleGuestFlow();
      if (guestResult == null) return;

      guestInfo = guestResult.guestInfo;
      otp = guestResult.otp;
    }

    final updatedArguments = _viewModel.buildUpdatedArguments();

    if (userId.isEmpty && guestInfo != null) {
      await _processGuestBooking(guestInfo, otp, updatedArguments);
    } else {
      await _processUserBooking(userId, guestInfo, updatedArguments);
    }
  }

  Future<_GuestFlowResult?> _handleGuestFlow() async {
    if (!mounted) return null;

    final result = await _showGuestInfoDialog();
    if (result == null) return null;

    GuestInfo? guestInfo;
    String? otp;

    if (result is Map) {
      guestInfo = result['guestInfo'] as GuestInfo?;
      otp = result['otp'] as String?;
    } else if (result is GuestInfo) {
      guestInfo = result;
    }

    if (guestInfo == null) {
      _showSnackBar(
        'booking_confirmation.guest_info_error'.tr(),
        ColorsManager.red,
      );
      return null;
    }

    if (!_viewModel.isQueueMode && otp == null) {
      _showSnackBar(
        'booking_confirmation.otp_required'.tr(),
        ColorsManager.red,
      );
      return null;
    }

    return _GuestFlowResult(guestInfo: guestInfo, otp: otp);
  }

  Future<dynamic> _showGuestInfoDialog() async {
    return await showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => BlocProvider.value(
        value: context.read<ReservationCubit>(),
        child: const GuestInfoDialog(),
      ),
    );
  }

  Future<void> _processGuestBooking(
    GuestInfo guestInfo,
    String? otp,
    ReservationArguments arguments,
  ) async {
    if (_viewModel.isQueueMode) {
      // Queue guest booking - direct join without OTP
      context.read<ReservationCubit>().joinQueue(
        barberId: _viewModel.barberId,
        serviceIds: _viewModel.serviceIds,
        guest: guestInfo,
        arguments: arguments,
      );
    } else if (otp != null) {
      // Regular reservation guest booking with OTP verification
      final date = _viewModel.formatDateForApi(
        _viewModel.arguments.selectedDate!,
      );

      context.read<ReservationCubit>().verifyAndCreateGuestReservation(
        phone: guestInfo.phone,
        otp: otp,
        userName: guestInfo.name,
        barberId: _viewModel.barberId,
        serviceIds: _viewModel.serviceIds,
        date: date,
        startTime: _viewModel.arguments.selectedTime!,
        arguments: arguments,
      );
    }
  }

  Future<void> _processUserBooking(
    String userId,
    GuestInfo? guestInfo,
    ReservationArguments arguments,
  ) async {
    if (_viewModel.isQueueMode) {
      context.read<ReservationCubit>().joinQueue(
        barberId: _viewModel.barberId,
        serviceIds: _viewModel.serviceIds,
        userId: userId.isNotEmpty ? userId : null,
        guest: guestInfo,
        arguments: arguments,
      );
    } else {
      final date = _viewModel.formatDateForApi(
        _viewModel.arguments.selectedDate!,
      );

      context.read<ReservationCubit>().postReservation(
        userId: userId.isNotEmpty ? userId : null,
        serviceIds: _viewModel.serviceIds,
        barberId: _viewModel.barberId,
        date: date,
        startTime: _viewModel.arguments.selectedTime!,
        guest: guestInfo,
        arguments: arguments,
      );
    }
  }
}

/// Helper class for guest flow result
class _GuestFlowResult {
  final GuestInfo guestInfo;
  final String? otp;

  _GuestFlowResult({required this.guestInfo, this.otp});
}
