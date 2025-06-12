import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fido_e/core/network/api_consumer.dart';
import '../../../../core/network/failure.dart';
import '../model/user_model.dart';
import 'auth_repository.dart';

class AuthRepoImpl implements AuthRepository {
  ApiConsumer apiConsumer;
  AuthRepoImpl(this.apiConsumer);
  @override
  Future<Either<Failure, UserModel>> loginByApi(
      String username, String password) async {
    try {
      final data = await apiConsumer.post('https://dummyjson.com/user/login', {
        'username': username,
        'password': password,
      });
      final user = UserModel.fromJson(data as Map<String, dynamic>);
      return Future.value(Right(user));
    } catch (e) {
      if (e is DioException) {
        return Future.value(Left(ServerFailure.fromDioException(e)));
      }
      return Future.value(left(ServerFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, UserModel>> registerByApi(
      String email, String username, String password) async {
    try {
      final data = await apiConsumer.post('https://dummyjson.com/users/add', {
        'email': email,
        'username': username,
        'password': password,
      });
      final user = UserModel.fromJson(data as Map<String, dynamic>);
      return Future.value(Right(user));
    } catch (e) {
      if (e is DioException) {
        return Future.value(Left(ServerFailure.fromDioException(e)));
      }
      return Future.value(left(ServerFailure(e.toString())));
    }
  }
}
