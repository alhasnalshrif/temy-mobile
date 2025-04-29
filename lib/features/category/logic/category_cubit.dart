import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/features/category/data/repos/category_repo.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo _categoryRepo;
  final String categoryId;

  CategoryCubit(this._categoryRepo, this.categoryId)
      : super(const CategoryState.initial());

  void getCategory() async {
    emit(const CategoryState.categoryLoading());
    final response = await _categoryRepo.getCategory(categoryId);
    response.when(
      success: (serviceResponseModel) {
        emit(CategoryState.categorySuccess(serviceResponseModel));
      },
      failure: (error) {
        emit(CategoryState.categoryError(error));
      },
    );
  }

  void getCategoryWithBarbers() async {
    emit(const CategoryState.categoryWithBarbersLoading());
    final response = await _categoryRepo.getCategoryWithBarbers(categoryId);
    response.when(
      success: (categoryServicesResponse) {
        emit(
            CategoryState.categoryWithBarbersSuccess(categoryServicesResponse));
      },
      failure: (error) {
        emit(CategoryState.categoryWithBarbersError(error));
      },
    );
  }
}
