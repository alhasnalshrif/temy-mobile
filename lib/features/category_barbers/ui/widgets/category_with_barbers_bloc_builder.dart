import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/core/theme/colors.dart';
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
          categoryWithBarbersError: (errorState) =>
              setupError(context, errorState.errorHandler),
          orElse: setupLoading,
        );
      },
    );
  }

  Widget setupLoading() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 6,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: ColorsManager.mainBlue.withValues(alpha: 0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            ShimmerLoading.circular(size: 68),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShimmerLoading.rectangular(height: 20, width: 140),
                  const SizedBox(height: 8),
                  ShimmerLoading.rectangular(height: 14, width: 80),
                  const SizedBox(height: 8),
                  ShimmerLoading.rectangular(height: 14, width: 40),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ShimmerLoading.rectangular(
              height: 36,
              width: 80,
            ), // for the "Book Now" pill
          ],
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

    return CategoryBarberListView(barberDataList: barbers);
  }

  Widget setupError(BuildContext context, ErrorHandler errorHandler) {
    final message = _resolveErrorMessage(errorHandler);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              size: 52,
              color: ColorsManager.mainBlue,
            ),
            const SizedBox(height: 14),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                context.read<CategoryBarberCubit>().getCategoryWithBarbers();
              },
              icon: const Icon(Icons.refresh_rounded),
              label: Text('errors.retry_button'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  String _resolveErrorMessage(ErrorHandler errorHandler) {
    final raw = (errorHandler.apiErrorModel.message ?? '').trim();

    if (raw.isEmpty) {
      return 'barber.failed_to_load'.tr();
    }

    // If backend returns a localization key, translate it.
    if (raw.startsWith('errors.') || raw.startsWith('barber.')) {
      return raw.tr();
    }

    return raw;
  }
}
