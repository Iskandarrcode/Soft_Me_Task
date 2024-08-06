class TransactionModel {
  final int? id;
  final DateTime date;
  final double amount;
  final num type;
  final int categoryId;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TransactionModel({
    this.id,
    required this.date,
    required this.amount,
    required this.type,
    required this.categoryId,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory TransactionModel.formJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json["id"] != null ? int.tryParse(json["id"].toString()) : null,
      date: json["date"] != null ? DateTime.parse(json["date"]) : DateTime.now(),
      amount: json["amount"] != null ? double.tryParse(json["amount"].toString()) ?? 0.0 : 0.0,
      type: json["type"] != null ? num.tryParse(json["type"].toString()) ?? 0 : 0,
      categoryId: json["category_id"] != null ? int.tryParse(json["category_id"].toString()) ?? 0 : 0,
      userId: json["user_id"] != null ? int.tryParse(json["user_id"].toString()) : null,
      createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
      updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "date": date.toIso8601String(),
      "amount": amount,
      "type": type,
      "category_id": categoryId,
      "user_id": userId,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
    };
  }
}
