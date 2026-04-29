import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/widgets/error_retry_view.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';

class ErrorBookingView extends StatelessWidget {
  const ErrorBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorRetryView(
      message: 'verification.error_title'.tr(),
      subtitle: 'verification.error_loading_info'.tr(),
      onRetry: () => context.read<BookingCubit>().getBooking(),
    );
  }
}
