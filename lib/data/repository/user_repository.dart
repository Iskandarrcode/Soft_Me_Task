import 'package:flutter/material.dart';
import 'package:soft_me/data/services/auth_dio_services.dart';

class UserRepository {
  final AuthDioServices _dioUserServices;

  UserRepository({required AuthDioServices dioUserService})
      : _dioUserServices = dioUserService;

  Future<bool> registerUser(
      String name, String surName, String userName, String password) async {
    return _dioUserServices.registerUser(
      name,
      surName,
      userName,
      password,
    );
  }

  Future<bool> loginUser(String userName, String password) async {
    return _dioUserServices.loginUser(userName, password);
  }

  Future logOut(BuildContext context) async {
    return _dioUserServices.logout(context);
  }
}
