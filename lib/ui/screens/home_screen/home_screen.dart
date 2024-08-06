import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_me/logic/blocs/category_bloc/category_bloc.dart';
import 'package:soft_me/logic/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:soft_me/logic/blocs/transaction_bloc/transaction_event.dart';
import 'package:soft_me/logic/blocs/transaction_bloc/transaction_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 44, 79, 107),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 44, 79, 107),
        centerTitle: true,
        title: Text(
          "Transactions",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade400,
          ),
        ),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        bloc: context.read<CategoryBloc>()..add(GetCategoryEvent()),
        builder: (context, state) {
          if (state is LoadingCategoryState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorCategoryState) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is LoadedCategoryState) {
            if (state.categories.isEmpty) {
              return const Center(
                child: Text(
                  "Categoriyalar mavjud emas...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              );
            }
            return DefaultTabController(
              length: state.categories.length,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    tabs: state.categories
                        .map(
                          (category) => Tab(text: category.name),
                        )
                        .toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: state.categories.map(
                        (category) {
                          return BlocBuilder<TransactionBloc,
                              TransactionStates>(
                            bloc: context.read<TransactionBloc>()
                              ..add(GetTransactionEvent()),
                            builder: (context, trState) {
                              if (trState is LoadingTransactionState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (trState is ErrorTransationState) {
                                return Center(
                                  child: Text(trState.message),
                                );
                              }
                              if (trState is LoadedTransactionState) {
                                final transactions = trState.transactions
                                    .where((transaction) =>
                                        transaction.categoryId == category.id)
                                    .toList();

                                if (transactions.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      "Transactionlar mavjud emas...",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: transactions.length,
                                  itemBuilder: (context, index) {
                                    final transaction = transactions[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        title: Text(
                                          transaction.amount.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        subtitle: Text(
                                          transaction.date.toIso8601String(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              return const SizedBox();
                            },
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text("Categoriyalar mavjud emas"),
          );
        },
      ),
    );
  }
}
