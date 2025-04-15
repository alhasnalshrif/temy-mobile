import 'package:flutter/material.dart';
import 'package:flutter_complete_project/features/barber/ui/widgets/barber_detail_bloc_builder.dart';

class BarberScreen extends StatelessWidget {
  const BarberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SpecializationDoctorBlocBuilder(),
      ),
    );
  }
}
