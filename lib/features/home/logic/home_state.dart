import 'package:flutter_complete_project/core/networking/api_error_handler.dart';
import 'package:flutter_complete_project/features/home/data/models/category_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;

  // categories
  const factory HomeState.categoriesLoading() = CategoriesLoading;
  const factory HomeState.categoriesSuccess(CategoryResponseModel categoriesResponseModel) = CategoriesSuccess;

  const factory HomeState.categoriesError(ErrorHandler errorHandler) = CategoriesError;

}
