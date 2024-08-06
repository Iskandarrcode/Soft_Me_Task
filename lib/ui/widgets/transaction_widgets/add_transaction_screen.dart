import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:soft_me/logic/blocs/category_bloc/category_bloc.dart';
import 'package:soft_me/logic/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:soft_me/logic/blocs/transaction_bloc/transaction_event.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AddTransactionScreen extends StatefulWidget {
  final bool isAdd;
  final int transactionId;
  final double transactionAmount;

  const AddTransactionScreen({
    super.key,
    required this.isAdd,
    required this.transactionId,
    required this.transactionAmount,
    required double transactionAmout,
  });

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late int type = 0;
  late num categoryId = 0;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(139, 44, 79, 107),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey.shade300),
        backgroundColor: const Color.fromARGB(0, 44, 79, 107),
        centerTitle: true,
        title: widget.isAdd
            ? Text(
                "Add Transaction",
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Text(
                "Edit Transaction",
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontWeight: FontWeight.bold,
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
              child: Text(
                state.message,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          if (state is LoadedCategoryState) {
            if (!widget.isAdd) {
              nameController.text = widget.transactionAmount.toString();
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Colors.grey.shade300,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        labelText: widget.isAdd ? "Amount" : "New Amount",
                        labelStyle: TextStyle(color: Colors.grey.shade300),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Input Amount";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            type = 0;
                          });
                        },
                        child: const Text(
                          "Income",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            type = 1;
                          });
                        },
                        child: const Text(
                          "Expense",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Choose Category",
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: SizedBox(
                      child: MasonryGridView.builder(
                        itemCount: state.categories.length,
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: ZoomTapAnimation(
                              onTap: () {
                                categoryId = state.categories[index].id;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: const Color.fromARGB(108, 10, 6, 6),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      top: 7,
                                      bottom: 7,
                                    ),
                                    child: Text(
                                      state.categories[index].name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  ZoomTapAnimation(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        if (widget.isAdd) {
                          context.read<TransactionBloc>().add(
                                AddTransactionEvent(
                                  date: DateTime.now(),
                                  amount: num.parse(nameController.text),
                                  type: type,
                                  categoryId: categoryId,
                                ),
                              );
                          Navigator.pop(context);
                          nameController.clear();
                        } else {
                          context.read<TransactionBloc>().add(
                                EditTransactionEvent(
                                  id: widget.transactionId,
                                  date: DateTime.now(),
                                  amount: num.parse(nameController.text),
                                  type: type,
                                  categoryId: categoryId,
                                ),
                              );
                          Navigator.pop(context);
                          nameController.clear();
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromARGB(255, 16, 66, 106),
                      ),
                      child: widget.isAdd
                          ? const Center(
                              child: Text(
                                "Add",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
