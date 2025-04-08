import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/core/helpers/spacing.dart';
import 'package:flutter_complete_project/features/home/logic/home_cubit.dart';
import 'package:flutter_complete_project/features/home/logic/home_state.dart';
import 'package:flutter_complete_project/features/home/ui/widgets/category_list_view.dart';

class SpecializationDoctorBlocBuilder extends StatelessWidget {
  const SpecializationDoctorBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is CategoriesLoading ||
          current is CategoriesSuccess ||
          current is CategoriesError,
      builder: (context, state) {
        return state.maybeMap(
          categoriesLoading: (value) {
            return setupLoading();
          },
          categoriesSuccess: (categoriesResponseModel) {
            var categoriesList = categoriesResponseModel
                .categoriesResponseModel.categoryDataList;
            return setupSuccess(categoriesList);
          },
          categoriesError: (errorHandler) => setupError(),
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
          CategoryListView(
              specializationDataList: categoriesList ?? []),
          verticalSpace(24),
        ],
      ),
    );
  }

  Widget setupError() {
    return const SizedBox.shrink();
  }
}
