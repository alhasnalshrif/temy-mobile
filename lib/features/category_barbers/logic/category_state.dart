import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/features/category_barbers/data/models/category_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_state.freezed.dart';

@freezed
class CategoryBarberState with _$CategoryBarberState {
  const factory CategoryBarberState.initial() = _Initial;

  // categories
  // const factory CategoryState.categoryLoading() = CategoryLoading;
  // const factory CategoryState.categorySuccess(
  //     ServiceResponseModel serviceResponseModel) = CategorySuccess;

  // const factory CategoryState.categoryError(ErrorHandler errorHandler) =
  //     CategoryError;

  // categories with barbers
  const factory CategoryBarberState.categoryWithBarbersLoading() =
      CategoryWithBarbersLoading;
  const factory CategoryBarberState.categoryWithBarbersSuccess(
          CategoryServicesResponseModel categoryServicesResponse) =
      CategoryWithBarbersSuccess;
  const factory CategoryBarberState.categoryWithBarbersError(
      ErrorHandler errorHandler) = CategoryWithBarbersError;
}
