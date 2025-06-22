import 'package:dartz/dartz.dart';
import 'package:fido_e/core/network/failure.dart';
import 'package:fido_e/features/cart/data/model/cart_model.dart';

abstract class CartRepo {
  Future<Either<Failure, CartModel>> getCart();
  Future<Either<Failure, CartModel>> addToCart(int productId, int quantity);
}