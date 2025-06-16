import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/failure.dart';
import '../model/products_model.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {

  ApiConsumer apiConsumer;
  HomeRepoImpl(this.apiConsumer);

  @override
  Future<Either<Failure, ProductsModel>> getAllProducts() async {
    try {
      final data = await apiConsumer.get('https://dummyjson.com/products');
      return Future.value(Right(ProductsModel.fromJson(data)));
    } catch (e) {
      if (e is DioException) {
        return Future.value(Left(ServerFailure.fromDioException(e)));
      }
      return Future.value(left(ServerFailure(e.toString())));
    }
  }
}