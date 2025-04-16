import 'package:flutter/material.dart';
import 'package:temy_barber/features/barber/ui/widgets/barber_detail_bloc_builder.dart';

class BarberScreen extends StatelessWidget {
  const BarberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: BarberDetailBlocBuilder(),
      ),
    );
  }
}
