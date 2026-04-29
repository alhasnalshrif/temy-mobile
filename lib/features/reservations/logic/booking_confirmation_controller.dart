import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';
import 'package:temy_barber/features/auth/ui/widgets/guest_info_dialog.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_response.dart';
import 'package:temy_barber/features/reservations/logic/booking_confirmation_view_model.dart';
import 'package:temy_barber/features/reservations/logic/reservation_cubit.dart';
import 'package:temy_barber/features/reservations/logic/reservation_state.dart';
import 'package:temy_barber/features/reservations/logic/reservation_success_feedback.dart';

/// Result type for guest flow operations
class GuestFlowResult {
  final GuestInfo? guestInfo;
  final String? otp;

  const GuestFlowResult({this.guestInfo, this.otp});
}

/// Controller for booking confirmation business logic.
/// Separates business logic from UI for better testability and maintainability.
class BookingConfirmationController {
  final BookingConfirmationViewModel viewModel;
  final BuildContext context;

  BookingConfirmationController({
    required this.viewModel,
    required this.context,
  });

  /// Handle state changes from ReservationCubit
  void handleStateChanges(ReservationState state) {
    state.maybeWhen(
      reservationLoading: () => _showLoadingDialog(),
      reservationSuccess: (response, _) => _onReservationSuccess(
        response,
        isGuestReservation: _isGuestReservation(response),
      ),
      reservationError: (error) => _onError(
        error.apiErrorModel.message.toString(),
      ),
      otpVerificationLoading: () => _showLoadingDialog(),
      otpVerificationSuccess: (response, _) => _onReservationSuccess(
        response,
        isGuestReservation: true,
      ),
      otpVerificationError: (error) => _onError(
        error.apiErrorModel.message ?? 'booking_confirmation.otp_error'.tr(),
      ),
      orElse: () {},
    );
  }

  /// Handle confirm button press
  Future<void> handleConfirm() async {
    if (viewModel.isQueueMode) {
      await _confirmBooking();
      return;
    }

    if (viewModel.existingReservations.isNotEmpty) {
      await _confirmMultipleReservations();
    } else {
      await _confirmBooking();
    }
  }

  /// Handle remove reservation
  void removeReservation(int index) {
    viewModel.removeReservation(index);
    _showSnackBar(
      'booking_confirmation.reservation_removed'.tr(),
      Colors.green,
    );
  }

  /// Handle add another reservation
  Future<void> handleAddAnotherReservation() async {
    final validation = viewModel.validateAddToMultiple();
    if (!validation.isValid) {
      _showSnackBar(validation.errorMessage!.tr(), ColorsManager.red);
      return;
    }

    viewModel.addToMultipleReservations();
    _showSnackBar('booking_confirmation.booking_added'.tr(), Colors.green);
    context.goNamed(AppRoutes.categoriesName);
  }

  /// Validate and confirm multiple reservations
  Future<void> _confirmMultipleReservations() async {
    final validation = viewModel.validateBooking();
    if (!validation.isValid) {
      _showSnackBar(validation.errorMessage!.tr(), ColorsManager.red);
      return;
    }

    final userId = await viewModel.getUserId();
    final reservationsData = viewModel.getReservationsData();

    context.read<ReservationCubit>().postMultipleReservations(
      userId: userId,
      reservationsData: reservationsData,
      arguments: viewModel.arguments,
    );
  }

  /// Validate and confirm single booking
  Future<void> _confirmBooking() async {
    final validation = viewModel.validateBooking();
    if (!validation.isValid) {
      _showSnackBar(validation.errorMessage!.tr(), ColorsManager.red);
      return;
    }

    final userId = await viewModel.getUserId();
    GuestInfo? guestInfo;
    String? otp;

    // Handle guest user flow
    if (userId.isEmpty) {
      final guestResult = await _handleGuestFlow();
      if (guestResult == null) return;

      guestInfo = guestResult.guestInfo;
      otp = guestResult.otp;
    }

    final updatedArguments = viewModel.buildUpdatedArguments();

    if (userId.isEmpty && guestInfo != null) {
      await _processGuestBooking(guestInfo, otp, updatedArguments);
    } else {
      await _processUserBooking(userId, guestInfo, updatedArguments);
    }
  }

