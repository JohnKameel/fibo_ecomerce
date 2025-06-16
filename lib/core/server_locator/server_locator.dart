import 'package:dio/dio.dart';
import 'package:fido_e/core/network/api_consumer.dart';
import 'package:fido_e/core/network/dio_service.dart';
import 'package:fido_e/features/auth/data/repo/auth_repo_impl.dart';
import 'package:fido_e/features/auth/data/repo/auth_repository.dart';
import 'package:get_it/get_it.dart';
GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // dio object
  // getIt.registerSingleton<Dio>(Dio());
  // getIt.registerSingleton<ApiConsumer>(DioService(getIt<Dio>()));
  //
  // getIt.registerSingleton<AuthRepository>(AuthRepoImpl(getIt<ApiConsumer>()));
  // getIt.registerFactory<>();
}