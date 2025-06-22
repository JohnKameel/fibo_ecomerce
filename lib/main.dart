import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fido_e/core/network/api_consumer.dart';
import 'package:fido_e/core/network/dio_service.dart';
import 'package:fido_e/core/server_locator/server_locator.dart';
import 'package:fido_e/features/auth/data/repo/auth_repo_impl.dart';
import 'package:fido_e/features/auth/data/repo/auth_repository.dart';
import 'package:fido_e/features/auth/presentian/viewModel/login_cubit.dart';
import 'package:fido_e/features/auth/presentian/viewModel/register_cubit.dart';
import 'package:fido_e/features/cart/data/repo/cart_repo.dart';
import 'package:fido_e/features/cart/presentation/viewModel/cart_cubit.dart';
import 'package:fido_e/features/home/data/repo/category_repo_impl.dart';
import 'package:fido_e/features/home/data/repo/home_repo.dart';
import 'package:fido_e/features/home/data/repo/product_repo.dart';
import 'package:fido_e/features/home/presentian/viewModel/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'core/routing/router_app.dart';
import 'features/cart/data/repo/cart_repo_impl.dart';
import 'features/home/data/repo/category_repo.dart';
import 'features/home/data/repo/home_repo_impl.dart';
import 'features/home/data/repo/product_repo_impl.dart';
import 'features/home/presentian/viewModel/home_cubit.dart';
import 'features/home/presentian/viewModel/product_by_category_cubit.dart';
import 'generated/codegen_loader.g.dart';
import 'generated/locale_keys.g.dart';
import 'network.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setupServiceLocator();
  // make image cache work    ---- package flutter_cache_image
  Dio dio = Dio();
  ApiConsumer apiConsumer = DioService(dio);
  AuthRepository authRepository = AuthRepoImpl(apiConsumer);
  HomeRepo homeRepo = HomeRepoImpl(apiConsumer);
  CategoryRepo categoryRepo = CategoryRepoImpl(apiConsumer);
  ProductRepo productRepo = ProductRepoImpl(apiConsumer);
  CartRepo cartRepo = CartRepoImpl(apiConsumer);


  runApp(EasyLocalization(
    path: "assets/translations",
    supportedLocales: const [Locale('en'), Locale('ar')],
    fallbackLocale: const Locale('en'),
    assetLoader: const CodegenLoader(),
    child: MultiBlocProvider(
      providers: [
        BlocProvider( // getIt<LoginCubit>(),
          create: (context) => getIt<LoginCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<RegisterCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<HomeCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CategoryCubit>()..getAllCategories(),
        ),
        BlocProvider(
          create: (context) => getIt<ProductByCategoryCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CartCubit>(),
        ),
      ],
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return MaterialApp.router(
            routerConfig: RouterApp.goRoute,
            title: 'Fibo Ecommerce',
            debugShowCheckedModeBanner: false,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context
                .localizationDelegates, // to know direction of text and format
          );
        });
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.language),
//             onPressed: () {
//               if (context.locale.languageCode == 'en') {
//                 context.setLocale(const Locale('ar'));
//               } else {
//                 context.setLocale(const Locale('en'));
//               }
//             },
//           ),
//           IconButton(
//             onPressed: () {
//               context.push(RouterApp.home);
//             },
//             icon: Icon(Icons.add_circle_outline),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Text(LocaleKeys.Auth_username.tr()),
//       ),
//     );
//   }
// }


class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}