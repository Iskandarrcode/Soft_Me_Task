import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClients {
  final Dio _dio;

  DioClients()
      : _dio = Dio(
          BaseOptions(
            baseUrl: "https://online.atomic.uz/",
            followRedirects: true,
            validateStatus: (status) {
              return status != null && (status < 500 || status == 302);
            },
          ),
        );

  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await _dio.get(
        path,
        queryParameters: queryParams,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      rethrow;
    } catch (e) {
      print('General Exception: $e');
      rethrow;
    }
  }

  Future<Response> post({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await _dio.post(
        path,
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      print('DioException: ${e.response!.data}');
      rethrow;
    } catch (e) {
      print('General Exception: $e');
      rethrow;
    }
  }

  Future<Response> patch({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await _dio.put(
        path,
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      print("Dio Clients Error: $e");
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete({
    required String path,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await _dio.delete(
        path,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      print("Dio Clients Delete Error: $e");
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
