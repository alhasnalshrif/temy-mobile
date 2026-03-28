import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/category_barbers/data/repos/category_repo.dart';
import 'category_state.dart';

class CategoryBarberCubit extends Cubit<CategoryBarberState> {
  final CategoryBarberRepo _categoryRepo;
  final String categoryId;
  static const _timeout = Duration(seconds: 20);

  CategoryBarberCubit(this._categoryRepo, this.categoryId)
    : super(const CategoryBarberState.initial());

  void getCategoryWithBarbers() async {
    emit(const CategoryBarberState.categoryWithBarbersLoading());
    try {
      final response = await _categoryRepo
          .getCategoryWithBarbers(categoryId)
          .timeout(_timeout);

      response.when(
        success: (categoryServicesResponse) {
          emit(
            CategoryBarberState.categoryWithBarbersSuccess(
              categoryServicesResponse,
            ),
          );
        },
        failure: (error) {
          emit(CategoryBarberState.categoryWithBarbersError(error));
        },
      );
    } on TimeoutException catch (e) {
      emit(
        CategoryBarberState.categoryWithBarbersError(ErrorHandler.handle(e)),
      );
    } catch (e) {
      emit(
        CategoryBarberState.categoryWithBarbersError(ErrorHandler.handle(e)),
      );
    }
  }
}
