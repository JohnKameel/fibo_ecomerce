import 'package:bloc/bloc.dart';
import 'package:fido_e/features/cart/data/repo/cart_repo.dart';
import 'package:meta/meta.dart';

import '../../data/model/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartRepo cartRepo;
  CartCubit(this.cartRepo) : super(CartInitial());

  getCart() async {
    emit(CartLoading());
    final result = await cartRepo.getCart();
    result.fold(
      (failure) => emit(CartFailure(failure.message)),
      (cart) => emit(CartSuccess(cart)),
    );
  }

  addToCart(int productId, int quantity) async {
    emit(CartAdding());
    final result = await cartRepo.addToCart(productId, quantity);
    result.fold(
      (failure) => emit(CartAddFailure(failure.message)),
      (cart) => emit(CartAddedSuccess(cart)),
    );
  }
}
