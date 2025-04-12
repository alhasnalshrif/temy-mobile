import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/features/category/data/repos/category_repo.dart';
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
      success: (categoryResponseModel) {
        emit(CategoryState.categorySuccess(categoryResponseModel));
      },
      failure: (error) {
        emit(CategoryState.categoryError(error));
      },
    );
  }
}
