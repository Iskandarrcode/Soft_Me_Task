part of "category_bloc.dart";

sealed class CategoryEvent {}

final class GetCategoryEvent extends CategoryEvent {}

final class AddCategoryEvent extends CategoryEvent {
  final String name;
  AddCategoryEvent({required this.name});
}

final class EditCategoryEvent extends CategoryEvent {
  final int id;
  final String newName;
  EditCategoryEvent({required this.id, required this.newName});
}

final class DeleteCategoryEvent extends CategoryEvent {
  final int id;
  DeleteCategoryEvent({required this.id});
}