  /// Handle guest user flow
  Future<GuestFlowResult?> _handleGuestFlow() async {
    if (!context.mounted) return null;

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

    if (!viewModel.isQueueMode && otp == null) {
      _showSnackBar(
        'booking_confirmation.otp_required'.tr(),
        ColorsManager.red,
      );
      return null;
    }

    return GuestFlowResult(guestInfo: guestInfo, otp: otp);
  }

  /// Show guest info dialog
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

  /// Process guest booking
  Future<void> _processGuestBooking(
    GuestInfo guestInfo,
    String? otp,
    ReservationArguments arguments,
  ) async {
    if (viewModel.isQueueMode) {
      // Queue guest booking - direct join without OTP
      context.read<ReservationCubit>().joinQueue(
        barberId: viewModel.barberId,
        serviceIds: viewModel.serviceIds,
        guest: guestInfo,
        arguments: arguments,
      );
    } else if (otp != null) {
      // Regular reservation guest booking with OTP verification
      final date = viewModel.formatDateForApi(
        viewModel.arguments.selectedDate!,
      );

      context.read<ReservationCubit>().verifyAndCreateGuestReservation(
        phone: guestInfo.phone,
        otp: otp,
        userName: guestInfo.name,
        barberId: viewModel.barberId,
        serviceIds: viewModel.serviceIds,
        date: date,
        startTime: viewModel.arguments.selectedTime!,
        arguments: arguments,
      );
    }
  }

  /// Process authenticated user booking
  Future<void> _processUserBooking(
    String userId,
    GuestInfo? guestInfo,
    ReservationArguments arguments,
  ) async {
    if (viewModel.isQueueMode) {
      context.read<ReservationCubit>().joinQueue(
        barberId: viewModel.barberId,
        serviceIds: viewModel.serviceIds,
        userId: userId.isNotEmpty ? userId : null,
        guest: guestInfo,
        arguments: arguments,
      );
    } else {
      final date = viewModel.formatDateForApi(
        viewModel.arguments.selectedDate!,
      );

      context.read<ReservationCubit>().postReservation(
        userId: userId.isNotEmpty ? userId : null,
        serviceIds: viewModel.serviceIds,
        barberId: viewModel.barberId,
        date: date,
        startTime: viewModel.arguments.selectedTime!,
        guest: guestInfo,
        arguments: arguments,
      );
    }
  }

  /// Check if response is for guest reservation
  bool _isGuestReservation(ReservationResponseModel response) {
    return response.data.user == null && response.data.userName != null;
  }

  /// Handle successful reservation
  void _onReservationSuccess(
    ReservationResponseModel response, {
    required bool isGuestReservation,
  }) {
    Navigator.of(context, rootNavigator: true).pop();
    viewModel.clearReservations();

    if (isGuestReservation) {
      ReservationSuccessFeedback.play();
      _showGuestRegistrationSuccessDialog();
      return;
    }

    context.goNamed(AppRoutes.invoiceName, extra: response);
  }

  /// Show guest registration success dialog
  void _showGuestRegistrationSuccessDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          icon: const Icon(Icons.check_circle, color: Colors.green, size: 40),
          title: Text(
            'auth.registration_success_title'.tr(),
            textAlign: TextAlign.center,
            style: TextStyles.font16DarkBold,
          ),
          content: Text(
            'auth.registration_success_message'.tr(),
            textAlign: TextAlign.center,
            style: TextStyles.font14GrayRegular,
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  context.goNamed(AppRoutes.loginName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.mainBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('verification.continue_to_login'.tr()),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Handle reservation error
  void _onError(String message) {
    Navigator.of(context, rootNavigator: true).pop();

    // Check if this is an overlap error and provide better UX
    if (message.contains('overlaps with an existing booking') ||
        message.contains('overlaps') ||
        message.contains('already booked')) {
      _showSnackBar(
        'time_slots.slot_no_longer_available'.tr(),
        ColorsManager.red,
      );

      // Refresh time slots after overlap error
      if (viewModel.arguments.selectedDate != null &&
          viewModel.arguments.barberData?.id != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            context.read<ReservationCubit>().getAvailableTimeSlots(
              barberId: viewModel.arguments.barberData!.id,
              date: viewModel.arguments.selectedDate!,
            );
          }
        });
      }
    } else {
      _showSnackBar(message, ColorsManager.red);
    }
  }

  /// Show loading dialog
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

  /// Show snackbar message
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }
}
