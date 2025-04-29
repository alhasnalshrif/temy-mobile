import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/features/category/logic/category_cubit.dart';
import 'package:temy_barber/features/category/ui/widgets/category_with_barbers_bloc_builder.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the call to get barbers with category
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryCubit>().getCategoryWithBarbers();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('navigation.categories'.tr()),
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
              const CategoryWithBarbersBlocBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
