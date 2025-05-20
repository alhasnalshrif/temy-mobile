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

class BookingConfirmation extends StatelessWidget {
  final ReservationArguments arguments;
  // Create instance of MultiReservationManager
  final MultiReservationManager multiReservationManager =
      MultiReservationManager();

  BookingConfirmation({
    super.key,
    required this.arguments,
  });

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
            style: TextStyles.font18DarkBlueBold,
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 1,
          shadowColor: Colors.black.withOpacity(0.05),
          actions: [
            if (MultiReservationManager().reservations.isNotEmpty)
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      _showMultipleReservationsDialog(context);
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: ColorsManager.mainBlue,
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${MultiReservationManager().reservations.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 24),
                        _buildOrderSummary(),
                        const SizedBox(height: 24),
                        _buildBarberInfo(),
                        const SizedBox(height: 24),
                        _buildAppointmentInfo(),
                        const SizedBox(height: 24),
                        _buildPaymentInfo(),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsManager.lightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.info_outline,
            size: 32,
            color: ColorsManager.mainBlue,
          ),
          const SizedBox(height: 8),
          Text(
            "مراجعة تفاصيل حجزك",
            style: TextStyles.font16DarkBold,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "الرجاء مراجعة تفاصيل الحجز قبل التأكيد",
            style: TextStyles.font14GrayRegular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ملخص الخدمات",
          style: TextStyles.font16DarkBold,
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: arguments.selectedServices.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final service = arguments.selectedServices[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      service.name,
                      style: TextStyles.font14DarkBlueMedium,
                    ),
                  ),
                  Text(
                    "${service.duration} دقيقة",
                    style: TextStyles.font14GrayRegular,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "${service.price} ريال",
                    style: TextStyles.font14DarkBlueMedium,
                  ),
                ],
              ),
            );
          },
        ),
        const Divider(thickness: 1.5),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "المجموع",
                style: TextStyles.font16DarkBold,
              ),
              Text(
                "${arguments.totalPrice} ريال",
                style: TextStyles.font16DarkBold,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBarberInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الحلاق",
          style: TextStyles.font16DarkBold,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: arguments.barberData?.avatar != null
                  ? NetworkImage(arguments.barberData!.avatar)
                  : null,
              child: arguments.barberData?.avatar == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  arguments.barberData?.name ?? "غير محدد",
                  style: TextStyles.font16DarkBold,
                ),
                if (arguments.barberData?.rating != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        arguments.barberData!.rating.toString(),
                        style: TextStyles.font14GrayRegular,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAppointmentInfo() {
    String formattedDate = "غير محدد";
    if (arguments.selectedDate != null) {
      formattedDate = DateFormat('EEEE, d MMMM, yyyy', 'ar')
          .format(arguments.selectedDate!);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "موعد الحجز",
          style: TextStyles.font16DarkBold,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorsManager
                .thirdfMain, // Using thirdfMain instead of lightBackground
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.calendar_today,
                color: ColorsManager.mainBlue,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyles.font14DarkBlueMedium,
                    ),
                    if (arguments.selectedTime != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        "الساعة ${arguments.selectedTime}",
                        style: TextStyles.font14GrayRegular,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "طريقة الدفع",
          style: TextStyles.font16DarkBold,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.payments_outlined,
                color: ColorsManager.mainBlue,
              ),
              const SizedBox(width: 16),
              Text(
                "الدفع عند الوصول",
                style: TextStyles.font14DarkBlueMedium,
              ),
              const Spacer(),
              const Icon(
                Icons.check_circle,
                color: ColorsManager.mainBlue,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    _addToMultipleReservations(context);
                  },
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: ColorsManager.mainBlue,
                  ),
                  label: const Text(
                    "إضافة حجز آخر",
                    style: TextStyle(
                      color: ColorsManager.mainBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(color: ColorsManager.mainBlue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(color: ColorsManager.mainBlue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "تعديل",
                    style: TextStyle(
                      color: ColorsManager.mainBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _confirmMultipleReservations(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.mainBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    MultiReservationManager().reservations.isEmpty
                        ? "تأكيد الحجز"
                        : "تأكيد الحجوزات (${MultiReservationManager().reservations.length + 1})",
                    style: const TextStyle(
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
    MultiReservationManager().addReservation(arguments);

    // Show confirmation snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("تم إضافة الحجز، يمكنك الآن اختيار خدمات أخرى"),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate back to category screen to choose another service
    Navigator.pushNamed(
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
    }

    // Check if we have multiple reservations
    final manager = MultiReservationManager();
    if (manager.reservations.isNotEmpty) {
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
      }

      // Prepare reservations data for API call
      final reservationsData =
          manager.getReservationsData(currentReservation: arguments);

      // Call the cubit to make multiple reservations
      context.read<ReservationCubit>().postMultipleReservations(
            userId: userId,
            reservationsData: reservationsData,
            arguments: arguments, // Pass the current arguments for UI purposes
          );

      // Clear the manager after submission
      manager.clearReservations();
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

  // Show dialog with multiple reservations
  void _showMultipleReservationsDialog(BuildContext context) {
    final manager = MultiReservationManager();
    final reservations = manager.reservations;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "حجوزاتك المتعددة",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorsManager.mainBlue,
            ),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: reservations.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final reservation = reservations[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    reservation.barberData?.name ?? "غير محدد",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الخدمات: ${reservation.selectedServices.map((s) => s.name).join(', ')}",
                      ),
                      Text(
                        "التاريخ: ${DateFormat('dd/MM/yyyy', 'ar').format(reservation.selectedDate!)}",
                      ),
                      Text(
                        "الوقت: ${reservation.selectedTime}",
                      ),
                      Text(
                        "المبلغ: ${reservation.totalPrice} ريال",
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      manager.removeReservation(index);
                      Navigator.pop(context);
                      // If there are still reservations, show the dialog again
                      if (manager.reservations.isNotEmpty) {
                        _showMultipleReservationsDialog(context);
                      }
                      // Refresh the UI
                      (context as Element).markNeedsBuild();
                    },
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                manager.clearReservations();
                Navigator.pop(context);
                // Refresh the UI
                (context as Element).markNeedsBuild();
              },
              child: const Text(
                "حذف الكل",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("إغلاق"),
            ),
          ],
        );
      },
    );
  }
}
