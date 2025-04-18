import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temy_barber/core/theme/styles.dart';

import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/booking/ui/widgets/booking_bloc_builder.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ColorsManager.mainBlue,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.mainBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Booking',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tab section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsManager.thirdfMain,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            'Active booking',
                            style: TextStyle(
                              color: ColorsManager.mainBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text('History',
                              style: TextStyles.font13DarkBlueMedium),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Status Indicators
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatusIndicator(
                    context,
                    Icons.calendar_month_outlined,
                    isActive: true,
                  ),
                  _buildStatusConnector(isActive: true),
                  _buildStatusIndicator(
                    context,
                    Icons.access_time_rounded,
                    isActive: false,
                  ),
                  _buildStatusConnector(isActive: false),
                  _buildStatusIndicator(
                    context,
                    Icons.content_cut,
                    isActive: false,
                  ),
                  _buildStatusConnector(isActive: false),
                  _buildStatusIndicator(
                    context,
                    Icons.check_circle_outline,
                    isActive: false,
                  ),
                ],
              ),
            ),

            // Status Text Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatusText('Booked', isActive: true),
                  _buildStatusText('Waiting', isActive: false),
                  _buildStatusText('On Process', isActive: false),
                  _buildStatusText('Finished', isActive: false),
                ],
              ),
            ),

            // Booking card
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: const BookingBlocBuilder(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context, IconData icon,
      {required bool isActive}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isActive ? Colors.amber : Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: isActive ? Colors.white : Colors.grey,
      ),
    );
  }

  Widget _buildStatusConnector({required bool isActive}) {
    return Container(
      width: 20,
      height: 2,
      color: isActive ? Colors.amber : Colors.white,
    );
  }

  Widget _buildStatusText(String text, {required bool isActive}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? ColorsManager.mainBlue : null,
        borderRadius: BorderRadius.circular(12),
        border: isActive ? null : Border.all(color: Colors.black, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: isActive ? Colors.black : Colors.black,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
