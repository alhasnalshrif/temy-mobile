import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/features/category/data/repos/category_repo.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo _categoryRepo;
  static const _timeout = Duration(seconds: 20);

  CategoryCubit(this._categoryRepo, )
      : super(const CategoryState.initial());

  void getCategory() async {
    emit(const CategoryState.categoryLoading());

    try {
      final response = await _categoryRepo.getCategory().timeout(_timeout);
      response.when(
        success: (serviceResponseModel) {
          emit(CategoryState.categorySuccess(serviceResponseModel));
        },
        failure: (error) {
          emit(CategoryState.categoryError(error));
        },
      );
    } on TimeoutException catch (e) {
      emit(CategoryState.categoryError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(CategoryState.categoryError(ErrorHandler.handle(e)));
    }
  }
}
