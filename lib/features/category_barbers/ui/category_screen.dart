import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/category_barbers/ui/widgets/category_with_barbers_bloc_builder.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryBarbersScreen extends StatelessWidget {
  const CategoryBarbersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'navigation.barbers'.tr(),
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: ColorsManager.mainBlue,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [CategoryWithBarbersBlocBuilder()],
            ),
          ),
        ),
      ),
    );
  }
}
