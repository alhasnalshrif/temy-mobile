import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemExtent: 100,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.withOpacity(0.15)),
          ),
          child: Row(
            children: [
              ShimmerLoading.circular(size: 64),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShimmerLoading.rectangular(
                      height: 20,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 8),
                    ShimmerLoading.rectangular(height: 14, width: 120),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ShimmerLoading.rectangular(height: 18, width: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget setupSuccess(
    CategoryServicesResponseModel response,
    BuildContext context,
  ) {
    final barbers = response.data?.barbers ?? [];

    if (barbers.isEmpty) {
      return Center(child: Text('barber.no_barbers_available'.tr()));
    }

    return Expanded(child: CategoryBarberListView(barberDataList: barbers));
  }

  Widget setupError() {
    return Center(child: Text('barber.failed_to_load'.tr()));
  }
}
