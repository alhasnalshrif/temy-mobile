import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/features/category/data/models/categories_list_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_state.freezed.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = _Initial;

  // categories
  const factory CategoryState.categoryLoading() = CategoryLoading;
  const factory CategoryState.categorySuccess(
      CategoriesListResponseModel serviceResponseModel) = CategorySuccess;

  const factory CategoryState.categoryError(ErrorHandler errorHandler) =
      CategoryError;


}
