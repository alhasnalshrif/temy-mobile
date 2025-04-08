// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_complete_project/features/home/data/repos/home_repo.dart';
// import 'home_state.dart';

// class HomeCubit extends Cubit<HomeState> {
//   final HomeRepo _homeRepo;
//   HomeCubit(this._homeRepo) : super(const HomeState.initial());

//   void getCategories() async {
//     emit(const HomeState.categoriesLoading());
//     final response = await _homeRepo.getCategorie();
//     response.when(
//       success: (categoriesResponseModel) {
//         emit(HomeState.categoriesSuccess(categoriesResponseModel));
//       },
//       failure: (error) {
//         emit(HomeState.categoriesError(error));
//       },
//     );
//   }
// }
