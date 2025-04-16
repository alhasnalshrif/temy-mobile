import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/features/category/logic/category_cubit.dart';
import 'package:temy_barber/features/category/logic/category_state.dart';

import 'package:temy_barber/features/category/ui/widgets/category_list_view.dart';

class SpecializationDoctorBlocBuilder extends StatelessWidget {
  const SpecializationDoctorBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      buildWhen: (previous, current) =>
          current is CategoryLoading ||
          current is CategorySuccess ||
          current is CategoryError,
      builder: (context, state) {
        return state.maybeMap(
          categoryLoading: (value) {
            return setupLoading();
          },
          categorySuccess: (categoriesResponseModel) {
            print(categoriesResponseModel.serviceResponseModel.serviceDataList);
            print(
                'categoriesResponseModel.categoryResponseModel.categoryDataList');
            var categoriesList =
                categoriesResponseModel.serviceResponseModel.serviceDataList;
            return setupSuccess(categoriesList);
          },
          categoryError: (errorHandler) => setupError(),
          orElse: () {
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget setupLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget setupSuccess(categoriesList) {
    return Expanded(
      child: Column(
        children: [
          CategoryListView(specializationDataList: categoriesList ?? []),
          verticalSpace(24),
        ],
      ),
    );
  }

  Widget setupError() {
    return const SizedBox.shrink();
  }
}
