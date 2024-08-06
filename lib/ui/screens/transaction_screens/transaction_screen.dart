import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_me/logic/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:soft_me/logic/blocs/transaction_bloc/transaction_event.dart';
import 'package:soft_me/logic/blocs/transaction_bloc/transaction_state.dart';
import 'package:soft_me/ui/widgets/transaction_widgets/add_transaction_screen.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey.shade300),
        backgroundColor: const Color.fromARGB(0, 44, 79, 107),
        title: Text(
          "Transactions Management",
          style: TextStyle(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(139, 44, 79, 107),
      body: BlocBuilder<TransactionBloc, TransactionStates>(
        bloc: context.read<TransactionBloc>()..add(GetTransactionEvent()),
        builder: (context, state) {
          if (state is LoadingTransactionState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorTransationState) {
            return Center(
              child: Text("Error Transaction: ${state.message}"),
            );
          }
          if (state is LoadedTransactionState) {
            if (state.transactions.isEmpty) {
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
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                final transaction = state.transactions[index];
                return ListTile(
                  title: Text(
                    transaction.amount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    transaction.date.toString(),
                    style: TextStyle(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return AddTransactionScreen(
                                isAdd: false,
                                transactionAmout:
                                    state.transactions[index].amount,
                                transactionId: state.transactions[index].id!,
                              );
                            },
                          ));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<TransactionBloc>().add(
                                DeleteTransactionEvent(id: transaction.id!),
                              );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text("Transaction Mavjud emas..."),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 7, 112, 198),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const AddTransactionScreen(
                isAdd: true,
                transactionAmout: 0,
                transactionId: 0,
              );
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
