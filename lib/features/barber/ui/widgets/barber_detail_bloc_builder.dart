import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';
import 'package:temy_barber/features/barber/logic/barber_cubit.dart';
import 'package:temy_barber/features/barber/logic/barber_state.dart';
import 'package:temy_barber/features/barber/ui/widgets/barber_detail_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class BarberDetailBlocBuilder extends StatelessWidget {
  const BarberDetailBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberCubit, BarberState>(
      buildWhen: (previous, current) =>
          current is BarberLoading ||
          current is BarberSuccess ||
          current is BarberError,
      builder: (context, state) {
        return state.maybeMap(
          barberLoading: (value) {
            return setupLoading();
          },
          barberSuccess: (categoriesResponseModel) {
            var categoriesList =
                categoriesResponseModel.barberDetailResponseModel.data;
            return setupSuccess(categoriesList);
          },
          barberError: (errorHandler) => setupError(context, errorHandler),
          orElse: () {
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget setupLoading() {
    // Optimized shimmer: show a vertical list of shimmer placeholders matching the detail layout
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3, // Show 3 shimmer items as placeholders for detail sections
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title shimmer
            ShimmerLoading.rectangular(height: 22),
            const SizedBox(height: 12),
            // Subtitle shimmer
            ShimmerLoading.rectangular(height: 16),
            const SizedBox(height: 16),
            // Content shimmer (e.g., for a card or image)
            ShimmerLoading.rectangular(height: 80, width: double.infinity),
          ],
        ),
      ),
    );
  }

  Widget setupSuccess(categoriesList) {
    return BarberScreenItem(serviceResponseModel: categoriesList);
  }

  Widget setupError(BuildContext context, errorHandler) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'barber.failed_to_load'.tr(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'common.error'.tr(),
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<BarberCubit>().retry();
              },
              icon: const Icon(Icons.refresh),
              label: Text('common.retry'.tr()),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.mainBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
