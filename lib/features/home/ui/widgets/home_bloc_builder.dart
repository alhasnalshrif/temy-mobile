import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/widgets/no_internet_page.dart';
import 'package:temy_barber/features/home/logic/home_cubit.dart';
import 'package:temy_barber/features/home/logic/home_state.dart';
import 'package:temy_barber/features/home/ui/widgets/category_list_view.dart';
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
    return Center(
      child: ShimmerLoading.rectangular(height: 200),
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
