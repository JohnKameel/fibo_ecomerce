import 'package:dio/dio.dart';
import 'package:fido_e/core/network/api_consumer.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioService implements ApiConsumer {
  final Dio _dio;
  DioService(this._dio) {
    _dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        error: true,
        responseHeader: true,
        responseBody: true,
      ),
    );
  }

  @override
  Future post(String url, Map<String, dynamic> body) async {
    try {
      final response = await _dio.post(url, data: body);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future delete(String url, Map<String, dynamic> body) async {
    try {
      final response = await _dio.delete(url, data: body);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future get(String url, Map<String, dynamic> body) async {
    try {
      final response = await _dio.get(url, data: body);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future put(String url, Map<String, dynamic> body) async {
    try {
      final response = await _dio.put(url, data: body);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
