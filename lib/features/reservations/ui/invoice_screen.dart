import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';

class InvoiceScreen extends StatelessWidget {
  final ReservationArguments? arguments;

  const InvoiceScreen({super.key, this.arguments});

  // Get barber and services data
  BarberDetailData? get barberData => arguments?.barberData;
  List<BarberService> get selectedServices => arguments?.selectedServices ?? [];
  double get totalPrice => arguments?.totalPrice ?? 0.0;
  DateTime? get reservationDate => arguments?.selectedDate;
  String? get reservationTime => arguments?.selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'الفاتورة',
          style: TextStyles.font18WhiteSemiBold,
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Confirmation Check
                    _buildConfirmationCheck(),

                    // Invoice Card
                    Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          // Barber Info
                          _buildBarberInfo(),

                          const Divider(height: 1),

                          // Date and Time
                          _buildDateTimeSection(),

                          const Divider(height: 1),

                          // Services List
                          _buildServicesList(),

                          // Total
                          _buildTotalSection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Action Buttons
            _buildBottomButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationCheck() {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 8,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.check,
          size: 40,
          color: Colors.black,
          weight: 3.0,
        ),
      ),
    );
  }

  Widget _buildBarberInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            barberData?.name ?? "Temy",
            style: TextStyles.font18DarkBlueBold,
          ),
          const Spacer(),
          Flexible(
            child: Text(
              selectedServices.isNotEmpty
                  ? selectedServices.first.name
                  : 'حلاقة شعر',
              style: TextStyles.font14GrayRegular,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeSection() {
    // Format date using intl package (with Arabic locale support if needed)
    final dateStr = reservationDate != null
        ? DateFormat('EEE, dd MMM', 'en').format(reservationDate!)
        : 'Sun, 15 Jan';

    final timeStr = reservationTime ?? '08:00 AM';

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.calendar_today_outlined),
          const SizedBox(width: 12),
          Text(
            "التاريخ والوقت",
            style: TextStyles.font16DarkBold,
          ),
          const Spacer(),
          Text(
            "$dateStr - $timeStr",
            style: TextStyles.font14GrayRegular,
          ),
        ],
      ),
    );
  }

  Widget _buildServicesList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "تفاصيل الدفع",
            style: TextStyles.font16DarkBold,
          ),
          const SizedBox(height: 16),

          // Dynamically build service items from selectedServices
          ...selectedServices.map((service) =>
              _buildServiceItem(service.name, service.price.toDouble())),

          // Add discount if applicable
          if (selectedServices.isNotEmpty &&
              totalPrice <
                  selectedServices.fold(
                      0.0, (sum, service) => sum + service.price))
            _buildServiceItem(
                "الخصم",
                selectedServices.fold(
                        0.0, (sum, service) => sum + service.price) -
                    totalPrice,
                isDiscount: true),
        ],
      ),
    );
  }

  Widget _buildServiceItem(String name, double price,
      {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            name,
            style: isDiscount
                ? TextStyles.font14GrayRegular
                : TextStyles.font16DarkBold,
          ),
          const Spacer(),
          Text(
            "${isDiscount ? '-' : ''}${price.toInt()} EGP",
            style: isDiscount
                ? TextStyles.font14GrayRegular.copyWith(color: Colors.red)
                : TextStyles.font14DarkBlueMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: ColorsManager.lighterGray,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "المجموع",
            style: TextStyles.font18DarkBlueBold,
          ),
          Text(
            "${totalPrice.toInt()} EGP",
            style: TextStyles.font18DarkBlueBold,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3D3B6D),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                );
              },
              child: Text(
                'الصفحة الرئيسية',
                style: TextStyles.font16WhiteMedium,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => _generateAndShareInvoice(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.share, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'مشاركة',
                    style: TextStyles.font16WhiteMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to generate and share the invoice as PDF
  Future<void> _generateAndShareInvoice(BuildContext context) async {
    try {
      final pdf = pw.Document();
      final arabicFont =
          await rootBundle.load("assets/cairo/Cairo-Regular.ttf");
      final ttf = pw.Font.ttf(arabicFont);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Invoice header
                pw.Center(
                  child: pw.Text(
                    'Temy Barber',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Center(
                  child: pw.Text(
                    'فاتورة الحجز',
                    style: pw.TextStyle(font: ttf, fontSize: 22),
                    textDirection: pw.TextDirection.rtl,
                  ),
                ),
                pw.SizedBox(height: 30),

                // Customer info
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Barber: ${barberData?.name ?? "Temy"}',
                      style: const pw.TextStyle(fontSize: 14),
                    ),
                    pw.Text(
                      'Date: ${reservationDate != null ? DateFormat('yyyy-MM-dd').format(reservationDate!) : "N/A"}',
                      style: const pw.TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Time: ${reservationTime ?? "N/A"}',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.SizedBox(height: 20),

                // Services list
                pw.Text(
                  'Services:',
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),

                ...selectedServices.map(
                  (service) => pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(service.name),
                      pw.Text('${service.price.toInt()} EGP'),
                    ],
                  ),
                ),

                pw.SizedBox(height: 20),
                pw.Divider(),

                // Total
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Total:',
                      style: pw.TextStyle(
                          fontSize: 16, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      '${totalPrice.toInt()} EGP',
                      style: pw.TextStyle(
                          fontSize: 16, fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),

                pw.SizedBox(height: 40),
                pw.Center(
                  child: pw.Text(
                    'Thank you for your business!',
                    style: pw.TextStyle(
                        fontSize: 14, fontStyle: pw.FontStyle.italic),
                  ),
                ),
              ],
            );
          },
        ),
      );

      // Save the PDF
      final output = await getTemporaryDirectory();
      final file = File('${output.path}/invoice.pdf');
      await file.writeAsBytes(await pdf.save());

      // Share the PDF
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Your Temy Barber Invoice',
        text: 'Here is your booking invoice from Temy Barber.',
      );
    } catch (e) {
      // Show error if PDF generation fails
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to generate invoice: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
