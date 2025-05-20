import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/features/category_barbers/ui/widgets/category_with_barbers_bloc_builder.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryBarbersScreen extends StatelessWidget {
  const CategoryBarbersScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('navigation.barbers'.tr()),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(10),
              const CategoryWithBarbersBlocBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
