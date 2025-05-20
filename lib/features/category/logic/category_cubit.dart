import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/features/category/data/repos/category_repo.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo _categoryRepo;

  CategoryCubit(this._categoryRepo, )
      : super(const CategoryState.initial());

  void getCategory() async {
    emit(const CategoryState.categoryLoading());
    final response = await _categoryRepo.getCategory();
    response.when(
      success: (serviceResponseModel) {
        emit(CategoryState.categorySuccess(serviceResponseModel));
      },
      failure: (error) {
        emit(CategoryState.categoryError(error));
      },
    );
  }

  
}
