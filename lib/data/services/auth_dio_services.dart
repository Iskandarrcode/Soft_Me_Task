// ignore_for_file: avoid_print, unused_local_variable, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soft_me/data/core/network/dio_clients.dart';
import 'package:soft_me/ui/screens/login_register_screen/login_screen.dart';

class AuthDioServices {
  final _dio = DioClients();

  Future<bool> registerUser(
      String name, String surName, String userName, String password) async {
    try {
      final response = await _dio.post(
        path: "api/register",
        data: {
          "name": name,
          "surname": surName,
          "username": userName,
          "password": password,
        },
      );
      print(response.statusMessage);
      if (response.statusMessage == "Found") {
        throw "Foydalanuvchi Ro'yxatdan O'tgan";
      }

      return response.data["status"];
    } on DioException catch (e) {
      print('Register DioException: ${e.message}');
      rethrow;
    } catch (e) {
      print('Register Error: $e');
      rethrow;
    }
  }

  Future<bool> loginUser(String userName, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await _dio.post(
        path: "api/login",
        data: {
          "username": userName,
          "password": password,
        },
      );

      if (response.data["token"] != null) {
        // sharedPreferences ga saqlanyabdi token
        await prefs.setString('token', response.data["token"]);
        String stringValueToken = prefs.getString('token') ?? 'token kelmadi';
      }
      if (response.data["token"] == null) {
        print(".............Token Kelmadi..............");
      }

      if (response.statusCode == 302) {
        final redirectUrl = response.headers.value('location');
        if (redirectUrl != null) {
          // Yo'naltirilgan URL ga so'rov yuborish
          final redirectedResponse = await _dio.get(
            path: redirectUrl,
          );
          // Yangi so'rovni qayta ishlash
          if (redirectedResponse.statusCode == 200) {
            print('Muvafaqiyatli yonaltrildi javob');
            return response.data["status"];
          }
        } else {
          throw Exception('URL topilmadi');
        }
        return response.data["status"];
      }
      return response.data['status'];
    } catch (e) {
      print("Login Qilishda Error: $e");
      rethrow;
    }
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => route is LoginScreen,
    );
  }
}
