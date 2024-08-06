import 'package:bloc/bloc.dart';
import 'package:soft_me/data/repository/category_repository.dart';
import 'package:soft_me/data/models/categories_model.dart';
part "category_event.dart";
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(InitialCategoryState()) {
    on<GetCategoryEvent>(_getCategory);
    on<AddCategoryEvent>(_addCategory);
    on<EditCategoryEvent>(_editCategory);
    on<DeleteCategoryEvent>(_deleteCategory);
  }

  void _getCategory(GetCategoryEvent event, Emitter emit) async {
    emit(LoadingCategoryState());
    try {
      final categories = await _categoryRepository.getCategories();
      emit(LoadedCategoryState(categories: categories));
    } catch (e) {
      emit(ErrorCategoryState(message: e.toString()));
    }
  }

  void _addCategory(AddCategoryEvent event, Emitter emit) async {
    List<CategoriesModel> categories =
        (state as LoadedCategoryState).categories;

    emit(LoadingCategoryState());
    try {
      final category = await _categoryRepository.addCategories(event.name);
      //category larni olib
      print("Category Add in bloc ${category["category"]}");
      categories.add(CategoriesModel.fromJson(category['category']));
      emit(LoadedCategoryState(categories: categories));
    } catch (e) {
      print("Category qo'shish Bloc : $e");
      emit(ErrorCategoryState(message: e.toString()));
    }
  }

  void _editCategory(EditCategoryEvent event, Emitter emit) async {
    try {
      await _categoryRepository.editCategories(event.id, event.newName);
      add(GetCategoryEvent());
    } catch (e) {
      print("Category Edit qilishda Xatolik: $e");
      emit(ErrorCategoryState(message: e.toString()));
    }
  }

  void _deleteCategory(DeleteCategoryEvent event, Emitter emit) async {
    try {
      await _categoryRepository.deleteCategories(event.id);
      add(GetCategoryEvent());
    } catch (e) {
      emit(ErrorCategoryState(message: e.toString()));
    }
  }
}
