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

class BookingConfirmation extends StatefulWidget {
  final ReservationArguments arguments;

  const BookingConfirmation({
    super.key,
    required this.arguments,
  });

  @override
  State<BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  // Create instance of MultiReservationManager
  final MultiReservationManager _multiReservationManager =
      MultiReservationManager();
  // Getter to access widget.arguments more concisely
  ReservationArguments get arguments => widget.arguments;

  @override
  void dispose() {
    // Clear all multi-reservation data when navigating away from this screen
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
          reservationSuccess: (response, arguments) {
            // Dismiss loading dialog if it's showing
            Navigator.of(context, rootNavigator: true).pop();
    
            // Clear all reservations when successful
            _multiReservationManager.clearReservations();
    
            // Navigate to invoice screen
            Navigator.pushReplacementNamed(
              context,
              Routes.invoiceScreen,
              arguments: response,
            );
          },
          reservationError: (error) {
            // Dismiss loading dialog if it's showing
            Navigator.of(context, rootNavigator: true).pop();
    
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
                backgroundColor: Colors.red,
              ),
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'تأكيد الحجز',
            style: TextStyles.font16DarkBold,
          ),
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
                        horizontal: 16.0, vertical: 8.0),
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
                        // Add padding at the bottom for better scrolling
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

  // Show loading dialog
  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: Center(
          child: ShimmerLoading.circular(
            size: 50,
          ),
        ),
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

    if (existingReservations.isNotEmpty) {
      // Multi-booking mode: display all existing reservations + the current one
      final List<ReservationArguments> allReservations = [
        ...existingReservations,
        arguments
      ];

      // Calculate grand total
      final double grandTotal =
          allReservations.fold(0.0, (total, res) => total + res.totalPrice);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with total
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

          // Reservations list - more compact
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: allReservations.length,
            itemBuilder: (context, index) {
              final isCurrentReservation = index == allReservations.length - 1;
              final reservation = allReservations[index];

              // Format date/time
              String dateTime = "";
              if (reservation.selectedDate != null &&
                  reservation.selectedTime != null) {
                dateTime =
                    "${DateFormat('d MMM', 'ar').format(reservation.selectedDate!)}, ${reservation.selectedTime}";
              }

              return Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
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
                    // Header row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Barber avatar with subtle border
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.grey.shade200, width: 1.5),
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey.shade100,
                            backgroundImage: reservation.barberData?.avatar !=
                                    null
                                ? NetworkImage(reservation.barberData!.avatar)
                                : null,
                            child: reservation.barberData?.avatar == null
                                ? const Icon(Icons.person,
                                    size: 20, color: Colors.grey)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Barber name and date
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

                        // Delete button with modern styling
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

                    // Services section
                    if (reservation.selectedServices.isNotEmpty) ...[
                      ...reservation.selectedServices.map((service) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    service.name,
                                    style: TextStyles.font14DarkBlueMedium
                                        .copyWith(
                                      color: Colors.black87,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  "${service.price.toStringAsFixed(0)} جنية",
                                  style:
                                      TextStyles.font14DarkBlueMedium.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: ColorsManager.mainBlue,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ] else ...[
                      Text(
                        "لا توجد خدمات محددة",
                        style: TextStyles.font14GrayRegular.copyWith(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],

                    // Total price with divider
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        children: [
                          Divider(color: Colors.grey.shade200, height: 24),
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
                                  style: TextStyles.font18DarkBlueBold),
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

          // Grand total display - simplified
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
                Text(
                  "المجموع الكلي",
                  style: TextStyles.font16DarkBold,
                ),
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
      // Single reservation mode - simplified
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ملخص الخدمات",
            style: TextStyles.font16DarkBold,
          ),
          const SizedBox(height: 12),

          // Services in a more compact container
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Services list
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
                          style: TextStyles.font14GrayRegular
                              .copyWith(fontSize: 12),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "${service.price.toStringAsFixed(2)} جنية",
                          style: TextStyles.font14DarkBlueMedium
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  },
                ),

                const Divider(height: 24),

                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "المجموع",
                      style: TextStyles.font16DarkBold,
                    ),
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
      return const SizedBox
          .shrink(); // Don't show this section if barber data is missing
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          // Barber avatar
          CircleAvatar(
            radius: 20,
            backgroundImage: arguments.barberData?.avatar != null
                ? NetworkImage(arguments.barberData!.avatar)
                : null,
            child: arguments.barberData?.avatar == null
                ? const Icon(Icons.person, size: 20)
                : null,
          ),
          const SizedBox(width: 12),

          // Barber details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "الحلاق: ${arguments.barberData?.name ?? "غير محدد"}",
                  style: TextStyles.font14DarkBlueMedium
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                if (arguments.barberData?.rating != null)
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        arguments.barberData!.rating.toString(),
                        style:
                            TextStyles.font14GrayRegular.copyWith(fontSize: 12),
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
      return const SizedBox.shrink(); // Don't display if no date/time selected
    }

    String formattedDate =
        DateFormat('EEEE, d MMMM', 'ar').format(arguments.selectedDate!);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
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
        border: Border.all(color: Colors.grey.shade200),
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
          Text(
            "الدفع عند الوصول",
            style: TextStyles.font14DarkBlueMedium,
          ),
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Multi-booking button
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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

          // Clear all reservations button - only show when there are multiple reservations
          // if (_multiReservationManager.reservations.isNotEmpty)
          //   Container(
          //     margin: const EdgeInsets.only(bottom: 16),
          //     decoration: BoxDecoration(
          //       color: Colors.red.withOpacity(0.1),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     child: Material(
          //       color: Colors.transparent,
          //       child: InkWell(
          //         onTap: _clearAllReservations,
          //         borderRadius: BorderRadius.circular(12),
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(
          //               vertical: 12, horizontal: 16),
          //           child: Row(
          //             children: [
          //               const Icon(
          //                 Icons.delete_outline,
          //                 color: Colors.red,
          //                 size: 22,
          //               ),
          //               const SizedBox(width: 12),
          //               Expanded(
          //                 child: Text(
          //                   "حذف جميع الحجوزات",
          //                   style: TextStyles.font14DarkBlueMedium.copyWith(
          //                     fontWeight: FontWeight.bold,
          //                     color: Colors.red,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),

          // Main action buttons
          Row(
            children: [
              // Back/Edit button
              Expanded(
                flex: 3,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                  ),
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
                    _multiReservationManager.reservations.isEmpty
                        ? "تأكيد الحجز"
                        : "تأكيد الحجوزات (${_multiReservationManager.reservations.length + 1})",
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

  // Method to add the current reservation to multiple reservations
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

    // Show confirmation snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("تم إضافة الحجز، يمكنك الآن اختيار خدمات أخرى"),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate to category screen to choose another service, replacing current screen
    Navigator.pushReplacementNamed(
      context,
      Routes.categoryScreen,
    );
  }

  // Method to confirm multiple reservations or a single reservation
  void _confirmMultipleReservations(BuildContext context) async {
    // Get user ID from SharedPreferences
    final userId =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.userId);

    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("عذراً، يجب تسجيل الدخول أولاً"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } // Check if we have multiple reservations
    if (_multiReservationManager.reservations.isNotEmpty) {
      // We have multiple reservations, add the current one and submit all

      // Check current reservation has date and time
      if (arguments.selectedDate == null || arguments.selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("الرجاء تحديد التاريخ والوقت للحجز الحالي"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      } // Prepare reservations data for API call
      final reservationsData = _multiReservationManager.getReservationsData(
          currentReservation: arguments);

      // Call the cubit to make multiple reservations
      context.read<ReservationCubit>().postMultipleReservations(
            userId: userId,
            reservationsData: reservationsData,
            arguments: arguments, // Pass the current arguments for UI purposes
          );

      // Clearing the manager should be handled by the ReservationCubit upon successful submission.
      // manager.clearReservations(); // Removed from here
    } else {
      // Just a single reservation, use the standard method
      _confirmBooking(context);
    }
  }

  void _confirmBooking(BuildContext context) async {
    // Get the required data to make the reservation
    if (arguments.selectedDate == null || arguments.selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("الرجاء تحديد التاريخ والوقت"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Get user ID from SharedPreferences
    final userId =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.userId);
    // No mounted check needed in stateless widget

    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("عذراً، يجب تسجيل الدخول أولاً"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final serviceIds = arguments.selectedServices.map((s) => s.id).toList();
    final barberId = arguments.barberData?.id ?? '';
    final date =
        '${arguments.selectedDate!.year}-${arguments.selectedDate!.month.toString().padLeft(2, '0')}-${arguments.selectedDate!.day.toString().padLeft(2, '0')}';

    // Create updated arguments object
    final updatedArguments = ReservationArguments(
      selectedServices: arguments.selectedServices,
      barberData: arguments.barberData,
      totalPrice: arguments.totalPrice,
      selectedDate: arguments.selectedDate,
      selectedTime: arguments.selectedTime,
    );

    // Call the reservation cubit to make the reservation
    // The state handling is now done in the BlocListener
    context.read<ReservationCubit>().postReservation(
          userId: userId ?? '', // Add null check
          serviceIds: serviceIds,
          barberId: barberId,
          date: date,
          startTime: arguments.selectedTime!,
          arguments: updatedArguments,
        );
  }

  // Method to remove a reservation
  void _removeReservation(int index) {
    setState(() {
      _multiReservationManager.removeReservationAt(index);
    });

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("تم حذف الحجز بنجاح"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Method to clear all reservations
  void _clearAllReservations() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.white,

        title: const Text("حذف جميع الحجوزات"),
        content: const Text("هل أنت متأكد من حذف جميع الحجوزات المضافة؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("إلغاء"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _multiReservationManager.clearReservations();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("تم حذف جميع الحجوزات"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              "حذف",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
