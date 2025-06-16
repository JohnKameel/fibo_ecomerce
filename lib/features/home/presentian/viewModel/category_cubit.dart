import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repo/category_repo.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo categoryRepo;
  CategoryCubit(this.categoryRepo) : super(CategoryInitial());

  Future<void> getAllCategories() async {
    emit(CategoryLoading());

    try {
      final categories = await categoryRepo.getCategories();
      emit(CategorySuccess(categories));
    } catch (e) {
      emit(CategoryFailure(e.toString()));
    }
  }
}
