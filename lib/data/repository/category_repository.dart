import 'package:soft_me/data/models/categories_model.dart';
import 'package:soft_me/data/services/dio_categories_services.dart';

class CategoryRepository {
  final DioCategoriesServices _dioCategoriesServices;

  CategoryRepository({required DioCategoriesServices dioCategoriesServices})
      : _dioCategoriesServices = dioCategoriesServices;

  Future<List<CategoriesModel>> getCategories() async {
    return _dioCategoriesServices.getCategories();
  }

  Future addCategories(String name) async {
    return _dioCategoriesServices.addCategories(name);
  }

  Future editCategories(int id, String newName) async {
    return _dioCategoriesServices.editCategories(id, newName);
  }

  Future deleteCategories(int id) async {
    return _dioCategoriesServices.deleteCategories(id);
  }
}
