import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';
import 'package:temy_barber/features/category/data/models/category_response.dart';
import 'package:temy_barber/features/category/logic/category_cubit.dart';
import 'package:temy_barber/features/category/logic/category_state.dart';
import 'package:temy_barber/features/category/ui/widgets/category_list_view.dart';

class CategoryWithBarbersBlocBuilder extends StatelessWidget {
  const CategoryWithBarbersBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      buildWhen: (previous, current) =>
          current is CategoryWithBarbersLoading ||
          current is CategoryWithBarbersSuccess ||
          current is CategoryWithBarbersError,
      builder: (context, state) {
        return state.maybeMap(
          categoryWithBarbersLoading: (_) => setupLoading(),
          categoryWithBarbersSuccess: (successState) =>
              setupSuccess(successState.categoryServicesResponse, context),
          categoryWithBarbersError: (_) => setupError(),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget setupLoading() {
    return Center(
      child: ShimmerLoading.rectangular(height: 400),
    );
  }

  Widget setupSuccess(
      CategoryServicesResponseModel response, BuildContext context) {
    final barbers = response.data?.barbers ?? [];

    if (barbers.isEmpty) {
      return const Center(
        child: Text('No barbers available for this category'),
      );
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryBarberListView(barberDataList: barbers),
        ],
      ),
    );
  }

  Widget setupError() {
    return const Center(
      child: Text('Failed to load barbers'),
    );
  }
}
