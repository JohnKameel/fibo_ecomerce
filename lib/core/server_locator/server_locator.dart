import 'package:dio/dio.dart';
import 'package:fido_e/core/network/api_consumer.dart';
import 'package:fido_e/core/network/dio_service.dart';
import 'package:fido_e/features/auth/data/repo/auth_repo_impl.dart';
import 'package:fido_e/features/auth/data/repo/auth_repository.dart';
import 'package:fido_e/features/auth/presentian/viewModel/register_cubit.dart';
import 'package:fido_e/features/cart/data/repo/cart_repo.dart';
import 'package:fido_e/features/cart/data/repo/cart_repo_impl.dart';
import 'package:fido_e/features/home/data/repo/category_repo.dart';
import 'package:fido_e/features/home/data/repo/category_repo_impl.dart';
import 'package:fido_e/features/home/data/repo/product_repo.dart';
import 'package:fido_e/features/home/data/repo/product_repo_impl.dart';
import 'package:fido_e/features/home/presentian/viewModel/home_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/presentian/viewModel/login_cubit.dart';
import '../../features/cart/presentation/viewModel/cart_cubit.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../../features/home/data/repo/home_repo_impl.dart';
import '../../features/home/presentian/viewModel/category_cubit.dart';
import '../../features/home/presentian/viewModel/product_by_category_cubit.dart';
GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // dio object
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<ApiConsumer>(DioService(getIt<Dio>()));
  // all repo lazy singleton
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepoImpl(getIt<ApiConsumer>()));
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(getIt<ApiConsumer>()));
  getIt.registerLazySingleton<CategoryRepo>(() => CategoryRepoImpl(getIt<ApiConsumer>()));
  getIt.registerLazySingleton<ProductRepo>(() => ProductRepoImpl(getIt<ApiConsumer>()));
  getIt.registerLazySingleton<CartRepo>(() => CartRepoImpl(getIt<ApiConsumer>()));

  // all cubits factory
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<AuthRepository>()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt<AuthRepository>()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));
  getIt.registerFactory<CategoryCubit>(() => CategoryCubit(getIt<CategoryRepo>()));
  getIt.registerFactory<ProductByCategoryCubit>(() => ProductByCategoryCubit(getIt<ProductRepo>()));
  getIt.registerFactory<CartCubit>(() => CartCubit(getIt<CartRepo>()));

}