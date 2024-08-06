// ignore_for_file: unnecessary_string_interpolations, avoid_print

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:soft_me/core/network/dio_clients.dart';
import 'package:soft_me/data/models/transaction_model.dart';

class TransactionServices {
  final DioClients _dio = DioClients();

  Future<List<TransactionModel>> getTransaction() async {
    try {
      final response = await _dio.get(
        path: "api/transactions",
      );
      if (response.statusCode == 302) {
        final redirectUrl = response.headers.value("location");
        if (redirectUrl != null) {
          final redirectedResponse = await _dio.get(
            path: redirectUrl,
          );

          if (redirectedResponse.statusCode == 200) {
            return parseTransaction(redirectedResponse.data);
          } else {
            throw Exception("Redirection URL not found.");
          }
        } else {
          throw Exception("Redirect URL not found");
        }
      } else if (response.statusCode == 200) {
        return parseTransaction(response.data);
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print("Transaction DioException: ${e.response?.data}");
      rethrow;
    } catch (e) {
      print("Error during get: $e");
      rethrow;
    }
  }

  List<TransactionModel> parseTransaction(dynamic data) {
    List<TransactionModel> transactions = [];
    for (var transactionData in data["transactions"]) {
      try {
        transactions.add(TransactionModel.formJson(transactionData));
      } catch (e) {
        print("Error parsing transaction: $transactionData - Error: $e");
      }
    }
    return transactions;
  }

  Future addTransaction(
      DateTime date, num amount, num type, num categoryId) async {
    try {
      final response = await _dio.post(
        path: "api/transactions",
        data: {
          "date": "${DateFormat("yyy-MM-dd").format(date)}",
          "amount": amount,
          "type": 1,
          "category_id": categoryId,
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
      print("Transaction qo'shishda Error: $e");
      rethrow;
    }
  }

  Future editTransaction(int id, DateTime newDate, num newAmount, num newType, num newCategoryId) async {
    try {
      final response = await _dio.patch(
        path: "api/transactions/$id",
        data: {
          "date": "${DateFormat("yyy-MM-dd").format(newDate)}",
          "amount": newAmount,
          "type": 1,
          "category_id": newCategoryId,
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
      print("Transaction Edit Error: $e");
      rethrow;
    }
  }

  Future deleteTransaction(int id) async{
    try {
      final response = await _dio.delete(
        path: "api/transactions/$id",
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
      print("Transaction Delete Dio: ${e.response!.data}");
      rethrow;
    } catch (e) {
      print("Delete qilishda Error: $e");
    }
  }
}
