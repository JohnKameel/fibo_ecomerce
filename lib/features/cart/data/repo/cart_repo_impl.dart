import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fido_e/core/network/api_consumer.dart';

import '../../../../core/network/failure.dart';
import '../model/cart_model.dart';
import 'cart_repo.dart';

class CartRepoImpl implements CartRepo {
  ApiConsumer apiConsumer;
  CartRepoImpl(this.apiConsumer);

  @override
  Future<Either<Failure, CartModel>> getCart() async {
    try {
      final data = await apiConsumer.get("https://dummyjson.com/carts/1");
      return Future.value(Right(CartModel.fromJson(data)));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure(e.message.toString()));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartModel>> addToCart(
      int productId, int quantity) async {
    try {
      final data = await apiConsumer.put(
        "https://dummyjson.com/carts/1",
        {
          "merge": true,
          "products": [
            {
              "id": productId,
              "quantity": quantity,
            }
          ],
        },
      );
      return Future.value(Right(CartModel.fromJson(data)));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure(e.message.toString()));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
