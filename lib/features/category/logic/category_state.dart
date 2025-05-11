import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/features/category/data/models/category_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_state.freezed.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = _Initial;

  // categories
  // const factory CategoryState.categoryLoading() = CategoryLoading;
  // const factory CategoryState.categorySuccess(
  //     ServiceResponseModel serviceResponseModel) = CategorySuccess;

  // const factory CategoryState.categoryError(ErrorHandler errorHandler) =
  //     CategoryError;

  // categories with barbers
  const factory CategoryState.categoryWithBarbersLoading() =
      CategoryWithBarbersLoading;
  const factory CategoryState.categoryWithBarbersSuccess(
          CategoryServicesResponseModel categoryServicesResponse) =
      CategoryWithBarbersSuccess;
  const factory CategoryState.categoryWithBarbersError(
      ErrorHandler errorHandler) = CategoryWithBarbersError;
}
