import 'package:bloc/bloc.dart';
import 'package:fido_e/features/home/data/repo/home_repo.dart';
import 'package:meta/meta.dart';

import '../../data/model/products_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  HomeRepo homeRepo;

  getAllProducts() async {
    emit(HomeLoading());

    final result = await homeRepo.getAllProducts();
    result.fold(
      (failure) => emit(HomeFailure(failure.message)),
      (products) => emit(HomeSuccess(products)),
    );
  }
}
