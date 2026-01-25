import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          barberError: (errorHandler) => setupError(errorHandler),
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

  Widget setupError(errorHandler) {
    print('Error occurred: $errorHandler');
    return Center(child: Text('${'barber.error'.tr()}: $errorHandler'));
  }
}
