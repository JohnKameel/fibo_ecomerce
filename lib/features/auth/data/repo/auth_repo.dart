// import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
//
// import '../model/user_model.dart';
//
// class AuthNetwork {
//   Dio dio = Dio()
//     ..interceptors.add(
//       PrettyDioLogger(
//         request: true,
//         requestHeader: true,
//         requestBody: true,
//         error: true,
//         responseHeader: true,
//         responseBody: true,
//       ),
//     );
//
//   Future<UserModel> loginUser(String username, String password) async {
//     try {
//       final response = await dio.post(
//         'https://dummyjson.com/user/login',
//         data: {
//           'username': username,
//           'password': password,
//         },
//       );
//       final user = UserModel.fromJson(response.data);
//       return user;
//     } on DioException catch (e) {
//       throw Exception(
//         'Login failed: ${e.response?.statusCode} - ${e.message}',
//       );
//     }
//   }
//
//   Future<UserModel> registerUser(String username, String password, String email) async {
//     try {
//       final response = await dio.post(
//         'https://dummyjson.com/users/add',
//         data: {
//           'email': email,
//           'username': username,
//           'password': password,
//         },
//       );
//       final user = UserModel.fromJson(response.data);
//       return user;
//     } on DioException catch (e) {
//       throw Exception(
//         'Registration failed: ${e.response?.statusCode} - ${e.message}',
//       );
//     }
//   }
// }
