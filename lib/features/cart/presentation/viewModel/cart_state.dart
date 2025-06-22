part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}
final class CartLoading extends CartState {}
final class CartSuccess extends CartState {
  final CartModel cart;

  CartSuccess(this.cart);
}
final class CartFailure extends CartState {
  final String errorMessage;

  CartFailure(this.errorMessage);
}

final class CartAdding extends CartState {}

final class CartAddedSuccess extends CartState {
  final CartModel cart;

  CartAddedSuccess(this.cart);
}

final class CartAddFailure extends CartState {
  final String errorMessage;

  CartAddFailure(this.errorMessage);
}