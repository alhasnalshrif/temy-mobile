import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/category_barbers/data/repos/category_repo.dart';
import 'category_state.dart';

class CategoryBarberCubit extends Cubit<CategoryBarberState> {
  final CategoryBarberRepo _categoryRepo;
  final String categoryId;

  CategoryBarberCubit(this._categoryRepo, this.categoryId)
      : super(const CategoryBarberState.initial());



  void getCategoryWithBarbers() async {
    emit(const CategoryBarberState.categoryWithBarbersLoading());
    final response = await _categoryRepo.getCategoryWithBarbers(categoryId);
    response.when(
      success: (categoryServicesResponse) {
        emit(
            CategoryBarberState.categoryWithBarbersSuccess(categoryServicesResponse));
      },
      failure: (error) {
        emit(CategoryBarberState.categoryWithBarbersError(error));
      },
    );
  }
}
