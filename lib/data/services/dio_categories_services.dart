// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:soft_me/core/network/dio_clients.dart';
import 'package:soft_me/data/models/categories_model.dart';

class DioCategoriesServices {
  final DioClients _dio = DioClients();

  Future<List<CategoriesModel>> getCategories() async {
    try {
      final response = await _dio.get(
        path: "api/categories",
      );

      if (response.statusCode == 302) {
        final redirectUrl = response.headers.value("location");
        if (redirectUrl != null) {
          final redirectedResponse = await _dio.get(
            path: redirectUrl,
          );

          if (redirectedResponse.statusCode == 200) {
            return parseCategories(redirectedResponse.data);
          } else {
            throw Exception("Redirection URL not found.");
          }
        } else {
          throw Exception("Url Manzili topilmadi");
        }
      } else if (response.statusCode == 200) {
        return parseCategories(response.data);
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print("Category DioException: ${e.response!.data}");
      rethrow;
    } catch (e) {
      print("Get Qilishda Error: $e");
      rethrow;
    }
  }

  List<CategoriesModel> parseCategories(dynamic data) {
    List<CategoriesModel> categories = [];
    for (var categoryData in data["categories"]) {
      categories.add(CategoriesModel.fromJson(categoryData));
    }
    return categories;
  }

  Future addCategories(String name) async {
    try {
      final response = await _dio.post(
        path: "api/categories",
        data: {
          "name": name,
        },
      );
      if (response.statusCode == 302) {
        final redirectUrl = response.headers.value('location');
        if (redirectUrl != null) {
          // Yo'naltirilgan URL ga so'rov yuborish
          final redirectedResponse = await _dio.get(
            path: redirectUrl,
          );
          // Yangi so'rovni qayta ishlash
          if (redirectedResponse.statusCode == 200) {
            return response.data;
          }
        } else {
          throw Exception('URL topilmadi');
        }
        return response.data;
      }
      return response.data;
    } catch (e) {
      print("Category qo'shishda Error: $e");
      rethrow;
    }
  }

  Future editCategories(int id, String newName) async {
    try {
      final response = await _dio.patch(
        path: "api/categories/$id",
        data: {
          "name": newName,
        },
      );

      if (response.statusCode == 302) {
        final redirectUrl = response.headers.value('location');
        if (redirectUrl != null) {
          final redirectedResponse = await _dio.get(
            path: redirectUrl,
          );
          if (redirectedResponse.statusCode == 200) {
            return response.data;
          }
        } else {
          throw Exception('URL topilmadi');
        }
        return response.data;
      }
      return response.data;
    } on DioException catch (e) {
      print("Category Edit Dio: ${e.response!.data}");
      rethrow;
    } catch (e) {
      print("Edit qilishda Error: $e");
    }
  }

  Future deleteCategories(int id) async {
    try {
      final response = await _dio.delete(
        path: "api/categories/$id",
      );

      if (response.statusCode == 302) {
        final redirectUrl = response.headers.value('location');
        if (redirectUrl != null) {
          final redirectedResponse = await _dio.get(
            path: redirectUrl,
          );
          if (redirectedResponse.statusCode == 200) {
            return response.data;
          }
        } else {
          throw Exception('URL topilmadi');
        }
        return response.data;
      }
      return response.data;
    } on DioException catch (e) {
      print("Category Delete Dio: ${e.response!.data}");
      rethrow;
    } catch (e) {
      print("Delete qilishda Error: $e");
    }
  }
}
