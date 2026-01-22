import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/routing/routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/logic/simple_multi_reservation_manager.dart';
import 'package:temy_barber/features/reservations/logic/reservation_cubit.dart';
import 'package:temy_barber/features/reservations/logic/reservation_state.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';
import 'package:temy_barber/features/auth/ui/widgets/guest_info_dialog.dart';

class BookingConfirmation extends StatefulWidget {
  final ReservationArguments arguments;

  const BookingConfirmation({super.key, required this.arguments});

  @override
  State<BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  final MultiReservationManager _multiReservationManager =
      MultiReservationManager();
  ReservationArguments get arguments => widget.arguments;
  bool get isQueueMode => arguments.isQueueMode ?? false;

  @override
  void dispose() {
    _multiReservationManager.clearReservations();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReservationCubit, ReservationState>(
      listener: (context, state) {
        state.maybeWhen(
          reservationLoading: () {
            _showLoadingDialog(context);
          },
          reservationSuccess: (response, reservationArgs) {
            Navigator.of(context, rootNavigator: true).pop();
            _multiReservationManager.clearReservations();
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.invoiceScreen,
              arguments: response,
              (route) => false,
            );
          },
          reservationError: (error) {
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.apiErrorModel.message.toString()),
                backgroundColor: Colors.red,
              ),
            );
          },
          otpVerificationLoading: () {
            _showLoadingDialog(context);
          },
          otpVerificationSuccess: (response, reservationArgs) {
            Navigator.of(context, rootNavigator: true).pop();
            _multiReservationManager.clearReservations();
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.invoiceScreen,
              arguments: response,
              (route) => false,
            );
          },
          otpVerificationError: (error) {
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  error.apiErrorModel.message ?? 'فشل التحقق من رمز OTP',
                ),
                backgroundColor: Colors.red,
              ),
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('تأكيد الحجز', style: TextStyles.font16DarkBold),
          centerTitle: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 16),
                        _buildOrderSummary(),
                        const SizedBox(height: 16),
                        _buildBarberInfo(),
                        const SizedBox(height: 16),
                        _buildAppointmentInfo(),
                        const SizedBox(height: 16),
                        _buildPaymentInfo(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
              _buildBottomButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: Center(child: ShimmerLoading.circular(size: 50)),
      ),
    );
  }

  Future<dynamic> _showGuestInfoDialog(BuildContext context) async {
    return await showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => BlocProvider.value(
        value: context.read<ReservationCubit>(),
        child: const GuestInfoDialog(),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: ColorsManager.lightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            size: 24,
            color: ColorsManager.mainBlue,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "الرجاء مراجعة تفاصيل الحجز قبل التأكيد",
              style: TextStyles.font14DarkBlueMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    final List<ReservationArguments> existingReservations =
        _multiReservationManager.reservations;

    if (!isQueueMode && existingReservations.isNotEmpty) {
      final List<ReservationArguments> allReservations = [
        ...existingReservations,
        arguments,
      ];

      final double grandTotal = allReservations.fold(
        0.0,
        (total, res) => total + res.totalPrice,
      );

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ملخص الحجوزات (${allReservations.length})",
                style: TextStyles.font16DarkBold,
              ),
              Text(
                "${grandTotal.toStringAsFixed(2)} جنية",
                style: TextStyles.font14DarkBlueMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.mainBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: allReservations.length,
            itemBuilder: (context, index) {
              final isCurrentReservation = index == allReservations.length - 1;
              final reservation = allReservations[index];

              String dateTime = "";
              if (reservation.selectedDate != null &&
                  reservation.selectedTime != null) {
                dateTime =
                    "${DateFormat('d MMM', 'ar').format(reservation.selectedDate!)}, ${reservation.selectedTime}";
              }

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade100, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ColorsManager.lightBlue,
                              width: 1.5,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey.shade100,
                            backgroundImage:
                                reservation.barberData?.avatar != null &&
                                    reservation.barberData!.avatar.isNotEmpty &&
                                    reservation.barberData!.avatar != 'null'
                                ? NetworkImage(reservation.barberData!.avatar)
                                : null,
                            child:
                                reservation.barberData?.avatar == null ||
                                    reservation.barberData!.avatar.isEmpty ||
                                    reservation.barberData!.avatar == 'null'
                                ? const Icon(
                                    Icons.person,
                                    size: 20,
                                    color: Colors.grey,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reservation.barberData?.name ?? 'حلاق غير محدد',
                                style: TextStyles.font18DarkBlueBold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (dateTime.isNotEmpty)
                                Text(
                                  dateTime,
                                  style: TextStyles.font12BlueRegular.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),

                        if (!isCurrentReservation)
                          IconButton(
                            onPressed: () => _removeReservation(index),
                            icon: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.red,
                              ),
                            ),
                            tooltip: "حذف الحجز",
                            style: IconButton.styleFrom(
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    if (reservation.selectedServices.isNotEmpty) ...[
                      ...reservation.selectedServices.map(
                        (service) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  service.name,
                                  style: TextStyles.font14DarkBlueMedium
                                      .copyWith(color: Colors.black87),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                "${service.price.toStringAsFixed(0)} جنية",
                                style: TextStyles.font14DarkBlueMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: ColorsManager.mainBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      Text(
                        "لا توجد خدمات محددة",
                        style: TextStyles.font14GrayRegular.copyWith(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],

                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        children: [
                          Divider(color: ColorsManager.lightBlue, height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "الإجمالي",
                                style: TextStyles.font14DarkBlueMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                "${reservation.totalPrice.toStringAsFixed(2)} جنية",
                                style: TextStyles.font18DarkBlueBold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: ColorsManager.thirdfMain.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("المجموع الكلي", style: TextStyles.font16DarkBold),
                Text(
                  "${grandTotal.toStringAsFixed(2)} جنية",
                  style: TextStyles.font16DarkBold.copyWith(
                    color: ColorsManager.mainBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ملخص الخدمات", style: TextStyles.font16DarkBold),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: ColorsManager.lightBlue),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: arguments.selectedServices.length,
                  separatorBuilder: (_, __) => const Divider(height: 12),
                  itemBuilder: (context, index) {
                    final service = arguments.selectedServices[index];
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            service.name,
                            style: TextStyles.font14DarkBlueMedium,
                          ),
                        ),
                        Text(
                          "${service.duration} دقيقة",
                          style: TextStyles.font14GrayRegular.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "${service.price.toStringAsFixed(2)} جنية",
                          style: TextStyles.font14DarkBlueMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const Divider(height: 24, color: ColorsManager.lightBlue),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("المجموع", style: TextStyles.font16DarkBold),
                    Text(
                      "${arguments.totalPrice.toStringAsFixed(2)} جنية",
                      style: TextStyles.font16DarkBold.copyWith(
                        color: ColorsManager.mainBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget _buildBarberInfo() {
    if (arguments.barberData == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.lightBlue),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade100,
            backgroundImage:
                arguments.barberData?.avatar != null &&
                    arguments.barberData!.avatar.isNotEmpty &&
                    arguments.barberData!.avatar != 'null'
                ? NetworkImage(arguments.barberData!.avatar)
                : null,
            child:
                arguments.barberData?.avatar == null ||
                    arguments.barberData!.avatar.isEmpty ||
                    arguments.barberData!.avatar == 'null'
                ? const Icon(Icons.person, size: 20, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "الحلاق: ${arguments.barberData?.name ?? "غير محدد"}",
                  style: TextStyles.font14DarkBlueMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (arguments.barberData?.rating != null)
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        arguments.barberData!.rating.average.toString(),
                        style: TextStyles.font14GrayRegular.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentInfo() {
    if (arguments.selectedDate == null || arguments.selectedTime == null) {
      return const SizedBox.shrink();
    }

    String formattedDate = DateFormat(
      'EEEE, d MMMM',
      'ar',
    ).format(arguments.selectedDate!);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.lightBlue),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorsManager.lightBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.calendar_today,
              color: ColorsManager.mainBlue,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "موعد الحجز:",
                  style: TextStyles.font14DarkBlueMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$formattedDate - ${arguments.selectedTime}",
                  style: TextStyles.font14GrayRegular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.lightBlue),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorsManager.lightBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.payments_outlined,
              color: ColorsManager.mainBlue,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Text("الدفع عند الوصول", style: TextStyles.font14DarkBlueMedium),
          const Spacer(),
          const Icon(
            Icons.check_circle,
            color: ColorsManager.mainBlue,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isQueueMode)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: ColorsManager.lightBlue.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _addToMultipleReservations(context),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add_circle_outline,
                          color: ColorsManager.mainBlue,
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "إضافة حجز آخر",
                            style: TextStyles.font14DarkBlueMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.mainBlue,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: ColorsManager.mainBlue.withOpacity(0.7),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          Row(
            children: [
              Expanded(
                flex: 3,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios, size: 16),
                  label: const Text("تعديل"),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    foregroundColor: ColorsManager.mainBlue,
                    side: const BorderSide(color: ColorsManager.mainBlue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Confirm button
              Expanded(
                flex: 5,
                child: ElevatedButton.icon(
                  onPressed: () => _confirmMultipleReservations(context),
                  icon: const Icon(Icons.check_circle_outline),
                  label: Text(
                    isQueueMode
                        ? "تأكيد الحجز"
                        : (_multiReservationManager.reservations.isEmpty
                              ? "تأكيد الحجز"
                              : "تأكيد الحجوزات (${_multiReservationManager.reservations.length + 1})"),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.mainBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addToMultipleReservations(BuildContext context) async {
    if (arguments.selectedDate == null || arguments.selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("الرجاء تحديد التاريخ والوقت أولاً"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    _multiReservationManager.addReservation(arguments);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("تم إضافة الحجز، يمكنك الآن اختيار خدمات أخرى"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushNamed(context, Routes.categoryScreen);
  }

  void _confirmMultipleReservations(BuildContext context) async {
    if (isQueueMode) {
      _confirmBooking(context);
      return;
    }

    final userId = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userId,
    );

    if (_multiReservationManager.reservations.isNotEmpty) {
      if (arguments.selectedDate == null || arguments.selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("الرجاء تحديد التاريخ والوقت للحجز الحالي"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final reservationsData = _multiReservationManager.getReservationsData(
        currentReservation: arguments,
      );

      context.read<ReservationCubit>().postMultipleReservations(
        userId: userId,
        reservationsData: reservationsData,
        arguments: arguments, // Pass the current arguments for UI purposes
      );
    } else {
      _confirmBooking(context);
    }
  }

  void _confirmBooking(BuildContext context) async {
    final isQueueMode = arguments.isQueueMode ?? false;

    if (!isQueueMode &&
        (arguments.selectedDate == null || arguments.selectedTime == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("الرجاء تحديد التاريخ والوقت"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final userId = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userId,
    );

    String? otp;
    GuestInfo? guestInfo;
    if (userId.isEmpty) {
      if (!mounted) return;

      final dynamic result = await _showGuestInfoDialog(context);

      if (result == null) {
        return;
      }

      if (result is Map) {
        guestInfo = result['guestInfo'] as GuestInfo?;
        otp = result['otp'] as String?;
      } else if (result is GuestInfo) {
        guestInfo = result;
      }

      if (guestInfo == null || otp == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("فشل الحصول على معلومات الضيف أو رمز التحقق"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    final serviceIds = arguments.selectedServices.map((s) => s.id).toList();
    final barberId = arguments.barberData?.id ?? '';
    final updatedArguments = ReservationArguments(
      selectedServices: arguments.selectedServices,
      barberData: arguments.barberData,
      totalPrice: arguments.totalPrice,
      selectedDate: arguments.selectedDate,
      selectedTime: arguments.selectedTime,
      isQueueMode: isQueueMode,
    );

    if (userId.isEmpty && guestInfo != null && otp != null) {
      print('✅ BookingConfirmation: Guest booking with OTP');
      print('   Phone: ${guestInfo.phone}');
      print('   Name: ${guestInfo.name}');
      print('   OTP: $otp');

      final date =
          '${arguments.selectedDate!.year}-${arguments.selectedDate!.month.toString().padLeft(2, '0')}-${arguments.selectedDate!.day.toString().padLeft(2, '0')}';

      context.read<ReservationCubit>().verifyAndCreateGuestReservation(
        phone: guestInfo.phone,
        otp: otp,
        userName: guestInfo.name,
        barberId: barberId,
        serviceIds: serviceIds,
        date: date,
        startTime: arguments.selectedTime!,
        arguments: updatedArguments,
      );
    } else {
      if (isQueueMode) {
        context.read<ReservationCubit>().joinQueue(
          barberId: barberId,
          serviceIds: serviceIds,
          userId: userId.isNotEmpty ? userId : null,
          guest: guestInfo, // Pass guest info if user is not logged in
          arguments: updatedArguments,
        );
      } else {
        final date =
            '${arguments.selectedDate!.year}-${arguments.selectedDate!.month.toString().padLeft(2, '0')}-${arguments.selectedDate!.day.toString().padLeft(2, '0')}';

        context.read<ReservationCubit>().postReservation(
          userId: userId.isNotEmpty ? userId : null,
          serviceIds: serviceIds,
          barberId: barberId,
          date: date,
          startTime: arguments.selectedTime!,
          guest: guestInfo,
          arguments: updatedArguments,
        );
      }
    }
  }

  void _removeReservation(int index) {
    setState(() {
      _multiReservationManager.removeReservationAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("تم حذف الحجز بنجاح"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
