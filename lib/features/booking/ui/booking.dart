import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import BlocProvider

import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart'; // Import BookingCubit
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
      body: RefreshIndicator(
        color: ColorsManager.mainBlue,
        backgroundColor: Colors.white,
        onRefresh: () async {
          context.read<BookingCubit>().getBooking();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
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
        ),
      ),
    );
  }
}
