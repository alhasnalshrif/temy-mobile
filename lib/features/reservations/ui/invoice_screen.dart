import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/utils/responsive_utils.dart';
import 'package:temy_barber/core/widgets/app_buttons.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_response.dart';
import 'package:temy_barber/features/reservations/logic/invoice_logic.dart';
import 'package:temy_barber/features/reservations/ui/widgets/invoice_widgets.dart';
import 'package:temy_barber/features/reservations/ui/widgets/success_header_widget.dart';

class InvoiceScreen extends StatelessWidget {
  final ReservationResponseModel? arguments;
  final _logic = const InvoiceLogic();

  const InvoiceScreen({super.key, this.arguments});

  List<ReservationData> get _allReservations => _logic.getAllReservations(arguments);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ColorsManager.mainBlue,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final isDesktop = ResponsiveUtils.isDesktop(context);

    return Scaffold(
      backgroundColor: isDesktop ? Colors.white : ColorsManager.black,
      appBar: _buildAppBar(context, isDesktop),
      body: Column(
        children: [
          _buildSuccessHeader(isDesktop),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Container(
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  margin: isDesktop ? const EdgeInsets.only(bottom: 24) : EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: isDesktop
                        ? BorderRadius.circular(28)
                        : const BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(20),
                          children: [
                            _buildGuestNotificationBanner(),
                            ..._allReservations.asMap().entries.map((entry) {
                              final index = entry.key;
                              final reservation = entry.value;
                              return _ReservationCard(
                                reservation: reservation,
                                index: _allReservations.length > 1 ? index + 1 : null,
                                isLast: index == _allReservations.length - 1,
                              );
                            }),
                            const SizedBox(height: 16),
                            if (_allReservations.isNotEmpty) _buildTotalCard(),
                          ],
                        ),
                      ),
                      _buildBottomButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isDesktop) {
    return AppBar(
      backgroundColor: isDesktop ? Colors.white : ColorsManager.black,
      elevation: 0,
      title: Text(
        'invoice.title'.tr(),
        style: isDesktop ? TextStyles.font18DarkBlueBold : TextStyles.font18WhiteSemiBold,
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.close, color: isDesktop ? Colors.black : Colors.white),
        onPressed: () => context.goNamed(AppRoutes.homeName),
      ),
    );
  }

  Widget _buildSuccessHeader(bool isDesktop) {
    return SuccessHeaderWidget(
      title: 'invoice.booking_success'.tr(),
      isDesktop: isDesktop,
    );
  }

  Widget _buildGuestNotificationBanner() {
    final hasGuest = _logic.hasGuest(_allReservations);
    if (!hasGuest) return const SizedBox.shrink();

    return GuestNotificationBanner(phone: _logic.getDisplayPhone(_allReservations));
  }

  Widget _buildTotalCard() {
    final grandTotal = _logic.calculateGrandTotal(_allReservations);
    return InvoiceTotalCard(total: grandTotal, isMultiple: _allReservations.length > 1);
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: AppPrimaryButton(
        text: 'invoice.back_to_home'.tr(),
        isFullWidth: true,
        onPressed: () => context.goNamed(AppRoutes.homeName),
      ),
    );
  }
}

class _ReservationCard extends StatelessWidget {
  final ReservationData reservation;
  final int? index;
  final bool isLast;

  const _ReservationCard({
    required this.reservation,
    this.index,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (index != null) _buildIndexHeader(),
        _buildBarberSection(),
        const SizedBox(height: 16),
        _buildDateTimeSection(),
        const SizedBox(height: 16),
        _buildServicesSection(),
        if (!isLast) _buildDivider(),
      ],
    );
  }

  Widget _buildIndexHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
      child: Text(
        "${'booking.reservation'.tr()} #$index",
        style: TextStyles.font16DarkBold.copyWith(color: ColorsManager.mainBlue),
      ),
    );
  }

  Widget _buildBarberSection() {
    final serviceNames = reservation.services.map((s) => s.name).join(' • ');
    return InvoiceSectionCard(
      title: 'invoice.barber'.tr(),
      icon: Icons.person_outline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(reservation.barber.name, style: TextStyles.font16DarkBold),
          if (serviceNames.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              serviceNames,
              style: TextStyles.font13GrayRegular,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDateTimeSection() {
    final isQueueReservation = reservation.isQueueReservation ?? false;

    if (isQueueReservation) {
      return QueueInfoCard(
        queueNumber: reservation.queueNumber,
        queuePosition: reservation.queuePosition,
      );
    }

    final locale = EasyLocalization.of(WidgetsBinding.instance.rootElement!)?.locale.languageCode ?? 'ar';
    final logic = const InvoiceLogic();

    return InvoiceSectionCard(
      title: 'invoice.appointment_date'.tr(),
      icon: Icons.calendar_today_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InvoiceInfoRow(
       label:      'invoice.date'.tr(),
           value:  logic.formatReservationDate(reservation.date, locale),
          ),
          const SizedBox(height: 8),
          InvoiceInfoRow(
           label:  'invoice.time'.tr(),
         value:    logic.formatReservationTime(reservation.startTime, locale),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    return InvoiceSectionCard(
      title: 'invoice.services'.tr(),
      icon: Icons.content_cut,
      child: reservation.services.isNotEmpty
          ? Column(
              children: reservation.services
                  .map((service) => InvoiceServiceItem(service: service))
                  .toList(),
            )
          : Text('invoice.no_services'.tr(), style: TextStyles.font13GrayRegular),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Divider(),
    );
  }
}
