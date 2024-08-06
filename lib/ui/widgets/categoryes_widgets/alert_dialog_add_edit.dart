import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_me/logic/blocs/category_bloc/category_bloc.dart';

class AlertDialogAddEdit extends StatefulWidget {
  final bool isAdd;
  final int categoryid;
  const AlertDialogAddEdit({
    super.key,
    required this.isAdd,
    required this.categoryid,
  });

  @override
  State<AlertDialogAddEdit> createState() => _AlertDialogAddEditState();
}

class _AlertDialogAddEditState extends State<AlertDialogAddEdit> {
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 26, 64, 95),
      title: widget.isAdd
          ? Text(
              "Add Category",
              style: TextStyle(color: Colors.grey.shade300),
            )
          : Text(
              "Edit Category",
              style: TextStyle(color: Colors.grey.shade300),
            ),
      actions: [
        const SizedBox(height: 10),
        Form(
          key: formKey,
          child: TextFormField(
            controller: nameController,
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.grey.shade300,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              labelText: widget.isAdd ? "Name" : "NewName",
              labelStyle: const TextStyle(color: Colors.grey),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 1.0,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Input Category Name";
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (widget.isAdd) {
                    context.read<CategoryBloc>().add(
                          AddCategoryEvent(
                            name: nameController.text,
                          ),
                        );
                    Navigator.pop(context);
                    nameController.clear();
                  } else {
                    context.read<CategoryBloc>().add(
                          EditCategoryEvent(
                            id: widget.categoryid,
                            newName: nameController.text,
                          ),
                        );
                    Navigator.pop(context);
                    nameController.clear();
                  }
                }
              },
              child: widget.isAdd ? const Text("Add") : const Text("Edit"),
            ),
          ],
        ),
      ],
    );
  }
}
