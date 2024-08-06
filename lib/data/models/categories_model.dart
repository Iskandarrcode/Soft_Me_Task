class CategoriesModel {
  final int id;
  final String name;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoriesModel({
    required this.id,
    required this.name,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      userId: json["user_id"] ?? 0,
      createdAt: json["created_at"] ?? DateTime.now(),
      updatedAt: json["updated_at"] ?? DateTime.now(),
    );
  }

  @override
  String toString() {
    return "id: $id, name: $name";
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "user_id": userId,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
