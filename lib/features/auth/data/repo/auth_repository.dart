import 'package:dartz/dartz.dart';
import 'package:fido_e/core/network/failure.dart';
import '../model/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> loginByApi(
    String username,
    String password,
  );

  Future<Either<Failure, UserModel>> registerByApi(
    String username,
    String email,
    String password,
  );
}
