import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/logic/booking_confirmation_controller.dart';
import 'package:temy_barber/features/reservations/logic/booking_confirmation_view_model.dart';
import 'package:temy_barber/features/reservations/logic/reservation_cubit.dart';
import 'package:temy_barber/features/reservations/logic/reservation_state.dart';
import 'package:temy_barber/features/reservations/ui/widgets/confirmation/confirmation_widgets.dart';
import 'package:temy_barber/core/widgets/app_bars.dart';

class BookingConfirmation extends StatefulWidget {
  final ReservationArguments arguments;

  const BookingConfirmation({super.key, required this.arguments});

  @override
  State<BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  late BookingConfirmationViewModel _viewModel;
  late BookingConfirmationController _controller;
  bool _isAddingAnother = false;

  @override
  void initState() {
    super.initState();
    _viewModel = BookingConfirmationViewModel(arguments: widget.arguments);
    _controller = BookingConfirmationController(
      viewModel: _viewModel,
      context: context,
    );
  }

  @override
  void dispose() {
    // Only clear reservations if we are NOT adding another one
    if (!_isAddingAnother) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _viewModel.clearReservations();
      });
    }
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReservationCubit, ReservationState>(
      listener: (context, state) => _controller.handleStateChanges(state),
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

  PreferredSizeWidget _buildAppBar() {
    return AppAppBar(
      title: 'booking_confirmation.title'.tr(),
      onBackPressed: () => context.pop(),
    );
  }

  Widget _buildContent() {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
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
        onRemoveReservation: _controller.removeReservation,
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
              AddAnotherReservationButton(onTap: () {
                _isAddingAnother = true;
                _controller.handleAddAnotherReservation();
              }),
            ConfirmationBottomButtons(
              onEdit: () => context.pop(),
              onConfirm: _controller.handleConfirm,
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
}
