import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/features/category/ui/widgets/specialization_doctor_bloc_builder.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(10),
              const SpecializationDoctorBlocBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
