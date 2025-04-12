import 'package:flutter_complete_project/core/networking/api_error_handler.dart';
import 'package:flutter_complete_project/features/category/data/models/category_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part  'category_state.freezed.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = _Initial;

  // categories
  const factory CategoryState.categoryLoading() = CategoryLoading;
  const factory CategoryState.categorySuccess(CategoryResponseModel categoryResponseModel) = CategorySuccess;

  const factory CategoryState.categoryError(ErrorHandler errorHandler) = CategoryError;

}
