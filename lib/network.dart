import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Network {


  getUser() async {
    Dio dio = Dio()..interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        error: true,
        responseHeader: true,
        responseBody: true,
      ),
    );
    try{
    final response = await dio.get('https://dummyjson.com/users');
    print(response.data);
    } on DioException catch (e) {
      print('the status cod ${e.response?.statusCode} and the error is ${e.message}');
    }
  }
}