import 'package:dartz/dartz.dart';
import 'package:fido_e/core/network/failure.dart';

import '../model/products_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, ProductsModel>> getAllProducts();
}
