import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_me/data/core/main/main_screen.dart';
import 'package:soft_me/data/repository/category_repository.dart';
import 'package:soft_me/data/repository/transaction_repository.dart';
import 'package:soft_me/data/repository/user_repository.dart';
import 'package:soft_me/data/services/auth_dio_services.dart';
import 'package:soft_me/data/services/dio_categories_services.dart';
import 'package:soft_me/data/services/transaction_services.dart';
import 'package:soft_me/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:soft_me/logic/blocs/category_bloc/category_bloc.dart';
import 'package:soft_me/logic/blocs/transaction_bloc/transaction_bloc.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) =>
              UserRepository(dioUserService: AuthDioServices()),
        ),
        RepositoryProvider<CategoryRepository>(
          create: (context) => CategoryRepository(
            dioCategoriesServices: DioCategoriesServices(),
          ),
        ),
        RepositoryProvider<TransactionRepository>(
          create: (context) => TransactionRepository(
            dioTransactionServices: TransactionServices(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) {
              return AuthBloc(
                usersRepository: context.read<UserRepository>(),
              );
            },
          ),
          BlocProvider<CategoryBloc>(
            create: (context) {
              return CategoryBloc(
                categoryRepository: context.read<CategoryRepository>(),
              );
            },
          ),
          BlocProvider<TransactionBloc>(
            create: (context) {
              return TransactionBloc(
                transactionRepository: context.read<TransactionRepository>(),
              );
            },
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
