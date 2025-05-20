import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';
import 'package:temy_barber/features/category_barbers/data/models/category_response.dart';
import 'package:temy_barber/features/category_barbers/logic/category_cubit.dart';
import 'package:temy_barber/features/category_barbers/logic/category_state.dart';
import 'package:temy_barber/features/category_barbers/ui/widgets/category_list_view.dart';

class CategoryWithBarbersBlocBuilder extends StatelessWidget {
  const CategoryWithBarbersBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBarberCubit, CategoryBarberState>(
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
    // Optimized shimmer: show a list of shimmer tiles similar to barber cards
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 6, // Show 6 shimmer items as placeholders
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar shimmer
            ShimmerLoading.circular(
              size: 56,
            ),
            const SizedBox(width: 16),
            // Text shimmer
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerLoading.rectangular(height: 16, width: 120),
                  const SizedBox(height: 8),
                  ShimmerLoading.rectangular(height: 12, width: 80),
                ],
              ),
            ),
          ],
        ),
      ),
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
