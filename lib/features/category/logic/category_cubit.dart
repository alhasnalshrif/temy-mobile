import 'package:temy_barber/core/logic/base_cubit.dart';
import 'package:temy_barber/features/category/data/repos/category_repo.dart';
import 'category_state.dart';

class CategoryCubit extends BaseCubit<CategoryState> {
  final CategoryRepo _categoryRepo;

  CategoryCubit(this._categoryRepo)
      : super(const CategoryState.initial());

  void getCategory() async {
    emit(const CategoryState.categoryLoading());

    executeApi(
      apiCall: () => _categoryRepo.getCategory(),
      onSuccess: (serviceResponseModel) {
        emit(CategoryState.categorySuccess(serviceResponseModel));
      },
      onError: (error) {
        emit(CategoryState.categoryError(error));
      },
    );
  }
}
