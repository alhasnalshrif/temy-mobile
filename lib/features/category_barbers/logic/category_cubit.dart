import 'package:temy_barber/core/logic/base_cubit.dart';
import 'package:temy_barber/features/category_barbers/data/repos/category_repo.dart';
import 'category_state.dart';

class CategoryBarberCubit extends BaseCubit<CategoryBarberState> {
  final CategoryBarberRepo _categoryRepo;
  final String categoryId;

  CategoryBarberCubit(this._categoryRepo, this.categoryId)
    : super(const CategoryBarberState.initial());

  void getCategoryWithBarbers() async {
    emit(const CategoryBarberState.categoryWithBarbersLoading());

    executeApi(
      apiCall: () => _categoryRepo.getCategoryWithBarbers(categoryId),
      onSuccess: (categoryServicesResponse) {
        emit(
          CategoryBarberState.categoryWithBarbersSuccess(
            categoryServicesResponse,
          ),
        );
      },
      onError: (error) {
        emit(CategoryBarberState.categoryWithBarbersError(error));
      },
    );
  }
}
