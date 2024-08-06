import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_me/logic/blocs/category_bloc/category_bloc.dart';
import 'package:soft_me/ui/widgets/categoryes_widgets/alert_dialog_add_edit.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(139, 44, 79, 107),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey.shade300),
        backgroundColor: const Color.fromARGB(0, 44, 79, 107),
        title: Text(
          "Category Management",
          style: TextStyle(
            color: Colors.grey.shade300,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AlertDialogAddEdit(
                  isAdd: true,
                  categoryid: 0,
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
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
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      category.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      category.id.toString(),
                      style: TextStyle(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialogAddEdit(
                                isAdd: false,
                                categoryid: category.id,
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<CategoryBloc>().add(
                                  DeleteCategoryEvent(id: category.id),
                                );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
