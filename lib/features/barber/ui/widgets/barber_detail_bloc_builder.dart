import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';
import 'package:temy_barber/features/barber/logic/barber_cubit.dart';
import 'package:temy_barber/features/barber/logic/barber_state.dart';
import 'package:temy_barber/features/barber/ui/widgets/barber_detail_screen.dart';

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
    return Center(
      child: ShimmerLoading.rectangular(height: 400),
    );
  }

  Widget setupSuccess(categoriesList) {
    return BarberScreenItem(serviceResponseModel: categoriesList);
  }

  Widget setupError(errorHandler) {
    print(errorHandler);
    return Center(
      child: Text('Error: ${errorHandler}'),
    );
  }
}
