import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/widgets/no_internet_page.dart';
import 'package:temy_barber/features/home/logic/home_cubit.dart';
import 'package:temy_barber/features/home/logic/home_state.dart';
import 'package:temy_barber/features/home/ui/widgets/barber/barber_list_view.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';

class HomeBlocBuilder extends StatelessWidget {
  const HomeBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is BarbersLoading ||
          current is BarbersSuccess ||
          current is BarbersError,
      builder: (context, state) {
        return state.maybeMap(
          barbersLoading: (value) {
            return setupLoading();
          },
          barbersSuccess: (barbersResponseModel) {
            var barberesLis =
                barbersResponseModel.barbersResponseModel.barberDataList;
            return setupSuccess(barberesLis);
          },
          barbersError: (errorHandler) => setupError(context),
          orElse: () {
            return const SizedBox.shrink();
          },
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

  Widget setupSuccess(barberesLis) {
    return Column(
      children: [
        CategoryListView(categoryDataList: barberesLis ?? []),
      ],
    );
  }

  Widget setupError(context) {
    return NoInternetPage(
      onRetry: () => context.read<HomeCubit>().refreshHomeData(),
    );
    // return const SizedBox.shrink();
  }
}
